//
//  QNScalePlugin.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import <QNPluginLibrary/QNPlugin.h>
#import "QNScaleDeviceListener.h"
#import "QNScaleStatusListener.h"
#import "QNScaleDataListener.h"
#import "QNScaleOperate.h"
#import "QNScaleDevice.h"
#import "QNUser.h"

@interface QNScalePlugin : NSObject

/// Initialize the body fat scale component
/// @param plugin QNPlugin
+ (int)setScalePlugin:(QNPlugin *)plugin;

/// Set device listener
/// @param deviceListener QNScaleDeviceListener
+ (void)setDeviceListener:(id<QNScaleDeviceListener>)deviceListener;

/// Set status listener
/// @param statusListener QNScaleStatusListener
+ (void)setStatusListener:(id<QNScaleStatusListener>)statusListener;

/// Set data listener
/// @param dataListener QNScaleDataListener
+ (void)setDataListener:(id<QNScaleDataListener>)dataListener;

/// Connect device
/// @param device QNScaleDevice
/// @param operate QNScaleOperate
+ (int)connectDevice:(QNScaleDevice *)device operate:(QNScaleOperate *)operate;

/// Cancel connect device
/// @param device QNScaleDevice
+ (void)cancelConnectDevice:(QNScaleDevice *)device;

/// Set scale device unit
/// @param device QNScaleDevice
/// @param unit QNScaleUnit
+ (int)setScaleDeviceUnit:(QNScaleDevice *)device unit:(QNUnit)unit;

/// Set measure user
/// @param device QNScaleDevice
/// @param user QNScaleUser
+ (int)setMeasureUser:(QNScaleDevice *)device user:(QNUser *)user;

/// Weight kg to Lb
/// @param weight NSString
+ (NSString *)getWeightLb:(NSString *)weight;

/// Weight kg to Jin
/// @param weight NSString
+ (NSString *)getWeightJin:(NSString *)weight;

/// Weight kg to StLb
/// @param weight NSString
+ (NSArray *)getWeightStLb:(NSString *)weight;

/// Weight kg to St
/// @param weight NSString
+ (NSString *)getWeightSt:(NSString *)weight;
@end
