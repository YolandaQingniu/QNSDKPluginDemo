#
# Be sure to run `pod lib lint QNScalePlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'QNScalePlugin'
s.version          = '1.1.0'
s.summary          = '轻牛旗下家用秤设备通讯类'

s.description      = '支持轻牛旗下家用秤设备'

s.homepage         = 'https://github.com/YolandaQingniu/QNSDKPluginDemo'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'service@qnniu.com' => 'service@qnniu.com' }
s.source           = { :git => 'https://github.com/YolandaQingniu/QNSDKPluginDemo.git', :tag => s.version.to_s}
s.ios.deployment_target = '9.0'

s.vendored_frameworks = 'QNScalePluginLibrary.xcframework'
s.static_framework = true
s.frameworks = 'CoreBluetooth'
end
