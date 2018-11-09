#
# Be sure to run `pod lib lint ZhijianKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DynamicAndStaticLib'
  s.version          = '0.0.4'
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
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '蒋京春' => 'jing4jiang4@163.com' }
  s.source           = { :git => 'https://github.com/JJCSoftDeveloper/DynamicAndStaticLib.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
    'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  }
  #s.xcconfig = { 
  #      'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  #  'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
  #  'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  #}

  s.libraries = ['z','stdc++.6.0.9','c++']

  s.source_files = [
    'DynamicAndStaticLib/**/*.{h,m}',
  ]

  s.prefix_header_contents = [
    '#import "Reachability.h"'
  ]

  #第一种方式 直接依赖静态库
  s.dependency 'AMapLocation-NO-IDFA'
  s.dependency 'AMapSearch-NO-IDFA'
  s.dependency 'AMap2DMap-NO-IDFA'
  s.dependency 'SDWebImage'
  #s.frameworks = [
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

  #第二种方式 暂时有问题没试出来
  #s.ios.public_header_files = 'DynamicAndStaticLib/**/**/*.{h}'
  #s.vendored_frameworks = 'DynamicAndStaticLib/*.framework'
  
  
end
