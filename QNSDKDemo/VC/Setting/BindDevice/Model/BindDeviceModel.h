//
//  BindDeviceModel.h
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/27.
//

#import <Foundation/Foundation.h>
#import "QNScalePluginLibrary/QNScalePluginLibrary.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindDeviceModel : NSObject
/// User ID
@property (nonatomic, strong) NSString *userId;
/// Bluetooth name
@property (nonatomic, strong) NSString *bleName;
/// Model ID
@property (nonatomic, strong) NSString *modelId;
/// Mode
@property (nonatomic, strong) NSString *mode;
/// Mac
@property (nonatomic, strong) NSString *mac;
/// RSSI
@property (nonatomic, assign) int rssi;
/// Firmware version number
@property (nonatomic, assign) int firmwareVer;

/// Device supports WiFi
@property (nonatomic, assign) BOOL supportWiFiFlag;
/// Device support user
@property (nonatomic, assign) BOOL supportScaleUserFlag;
/// Device whether user full
@property (nonatomic, assign) BOOL scaleUserFullFlag;

+ (instancetype)bindDeviceWithQNScale:(QNScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
