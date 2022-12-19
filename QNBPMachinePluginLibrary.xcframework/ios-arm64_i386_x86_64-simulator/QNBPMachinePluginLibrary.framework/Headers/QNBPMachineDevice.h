//
//  QNBPMachineDevice.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNBPMachinePluginLibrary/QNBPMachineDeploy.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNBPMachineDevice : NSObject
/// Bluetooth name
@property (nonatomic, strong) NSString *bleName;
/// Mac
@property (nonatomic, strong) NSString *mac;
/// Model ID
@property (nonatomic, strong) NSString *modelId;
/// RSSI
@property (nonatomic, assign) int rssi;
/// Protocol version number
@property (nonatomic, assign) int protVer;
/// BPMachine version number
@property (nonatomic, assign) int hemVer;
/// Bluetooth version number
@property (nonatomic, assign) int bleVer;


/// Device supports WiFi
- (BOOL)getSupportWiFi;

/// Device support change language
- (BOOL)getSupportChangeLanguage;

///Device support charge battery
- (BOOL)getSupportChargeBattery;

/// Device current storage count
/// it needs to be called after the device allows interaction
- (int)getCurrentStorageCount;

/// Get current language type of the device
/// it needs to be called after the device allows interaction
- (QNBPMachineLanguage)getCurrentLanguage;

/// Get the current unit type of the device
/// it needs to be called after the device allows interaction
- (QNBPMachineUnit)getCurrentUnit;

/// Get the current BP machine standard of the device
/// it needs to be called after the device allows interaction
- (QNBPMachineStandard)getCurrentStandard;

@end

NS_ASSUME_NONNULL_END
