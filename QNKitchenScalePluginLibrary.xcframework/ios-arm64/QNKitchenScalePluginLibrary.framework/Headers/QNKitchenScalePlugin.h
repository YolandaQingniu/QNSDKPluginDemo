//
//  QNKitchenScalePlugin.h
//  QNKitchenScalePlugin
//
//  Created by sumeng on 2022/7/11.
//

#import <Foundation/Foundation.h>
#import <QNPluginLibrary/QNPlugin.h>
#import "QNKitchenScaleDeviceListener.h"
#import "QNKitchenScaleDataListener.h"
#import "QNKitchenScaleOperate.h"
#import "QNKitchenScaleData.h"

@interface QNKitchenScalePlugin : NSObject

/// Initialize the kitchen scale component
/// @param plugin QNPlugin
+ (int)setScalePlugin:(QNPlugin *)plugin;

/// Set device listener
/// @param deviceListener QNKitchenScaleDeviceListener
+ (void)setDeviceListener:(id<QNKitchenScaleDeviceListener>)deviceListener;

/// Set data listener
/// @param dataListener QNKitchenScaleDataListener
+ (void)setDataListener:(id<QNKitchenScaleDataListener>)dataListener;

/// Connect device
/// @param device QNKitchenScaleDevice
+ (int)connectKitchenScaleDevice:(QNKitchenScaleDevice *)device operate:(QNKitchenScaleOperate *)operate;

/// Cancel connect device
/// @param device QNKitchenScaleDevice
+ (void)cancelConnectKitchenScaleDevice:(QNKitchenScaleDevice *)device;

/// Set device unit
/// @param unit unit
/// @param device device
+ (int)setDeviceUnit:(QNUnit)unit device:(QNKitchenScaleDevice *)device;

/// Set device Shelling
/// @param device device
+ (int)setDeviceShelling:(QNKitchenScaleDevice *)device;

/// Set device Shut Down
/// @param device device
+ (int)setDeviceShutDown:(QNKitchenScaleDevice *)device;

/// Set device StandbyTime
/// @param standbyTime standbyTimeType
/// @param device device
+ (int)setDeviceStandbyTime:(QNKitchenScaleStandbyTimeType)standbyTime device:(QNKitchenScaleDevice *)device;

/// get weight value with different unit
/// @param unit unit
/// @param weight origin weight
/// @param numberType numberType
+ (NSString *)getWeightWithUnit:(QNUnit)unit weight:(NSString *)weight numberType:(QNKitchenScaleNumberType)numberType;

@end
