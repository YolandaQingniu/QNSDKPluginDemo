#
# Be sure to run `pod lib lint QNAlgorithmPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'QNAlgorithmPlugin'
s.version          = '1.3.0'
s.summary          = '轻牛旗下算法组件类'

s.description      = '支持轻牛旗下设备'

s.homepage         = 'https://github.com/YolandaQingniu/QNSDKPluginDemo'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'service@qnniu.com' => 'service@qnniu.com' }
s.source           = { :git => 'https://github.com/YolandaQingniu/QNSDKPluginDemo.git', :tag => s.version.to_s}
s.ios.deployment_target = '9.0'

s.vendored_frameworks = 'QNAlgorithmPluginLibrary.xcframework'
s.static_framework = true
end
