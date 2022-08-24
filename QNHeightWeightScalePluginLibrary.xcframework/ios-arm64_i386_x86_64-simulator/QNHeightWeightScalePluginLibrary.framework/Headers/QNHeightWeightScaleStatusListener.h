//
//  QNHeightWeightScaleStatusListener.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import <QNHeightWeightScalePluginLibrary/QNHeightWeightScaleDevice.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNHeightWeightScaleStatusListener <NSObject>
/// Connected success
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleConnectedSuccess:(QNHeightWeightScaleDevice *)device;

/// Connect fail
/// @param code code
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleConnectFail:(int)code device:(QNHeightWeightScaleDevice *)device;

/// Device ready interact
/// @param code code
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleReadyInteractResult:(int)code  device:(QNHeightWeightScaleDevice *)device;

/// Disconnected
/// @param device QNHeightWeightScaleDevice
- (void)onHeightWeightScaleDisconnected:(QNHeightWeightScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
