//
//  QNHeightWeightScaleDataListener.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import <QNHeightWeightScalePluginLibrary/QNHeightWeightScaleData.h>
#import <QNHeightWeightScalePluginLibrary/QNHeightWeightScaleDevice.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNHeightWeightScaleDataListener <NSObject>

/// Real time measure
/// @param weight NSString
/// @param device QNScaleDevice
- (void)onHeightWeightScaleRealTimeWeight:(NSString *)weight device:(QNHeightWeightScaleDevice *)device;

/// Real time measure
/// @param height NSString
/// @param device QNScaleDevice
- (void)onHeightWeightScaleRealTimeHeight:(NSString *)height device:(QNHeightWeightScaleDevice *)device;

/// Measure result
/// @param scaleData QNHeightWeightScaleData
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleReceiveMeasureResult:(QNHeightWeightScaleData *)scaleData device:(QNHeightWeightScaleDevice *)device;

/// Measure Failed
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleReceiveMeasureFailed:(QNHeightWeightScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
