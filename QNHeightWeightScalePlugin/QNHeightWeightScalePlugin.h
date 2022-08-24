//
//  QNHeightWeightScalePlugin.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import "QNHeightWeightScaleDeviceListener.h"
#import "QNHeightWeightScaleStatusListener.h"
#import "QNHeightWeightScaleDataListener.h"
#import "QNHeightWeightScaleDevice.h"
#import "QNHeightWeightScaleOperate.h"
@class QNPlugin;

@interface QNHeightWeightScalePlugin : NSObject

/// Initialize the height weight scale component
/// @param plugin QNPlugin
/// @param callback QNResultCallback
+ (void)setScalePlugin:(QNPlugin *)plugin callback:(void(^) (int code))callback;

/// Set device listener
/// @param deviceListener QNHeightWeightScaleDeviceListener
+ (void)setDeviceListener:(id<QNHeightWeightScaleDeviceListener>)deviceListener;

/// Set status listener
/// @param statusListener QNHeightWeightScaleStatusListener
+ (void)setStatusListener:(id<QNHeightWeightScaleStatusListener>)statusListener;

/// Set data listener
/// @param dataListener QNHeightWeightScaleDataListener
+ (void)setDataListener:(id<QNHeightWeightScaleDataListener>)dataListener;

/// Connect device
/// @param device QNHeightWeightScaleDevice
/// @param operate QNHeightWeightScaleOperate
/// @param callback QNResultCallback
+ (void)connectHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device operate:(QNHeightWeightScaleOperate *)operate  callback:(void(^) (int code))callback;

/// Cancel connect device
/// @param device QNHeightWeightScaleDevice
+ (void)cancelConnectHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device;

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

/// Height cm to FtIn
/// @param height NSString
+ (NSArray *)getHeightFtIn:(NSString *)height;

@end
