//
//  QNScaleDeviceListener.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "QNScaleDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNScaleDeviceListener <NSObject>

/// Discover device
/// @param device QNScaleDevice
- (void)onDiscoverScaleDevice:(QNScaleDevice *)device;

/// Set unit
/// @param code Status code (success: 0, failure: 1)
/// @param device QNScaleDevice
- (void)onSetUnitResult:(int)code device:(QNScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
