//
//  QNBPMachineDeviceListener.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNBPMachinePluginLibrary/QNBPMachineDevice.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNBPMachineDeviceListener <NSObject>

/// Discover device
/// @param device QNBPMachineDevice
- (void)onDiscoverBPMachineDevice:(QNBPMachineDevice *)device;

/// Connected success
/// @param device QNBPMachineDevice
- (void)onBPMachineConnectedSuccess:(QNBPMachineDevice *)device;

/// Connect fail
/// @param code code
/// @param device QNBPMachineDevice
- (void)onBPMachineConnectFail:(int)code device:(QNBPMachineDevice *)device;

/// Device ready interact
/// @param code code
/// @param device QNBPMachineDevice
- (void)onBPMachineReadyInteractResult:(int)code device:(QNBPMachineDevice *)device;

/// Set function result
/// @param code code
/// @param device QNBPMachineDevice
- (void)onSetBPMachineFunctionResult:(int)code device:(QNBPMachineDevice *)device;

/// Set read stored data result
/// @param code code
/// @param device QNBPMachineDevice
- (void)onSetBPMachineReadStoredDataResult:(int)code device:(QNBPMachineDevice *)device;

/// Disconnected
/// @param device QNBPMachineDevice
- (void)onBPMachineDisconnected:(QNBPMachineDevice *)device;
@end

NS_ASSUME_NONNULL_END
