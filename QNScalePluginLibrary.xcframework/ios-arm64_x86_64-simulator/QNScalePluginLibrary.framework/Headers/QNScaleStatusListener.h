//
//  QNScaleStatusListener.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNScaleStatusListener <NSObject>

/// Connected success
/// @param device QNScaleDevice
- (void)onConnectedSuccess:(QNScaleDevice *)device;

/// Connect fail
/// @param code code
/// @param device QNScaleDevice
- (void)onConnectFail:(int)code device:(QNScaleDevice *)device;

/// Device ready interact
/// @param code code
/// @param device QNScaleDevice
- (void)onReadyInteractResult:(int)code device:(QNScaleDevice *)device;

/// Disconnected
/// @param device QNScaleDevice
- (void)onDisconnected:(QNScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
