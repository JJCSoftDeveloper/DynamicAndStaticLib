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
  s.summary          = 'A short description of ZhijianKit.'

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

  s.static_framework = true

  s.pod_target_xcconfig = {
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'LIBRARY_SEARCH_PATHS' => '$(SRCROOT)/Pods/**',
    #'FRAMEWORK_SEARCH_PATHS' => '${PODS_ROOT}/ZhijianKit/ZhijianKit/Framework',
  }

  s.libraries = ['z','stdc++.6.0.9','c++']

  s.frameworks = [
    "MapKit", 
    "SystemConfiguration", 
    'CoreLocation', 
    'CoreTelephony', 
    'QuartzCore', 
    'Security', 
    'VideoToolbox',
    'ExternalAccessory'
  ]

 

  
  s.dependency 'AMapLocation-NO-IDFA'
  s.dependency 'AMapSearch-NO-IDFA'
  s.dependency 'AMap2DMap-NO-IDFA'
  
  #s.vendored_frameworks = ['${PODS_ROOT}/**/*.framework']
  
  s.subspec 'ZhijianKitVendor' do |sss|
    sss.dependency 'AFNetworking', '3.0'
  sss.dependency 'Masonry'
  sss.dependency 'ReactiveObjC', '3.0.0'
  sss.dependency 'Realm','3.3.2'
  sss.dependency 'Texture','2.6'
  sss.dependency 'YYModel'
  sss.dependency 'SAMCategories'
  sss.dependency 'SAMBadgeView'
  sss.dependency 'MJRefresh'
  sss.dependency 'MTDates'
  sss.dependency 'MZAppearance'
  sss.dependency 'WYPopoverController'
  sss.dependency 'YYText'
  sss.dependency 'WebViewJavascriptBridge', '6.0.3'
  sss.dependency 'ZYPinYinSearch'
    #sss.static_framework = true
    #sss.dependency 'AMapLocation-NO-IDFA'
    #sss.dependency 'AMapSearch-NO-IDFA'
    #sss.dependency 'AMap2DMap-NO-IDFA'
    #ss.vendored_frameworks =  'Verify-SwiftOC3rd/Vendors/*.framework'
    #ss.preserve_paths = 'Verify-SwiftOC3rd/Vendors/*.framework', 'Verify-SwiftOC3rd/Vendors/thirdlibs/*.a'
  end
end
