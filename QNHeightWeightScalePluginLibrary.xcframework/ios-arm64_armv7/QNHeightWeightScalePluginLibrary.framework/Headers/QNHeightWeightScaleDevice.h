//
//  QNHeightWeightScaleDevice.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNHeightWeightScaleDevice : NSObject

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

@end

NS_ASSUME_NONNULL_END
