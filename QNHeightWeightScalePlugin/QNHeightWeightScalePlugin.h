//
//  QNHeightWeightScalePlugin.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import <QNPlugin/QNPlugin.h>
#import "QNHeightWeightScaleDeviceListener.h"
#import "QNHeightWeightScaleStatusListener.h"
#import "QNHeightWeightScaleDataListener.h"
#import "QNHeightWeightScaleDevice.h"
#import "QNHeightWeightScaleOperate.h"


@interface QNHeightWeightScalePlugin : NSObject

/// Initialize the height weight scale component
/// @param plugin QNPlugin
/// @param callback QNResultCallback
+ (void)setScalePlugin:(QNPlugin *)plugin callback:(QNResultCallback)callback;

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
+ (void)connectHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device operate:(QNHeightWeightScaleOperate *)operate  callback:(QNResultCallback)callback;

/// Cancel connect device
/// @param device QNHeightWeightScaleDevice
+ (void)cancelConnectHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device;

@end
