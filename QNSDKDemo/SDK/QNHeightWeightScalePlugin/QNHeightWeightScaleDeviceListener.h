//
//  QNHeightWeightScaleDeviceListener.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import "QNHeightWeightScaleDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNHeightWeightScaleDeviceListener <NSObject>

/// Discover device
/// @param device QNHeightWeightScaleDevice
- (void)onDiscoverHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device;

/// Set unit
/// @param code Status code (success: 0, failure: 1)
/// @param device QNHeightWeightScaleDevice
- (void)onSetHeightWeightScaleUnitResult:(int)code device:(QNHeightWeightScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
