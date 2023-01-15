//
//  QNKitchenScaleDevice.h
//  QNKitchenScalePlugin
//
//  Created by sumeng on 2022/7/11.
//

#import <Foundation/Foundation.h>
#import "QNKitchenScaleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNKitchenScaleDevice : NSObject
/** mac */
@property (nonatomic, strong) NSString *mac;
/** rssi */
@property (nonatomic, assign) int rssi;
/** bleName */
@property (nonatomic, strong) NSString *bleName;
/** model Id */
@property (nonatomic, strong) NSString *modelId;
/** scale Version */
@property (nonatomic, strong) NSString *scaleVer;
/** ble Version */
@property (nonatomic, strong) NSString *bleVer;

/// Device supports Shelling
- (BOOL)getDeviceSupportShelling;

/// Device support Shut Down
- (BOOL)getDeviceSupportShutDown;

/// Device support Standby Time
- (BOOL)getDeviceSupportStandbyTime;

/// get device Standby Time
- (QNKitchenScaleStandbyTimeType)getDeviceStandbyTime;

/// get device number type
- (QNKitchenScaleNumberType)getDeviceNumberType;

/// get device range type
- (QNKitchenScaleRangeType)getDeviceRangeType;

/// get device unit supported list
- (NSArray *)getDeviceUnitSupportedList;

@end

NS_ASSUME_NONNULL_END
