#!/usr/bin/env ruby
# frozen_string_literal: true
#
# iOS Xcode プロジェクトに dev / prod flavor を構成するワンショットスクリプト。
#
# 既存 Debug / Release / Profile を Debug-prod / Release-prod / Profile-prod へ
# リネームし、Debug-dev / Release-dev / Profile-dev を新規追加する。
# 加えて Runner.xcscheme を prod.xcscheme と dev.xcscheme に置き換える。
#
# このスクリプトは「[開発環境 / 本番環境の整備](https://www.notion.so/34b4d8c8051681d1a40dfc30d1f25bdf)」
# Phase 1B の一部として一度だけ実行される想定。再実行はしない。

require 'fileutils'
require 'xcodeproj'

REPO_ROOT = File.expand_path('..', __dir__)
PROJ_PATH = File.join(REPO_ROOT, 'platza/ios/Runner.xcodeproj')
SCHEMES_DIR = File.join(PROJ_PATH, 'xcshareddata/xcschemes')

DEV_BUNDLE_ID = 'com.nakanojunya.platza.dev'
DEV_DISPLAY_NAME = 'Platza dev'
DEV_APP_ICON = 'AppIcon-dev'

CONFIG_TYPES = {
  'Debug' => :debug,
  'Release' => :release,
  'Profile' => :release, # Profile は Release ベース
}.freeze

def rename_existing_to_prod(project)
  rename = lambda do |list|
    list.build_configurations.each do |c|
      case c.name
      when 'Debug'   then c.name = 'Debug-prod'
      when 'Release' then c.name = 'Release-prod'
      when 'Profile' then c.name = 'Profile-prod'
      end
    end
    list.default_configuration_name = 'Release-prod' if list.default_configuration_name == 'Release'
  end

  rename.call(project.build_configuration_list)
  project.targets.each { |t| rename.call(t.build_configuration_list) }
end

def add_dev_configurations(project)
  %w[Debug Release Profile].each do |base|
    prod_name = "#{base}-prod"
    dev_name = "#{base}-dev"
    type = CONFIG_TYPES[base]

    # プロジェクトレベル
    proj_prod = project.build_configurations.find { |c| c.name == prod_name }
    raise "project-level #{prod_name} not found" unless proj_prod

    proj_dev = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
    proj_dev.name = dev_name
    proj_dev.build_settings = proj_prod.build_settings.dup
    project.build_configuration_list.build_configurations << proj_dev

    # 各ターゲットレベル
    project.targets.each do |target|
      target_prod = target.build_configurations.find { |c| c.name == prod_name }
      raise "#{target.name} #{prod_name} not found" unless target_prod

      target_dev = project.new(Xcodeproj::Project::Object::XCBuildConfiguration)
      target_dev.name = dev_name
      target_dev.build_settings = deep_dup(target_prod.build_settings)
      target_dev.base_configuration_reference = target_prod.base_configuration_reference

      apply_dev_overrides(target, target_dev, base)
      target.build_configuration_list.build_configurations << target_dev
    end
  end
end

def apply_dev_overrides(target, dev_config, base)
  case target.name
  when 'Runner'
    dev_config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = DEV_BUNDLE_ID
    dev_config.build_settings['INFOPLIST_KEY_CFBundleDisplayName'] = DEV_DISPLAY_NAME
    dev_config.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = DEV_APP_ICON

    # Release-dev / Profile-dev は Automatic signing にする。
    # dev 用の Manual プロビジョニングプロファイルがまだ無いため。
    if %w[Release Profile].include?(base)
      dev_config.build_settings.delete('PROVISIONING_PROFILE_SPECIFIER')
      dev_config.build_settings.delete('CODE_SIGN_IDENTITY[sdk=iphoneos*]')
      dev_config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
    end
  when 'RunnerTests'
    base_id = dev_config.build_settings['PRODUCT_BUNDLE_IDENTIFIER']
    if base_id && !base_id.end_with?('.dev')
      dev_config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = "#{base_id}.dev"
    end
  end
end

def deep_dup(obj)
  case obj
  when Hash  then obj.transform_values { |v| deep_dup(v) }
  when Array then obj.map { |v| deep_dup(v) }
  else obj.dup rescue obj
  end
end

def write_scheme(name, suffix)
  scheme_path = File.join(SCHEMES_DIR, "#{name}.xcscheme")
  FileUtils.cp(File.join(SCHEMES_DIR, '_template.xcscheme'), scheme_path)
  text = File.read(scheme_path)
  text = text
         .gsub('"Debug"',   "\"Debug-#{suffix}\"")
         .gsub('"Release"', "\"Release-#{suffix}\"")
         .gsub('"Profile"', "\"Profile-#{suffix}\"")
  File.write(scheme_path, text)
  puts "scheme: #{scheme_path}"
end

def setup_schemes
  runner_scheme = File.join(SCHEMES_DIR, 'Runner.xcscheme')
  raise 'Runner.xcscheme not found' unless File.exist?(runner_scheme)

  template_path = File.join(SCHEMES_DIR, '_template.xcscheme')
  FileUtils.mv(runner_scheme, template_path)

  write_scheme('prod', 'prod')
  write_scheme('dev', 'dev')

  File.delete(template_path)
end

def main
  raise "project not found at #{PROJ_PATH}" unless Dir.exist?(PROJ_PATH)

  project = Xcodeproj::Project.open(PROJ_PATH)

  # 既に flavor 化済みなら何もしない（冪等性確保）
  if project.build_configurations.any? { |c| c.name == 'Debug-dev' }
    puts 'already set up; nothing to do'
    return
  end

  rename_existing_to_prod(project)
  add_dev_configurations(project)
  project.save

  setup_schemes

  puts 'done'
end

main if __FILE__ == $PROGRAM_NAME
