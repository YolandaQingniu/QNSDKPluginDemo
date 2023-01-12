//
//  QNScaleWiFiListener.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "QNScaleDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNScaleWiFiListener <NSObject>

/// Start connect WiFi
/// @param device QNScaleDevice
- (void)onStartWiFiConnect:(QNScaleDevice *)device;

/// Connect WiFi status
/// @param code int
/// @param device QNScaleDevice
- (void)onConnectWiFiStatus:(int)code device:(QNScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
