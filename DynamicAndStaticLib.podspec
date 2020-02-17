#
# Be sure to run `pod lib lint DynamicAndStaticLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DynamicAndStaticLib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DynamicAndStaticLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JJCSoftDeveloper/DynamicAndStaticLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JJCSoftDeveloper' => 'jing3jiang4@163.com' }
  s.source           = { :git => 'https://github.com/JJCSoftDeveloper/DynamicAndStaticLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
    #'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  }
  #s.xcconfig = { 
  #      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  #  'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
  #  'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  #}

  s.libraries = ['z','stdc++.6.0.9','c++']

  s.source_files = [
    'DynamicAndStaticLib/Classes/*.{h,m}'
  ]

  s.prefix_header_contents = [
    '#import "Reachability.h"'
  ]

  #第一种方式 直接依赖静态库 此方式需要与s.frameworks配合使用 
  #单单使用 dependency pod只能将库的信息添加到 other linker flags中 此时运行并使用会报错 提示无法找到类对象
  #frameworks中添加静态库后  pod会在link binary with libraries中添加静态库
  #此方法会提示静态库依赖问题，需要添加
  #pre_install do |installer|
  #  # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
  #  Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
  #end
  #此方式可以直接用<>调用
  s.dependency 'AMapLocation-NO-IDFA'
  s.dependency 'AMapSearch-NO-IDFA'
  s.dependency 'AMap2DMap-NO-IDFA'
  s.dependency 'SDWebImage'
  #s.dependency 'libwebp'
  s.frameworks = [
    "MapKit", 
    "SystemConfiguration", 
    'CoreLocation', 
    'CoreTelephony', 
    'QuartzCore', 
    'Security', 
    'MAMapKit',
    'AMapFoundationKit',
    'AMapLocationKit',
    'AMapSearchKit'
  ]

  #第二种方式 将静态库添加到私有库的文件目录下 此方式也需要与s.frameworks配合使用 
  #单单使用 vendored_frameworks pod只能将库的信息添加到 other linker flags中 此时运行并使用会报错 提示无法找到类对象
  #frameworks中添加静态库后 pod会在link binary with libraries中添加静态库
  #此种方式不会提示静态库依赖问题 但是使用此静态库时比较麻烦，已知无法用<>调用
  #s.subspec 'ThirdPartVendor' do |sss|
  #  sss.ios.public_header_files = 'DynamicAndStaticLib/ThirdPath/**/**/*.{h}'
  #  sss.ios.vendored_frameworks = 'DynamicAndStaticLib/ThirdPath/**/*.{framework}'
  #  sss.frameworks = [
  #  "MapKit", 
  #  "SystemConfiguration", 
  #  'CoreLocation', 
  #  'CoreTelephony', 
  #  'QuartzCore', 
  #  'Security', 
  #  'MAMapKit',
  #  'AMapFoundationKit',
  #  'AMapLocationKit',
  #  'AMapSearchKit'
  #]
  #end
end
