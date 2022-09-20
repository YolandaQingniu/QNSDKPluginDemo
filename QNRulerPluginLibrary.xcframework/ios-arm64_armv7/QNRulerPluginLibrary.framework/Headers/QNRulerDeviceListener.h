//
//  QNRulerDeviceListener.h
//  QNRulerPluginLibrary
//
//  Created by zhoushenbin on 2022/9/16.
//

#import <Foundation/Foundation.h>
#import "QNRulerData.h"
#import "QNRulerDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNRulerDeviceListener <NSObject>
@required
/// Discover device
/// @param device QNRulerDevice
- (void)onDiscoverRulerDevice:(QNRulerDevice *)device;

/// Connected success
/// @param device QNRulerDevice
- (void)onRulerConnectedSuccess:(QNRulerDevice *)device;

/// Connect fail
/// @param code Code
/// @param device QNRulerDevice
- (void)onRulerConnectFail:(int)code device:(QNRulerDevice *)device;

/// Device ready interact
/// @param device QNRulerDevice
- (void)onRulerReadyInteract:(QNRulerDevice *)device;

/// Disconnected
/// @param device QNRulerDevice
- (void)onRulerDisconnected:(QNRulerDevice *)device;

@end

NS_ASSUME_NONNULL_END
