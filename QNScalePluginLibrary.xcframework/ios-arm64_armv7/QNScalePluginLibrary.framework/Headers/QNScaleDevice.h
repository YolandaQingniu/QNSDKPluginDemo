//
//  QNScaleDevice.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//  QNScaleDevice

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNScaleDevice : NSObject
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
- (BOOL)getSupportWiFi;
/// Device support user
- (BOOL)getSupportScaleUser;
///Device whether user full
- (BOOL)getScaleUserFull;
@end

NS_ASSUME_NONNULL_END
