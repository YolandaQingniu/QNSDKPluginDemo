//
//  QNBPMachineWiFiListener.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNBPMachinePluginLibrary/QNBPMachineDevice.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNBPMachineWiFiListener <NSObject>

/// Discovery nearby WiFi
/// @param ssid WiFi name
/// @param rssi rssi
/// @param device QNBPMachineDevice
- (void)onBPMachineDiscoveryNearbyWiFi:(NSString *)ssid rssi:(int)rssi  device:(QNBPMachineDevice *)device;

/// Start connect WiFi
/// @param device QNBPMachineDevice
- (void)onBPMachineStartWiFiConnect:(QNBPMachineDevice *)device;

/// Connect WiFi status
/// @param code int
/// @param device QNBPMachineDevice
- (void)onBPMachineConnectWiFiStatus:(int)code device:(QNBPMachineDevice *)device;
@end

NS_ASSUME_NONNULL_END
