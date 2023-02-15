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
- (void)onDiscoverDevice:(QNBPMachineDevice *)device;

/// Connected success
/// @param device QNBPMachineDevice
- (void)onConnectedSuccess:(QNBPMachineDevice *)device;

/// Connect fail
/// @param code code
/// @param device QNBPMachineDevice
- (void)onConnectFail:(int)code device:(QNBPMachineDevice *)device;

/// Device ready interact
/// @param code code
/// @param device QNBPMachineDevice
- (void)onReadyInteractResult:(int)code device:(QNBPMachineDevice *)device;

/// Set function result
/// @param code code
/// @param device QNBPMachineDevice
- (void)onSetFunctionResult:(int)code device:(QNBPMachineDevice *)device;

/// Set read stored data result
/// @param code code
/// @param device QNBPMachineDevice
- (void)onSetReadStoredDataResult:(int)code device:(QNBPMachineDevice *)device;

/// Disconnected
/// @param device QNBPMachineDevice
- (void)onDisconnected:(QNBPMachineDevice *)device;
@end

NS_ASSUME_NONNULL_END
