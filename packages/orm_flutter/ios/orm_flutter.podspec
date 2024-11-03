require 'yaml'

pubspec = YAML.load_file(
  File.join(__dir__, '../pubspec.yaml')
)

#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint prisma_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = pubspec['name']
  s.version          = pubspec['version']
  s.summary          = 'The engine of Prisma ORM for Flutter.'
  s.description      = pubspec['description']
  s.homepage         = pubspec['homepage']
  s.license          = { :file => '../LICENSE', :type => "BSD-3" }
  s.author           = { 'Odroe Inc.' => 'hello@odroe.dev' }

  s.source           = { :path => '.' }
  s.source_files = 'orm_flutter/Sources/orm_flutter/**/*'
  s.dependency 'Flutter'
  s.vendored_frameworks = 'orm_flutter/Frameworks/QueryEngine.xcframework'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
