#
# Be sure to run `pod lib lint QNPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'QNPlugin'
s.version          = '1.0.1'
s.summary          = '轻牛旗下设备通讯基础类'

s.description      = '支持轻牛旗下SDK授权信息校验'

s.homepage         = 'https://github.com/YolandaQingniu/QNSDKPluginDemo'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'service@qnniu.com' => 'service@qnniu.com' }
s.source           = { :git => 'https://github.com/YolandaQingniu/QNSDKPluginDemo.git', :tag => s.version.to_s}
s.ios.deployment_target = '9.0'

s.vendored_frameworks = 'QNPluginLibrary.xcframework'
s.static_framework = true
s.frameworks = 'CoreBluetooth'

end
