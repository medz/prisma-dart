#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint prisma_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'orm_flutter'
  s.version          = '0.0.1'
  s.summary          = 'The engine of Prisma ORM for Flutter.'
  s.description      = <<-DESC
The engine of Prisma ORM for Flutter, Library for binding Prisma's C-Abi engine with Flutter.
                       DESC
  s.homepage         = 'https://prisma.pub'
  s.license          = { :file => '../LICENSE', :type => "BSD-3" }
  s.author           = { 'Odroe Inc.' => 'hello@odroe.dev' }

  s.prepare_command = <<-CMD
    cd ..
    dart run orm_flutter:dl_engine
    cd -
  CMD

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.vendored_frameworks = 'Frameworks/QueryEngine.xcframework'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
