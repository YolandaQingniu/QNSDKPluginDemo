//
//  QNRulerDevice.h
//  QNRulerPluginLibrary
//
//  Created by zhoushenbin on 2022/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNRulerDevice : NSObject

/// Mac
@property (nonatomic, strong) NSString *mac;
/// Bluetooth name
@property (nonatomic, strong) NSString *bleName;
/// Model ID
@property (nonatomic, strong) NSString *modelId;
/// RSSI
@property (nonatomic, assign) int rssi;

@end

NS_ASSUME_NONNULL_END
