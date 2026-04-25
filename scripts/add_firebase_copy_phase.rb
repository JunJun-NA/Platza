#!/usr/bin/env ruby
# frozen_string_literal: true
#
# Runner ターゲットに「Copy GoogleService-Info.plist (flavor)」の Run Script
# Build Phase を追加するワンショットスクリプト。
# Configuration 名 (Debug-dev / Release-prod など) から flavor を判定し
# ios/Runner/Firebase/<flavor>/GoogleService-Info.plist を Runner.app へコピーする。

require 'xcodeproj'

REPO_ROOT = File.expand_path('..', __dir__)
PROJ_PATH = File.join(REPO_ROOT, 'platza/ios/Runner.xcodeproj')
PHASE_NAME = 'Copy GoogleService-Info.plist (flavor)'

def main
  project = Xcodeproj::Project.open(PROJ_PATH)
  runner = project.targets.find { |t| t.name == 'Runner' }
  raise 'Runner target not found' unless runner

  if runner.shell_script_build_phases.any? { |p| p.name == PHASE_NAME }
    puts 'phase already exists; skipping'
    return
  end

  phase = runner.new_shell_script_build_phase(PHASE_NAME)
  phase.shell_path = '/bin/sh'
  phase.shell_script = '"$SRCROOT/scripts/copy_firebase_config.sh"' + "\n"
  phase.input_paths = [
    '$(SRCROOT)/Runner/Firebase/dev/GoogleService-Info.plist',
    '$(SRCROOT)/Runner/Firebase/prod/GoogleService-Info.plist',
  ]
  phase.output_paths = [
    '$(BUILT_PRODUCTS_DIR)/$(PRODUCT_NAME).app/GoogleService-Info.plist',
  ]

  # Copy Bundle Resources の後に来るよう末尾へ追加（new_shell_script_build_phase は末尾追加）。
  project.save
  puts 'added build phase'
end

main if __FILE__ == $PROGRAM_NAME
