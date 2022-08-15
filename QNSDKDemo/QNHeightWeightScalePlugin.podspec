#
# Be sure to run `pod lib lint QNHeightWeightScalePlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'QNHeightWeightScalePlugin'
s.version          = '0.1.0'
s.summary          = '轻牛旗下身高一体机设备通讯类'

s.description      = '支持轻牛旗下身高一体机设备'

s.homepage         = 'https://github.com/YolandaQingniu/QNSDKPluginDemo'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'service@qnniu.com' => 'service@qnniu.com' }
s.source           = { :git => 'https://github.com/YolandaQingniu/QNSDKPluginDemo.git', :tag => s.version.to_s}
s.ios.deployment_target = '8.0'

s.source_files = 'QNSDKDemo/SDK/QNHeightWeightScalePlugin/*.{h,m}'
s.vendored_libraries = 'QNSDKDemo/SDK/QNHeightWeightScalePlugin/libQNHeightWeightScalePlugin.a'
s.public_header_files= 'QNSDKDemo/SDK/QNHeightWeightScalePlugin/*.h'
s.static_framework = true
s.frameworks = 'CoreBluetooth'
s.xcconfig = {'BITCODE_GENERATION_MODE' => 'bitcode'}
s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
}
s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
