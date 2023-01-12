//
//  QNScaleWiFiMp.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import "QNScaleWiFiListener.h"
#import "QNWiFiInfo.h"


NS_ASSUME_NONNULL_BEGIN

@interface QNScaleWiFiMp : NSObject

/// Configure Device WiFi listener
/// @param wifiListener QNScaleWiFiListener
+ (void)setWiFiStatusListener:(id<QNScaleWiFiListener>)wifiListener;

/// Configure Device WiFi
/// @param wifiInfo QNWiFiInfo
/// @param device QNScaleDevice
+ (int)startConnectWiFi:(QNWiFiInfo *)wifiInfo device:(QNScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
