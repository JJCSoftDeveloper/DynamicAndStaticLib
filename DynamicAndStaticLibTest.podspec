#
# Be sure to run `pod lib lint ZhijianKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DynamicAndStaticLibTest'
  s.version          = '0.0.1'
  s.summary          = 'A short description of DynamicAndStaticLibTest.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JJCSoftDeveloper/DynamicAndStaticLibTest'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '蒋京春' => 'jing4jiang4@163.com' }
  s.source           = { :git => 'https://github.com/JJCSoftDeveloper/DynamicAndStaticLibTest.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  #s.static_framework = true

  s.pod_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
    #'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  }
  #s.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/AMapLocation-NO-IDFA/MAMapKit.framework","$(PODS_ROOT)/AMapFoundation-NO-IDFA/AMapFoundationKit.framework","$(PODS_ROOT)/AMapLocation-NO-IDFA/AMapLocationKit.framework","$(PODS_ROOT)/AMapSearch-NO-IDFA/AMapSearchKit.framework"',
  #}
  s.libraries = ['z','stdc++.6.0.9','c++']

  s.source_files = [
    'DynamicAndStaticLib/**/*.{h,m}',
    'DynamicAndStaticLib/**/**/*.{h,m}',
    'DynamicAndStaticLib/**/**/**/*.{h,m}'
  ]

  s.prefix_header_contents = [
    '#import "DrawView.h"'
  ]

  s.dependency 'AMapLocation-NO-IDFA'
  s.dependency 'AMapSearch-NO-IDFA'
  s.dependency 'AMap2DMap-NO-IDFA'

  #s.vendored_frameworks = [
  #'DynamicAndStaticLib/AMap2DMap-NO-IDFA/MAMapKit.framework',
  #  'DynamicAndStaticLib/AMapFoundation-NO-IDFA/AMapFoundationKit.framework',
   # 'DynamicAndStaticLib/AMapLocation-NO-IDFA/AMapLocationKit.framework',
  #  'DynamicAndStaticLib/AMapSearch-NO-IDFA/AMapSearchKit.framework'
  #  ]

  s.dependency 'AFNetworking', '3.0'
  s.dependency 'Masonry'
  s.dependency 'ReactiveObjC', '3.0.0'
  s.dependency 'Realm','3.3.2'
  s.dependency 'Texture','2.6'
  s.dependency 'YYModel'
  s.dependency 'SAMCategories'
  s.dependency 'SAMBadgeView'
  s.dependency 'MJRefresh'
  s.dependency 'MTDates'
  s.dependency 'MZAppearance'
  s.dependency 'WYPopoverController'
  s.dependency 'YYText'
  s.dependency 'WebViewJavascriptBridge', '6.0.3'
  s.dependency 'ZYPinYinSearch'
  
  s.frameworks = [
    "MapKit", 
    "SystemConfiguration", 
    'CoreLocation', 
    'CoreTelephony', 
    'QuartzCore', 
    'Security', 
    'VideoToolbox',
    'ExternalAccessory',
    'MAMapKit',
    'AMapFoundationKit',
    'AMapLocationKit',
    'AMapSearchKit'
  ]
end
