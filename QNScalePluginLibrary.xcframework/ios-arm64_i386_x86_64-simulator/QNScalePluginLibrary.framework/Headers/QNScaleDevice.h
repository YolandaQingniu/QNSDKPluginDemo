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
/// Model ID  设备类型标识
@property (nonatomic, strong) NSString *modelId;
/// Mac
@property (nonatomic, strong) NSString *mac;
/// RSSI
@property (nonatomic, assign) int rssi;

/// 设备中存储数据的条数
@property (nonatomic, assign) int storageCount;
@end

NS_ASSUME_NONNULL_END
