#!/usr/bin/env ruby
# frozen_string_literal: true
#
# 各 Configuration の baseConfigurationReference を新しい
# Flutter/<ConfigName>.xcconfig へ張り直す。
# Phase 1B の一部として一度だけ実行する想定。

require 'xcodeproj'

REPO_ROOT = File.expand_path('..', __dir__)
PROJ_PATH = File.join(REPO_ROOT, 'platza/ios/Runner.xcodeproj')

def find_or_add_flutter_xcconfig(project, name)
  flutter_group = project.main_group.find_subpath('Flutter', false)
  raise 'Flutter group not found' unless flutter_group

  existing = flutter_group.files.find { |f| f.path == "Flutter/#{name}.xcconfig" }
  return existing if existing

  ref = flutter_group.new_reference("Flutter/#{name}.xcconfig", :group)
  ref.last_known_file_type = 'text.xcconfig'
  ref
end

def wire(target_or_project, name)
  list = target_or_project.build_configuration_list
  list.build_configurations.each do |c|
    next unless %w[Debug-prod Debug-dev Release-prod Release-dev Profile-prod Profile-dev].include?(c.name)
    ref = find_or_add_flutter_xcconfig(target_or_project.project, c.name)
    c.base_configuration_reference = ref
  end
end

def remove_legacy_files(project)
  flutter_group = project.main_group.find_subpath('Flutter', false)
  return unless flutter_group

  %w[Debug Release Profile].each do |legacy|
    file = flutter_group.files.find { |f| f.path == "Flutter/#{legacy}.xcconfig" }
    file&.remove_from_project
  end
end

def main
  project = Xcodeproj::Project.open(PROJ_PATH)

  # Runner ターゲットだけ baseConfigurationReference を張り直す。
  # RunnerTests は Pods-RunnerTests xcconfig を直接参照しており、Flutter/ 側には xcconfig がない。
  runner = project.targets.find { |t| t.name == 'Runner' }
  raise 'Runner target not found' unless runner

  wire(runner, 'Runner')
  remove_legacy_files(project)

  project.save
  puts 'wired'
end

main if __FILE__ == $PROGRAM_NAME
