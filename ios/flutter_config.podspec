#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_config'
  s.version          = '0.0.1'
  s.summary          = 'Config Variables for your Flutter Apps.'
  s.description      = <<-DESC
Config Variables for your Flutter Apps.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  # s.ios.deployment_target = '10.0'
  s.script_phase = {
    name: 'Config codegen',
    script: %(
set -ex
HOST_PATH="$SRCROOT/../"
"${PODS_TARGET_SRCROOT}/Classes/BuildDotenvConfig.rb" "$HOST_PATH" "${PODS_TARGET_SRCROOT}/Classes"
),
    execution_position: :before_compile,
    input_files: ['$(SRCROOT)/Classes/BuildDotenvConfig.rb']
  }
end

