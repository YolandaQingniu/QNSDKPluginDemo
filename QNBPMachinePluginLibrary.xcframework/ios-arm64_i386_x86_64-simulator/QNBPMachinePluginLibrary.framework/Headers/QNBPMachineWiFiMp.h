//
//  QNBPMachineWiFiMp.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import "QNBPMachineWiFiListener.h"
#import "QNBPMachineWiFi.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNBPMachineWiFiMp : NSObject

/// Set device WiFi listener
/// @param wifiListener QNBPMachineWiFiListener
+ (void)setWiFiStatusListener:(id<QNBPMachineWiFiListener>)wifiListener;

/// Start connect WiFi
/// it needs to be called after setDeviceFunction
/// @param wifiInfo QNBPMachineWiFi
/// @param device QNBPMachineDevice
+ (int)startConnectWiFi:(QNBPMachineWiFi *)wifiInfo device:(QNBPMachineDevice *)device;


/// Scan nearby WiFi
/// it needs to be called after setDeviceFunction
/// @param device QNBPMachineDevice
+ (int)scanNearbyWiFi:(QNBPMachineDevice *)device;

@end

NS_ASSUME_NONNULL_END
