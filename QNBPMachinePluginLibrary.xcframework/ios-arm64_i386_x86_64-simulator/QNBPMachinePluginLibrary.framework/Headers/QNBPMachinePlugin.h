//
//  QNBPMachinePlugin.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNPluginLibrary/QNPlugin.h>
#import "QNBPMachineDeviceListener.h"
#import "QNBPMachineDataListener.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNBPMachinePlugin : NSObject

/// Initialize the BP machine component
/// @param plugin QNPlugin
+ (int)setBPMachinePlugin:(QNPlugin *)plugin;

/// Set device listener
/// @param deviceListener QNBPMachineDeviceListener
+ (void)setDeviceListener:(id<QNBPMachineDeviceListener>)deviceListener;

/// Set data listener
/// @param dataListener QNBPMachineDataListener
+ (void)setDataListener:(id<QNBPMachineDataListener>)dataListener;

/// Connect device
/// @param device QNBPMachineDevice
+ (int)connectDevice:(QNBPMachineDevice *)device;

/// Cancel connect device
/// @param device QNBPMachineDevice
+ (void)cancelConnectDevice:(QNBPMachineDevice *)device;

/// Set device function
/// it needs to be called after the device allows interaction
/// @param device QNBPMachineDevice
+ (int)setDeviceFunction:(QNBPMachineDevice *)device deploy:(QNBPMachineDeploy *)deploy;

/// Read stored data
/// it needs to be called after setDeviceFunction
/// @param device QNBPMachineDevice
+ (int)readStoredData:(QNBPMachineDevice *)device;

@end

NS_ASSUME_NONNULL_END
