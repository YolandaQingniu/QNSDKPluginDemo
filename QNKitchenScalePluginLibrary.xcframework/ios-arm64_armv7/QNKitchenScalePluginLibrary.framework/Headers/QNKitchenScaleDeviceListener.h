//
//  QNKitchenScaleDeviceListener.h
//  QNKitchenScalePlugin
//
//  Created by sumeng on 2022/7/11.
//

#import <Foundation/Foundation.h>
#import "QNKitchenScaleDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNKitchenScaleDeviceListener <NSObject>

/// Discover device
/// @param device QNKitchenScaleDevice
- (void)onDiscoverKitchenScaleDevice:(QNKitchenScaleDevice *)device;

/// Set unit
/// @param code Status code (success: 0, failure: 1)
/// @param device QNKitchenScaleDevice
- (void)onSetKitchenScaleUnitResult:(int)code device:(QNKitchenScaleDevice *)device;

/// Set Shelling
/// @param code Status code (success: 0, failure: 1)
/// @param device QNKitchenScaleDevice
- (void)onSetKitchenScaleShellingResult:(int)code device:(QNKitchenScaleDevice *)device;

/// Set StandTime
/// @param code Status code (success: 0, failure: 1)
/// @param device QNKitchenScaleDevice
- (void)onSetKitchenScaleStandTimeResult:(int)code device:(QNKitchenScaleDevice *)device;

/// Connected success
/// @param device QNKitchenScaleDevice
- (void)onKitchenScaleConnectedSuccess:(QNKitchenScaleDevice *)device;

/// Connect fail
/// @param code code
/// @param device QNKitchenScaleDevice
- (void)onKitchenScaleConnectFail:(int)code device:(QNKitchenScaleDevice *)device;

/// Device ready interact
/// @param code code
/// @param device QNKitchenScaleDevice
- (void)onKitchenScaleReadyInteract:(int)code device:(QNKitchenScaleDevice *)device;

/// Disconnected
/// @param device QNKitchenScaleDevice
- (void)onKitchenScaleDisconnected:(QNKitchenScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
