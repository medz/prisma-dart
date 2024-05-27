#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint prisma_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'prisma_flutter'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'https://odroe.dev'
  s.license          = { :type => 'BSD-3', :file => '../LICENSE' }
  s.author           = { 'Odroe Inc.' => 'hello@odroe.dev' }
  s.source           = { :path => '.' }

  s.public_header_files = 'QueryEngine.xcframework/ios-arm64/Headers/query_engine.h'
  s.vendored_libraries = 'QueryEngine.xcframework/ios-arm64/libquery_engine.a'

  #s.preserve_paths = 'QueryEngine.xcframework'
  #s.vendored_frameworks = 'QueryEngine.xcframework'

  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
