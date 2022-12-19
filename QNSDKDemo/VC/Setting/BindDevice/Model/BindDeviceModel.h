//
//  BindDeviceModel.h
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNBindDeviceType) {
    QNBindDeviceTypeScale = 0,
    QNBindDeviceTypeBPMachine,
};

@interface BindDeviceModel : NSObject
/// User ID
@property (nonatomic, strong) NSString *userId;
/// DeviceType
@property (nonatomic, assign) QNBindDeviceType deviceType;
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

+ (instancetype)bindDeviceWithBPMachineDevice:(QNBPMachineDevice *)device;
@end

NS_ASSUME_NONNULL_END
