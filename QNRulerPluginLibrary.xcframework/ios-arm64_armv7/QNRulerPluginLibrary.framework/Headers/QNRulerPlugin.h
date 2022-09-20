//
//  QNRulerPlugin.h
//  QNRulerPluginLibrary
//
//  Created by zhoushenbin on 2022/9/16.
//

#import <Foundation/Foundation.h>
#import "QNRulerDataListener.h"
#import "QNRulerDeviceListener.h"
#import "QNRulerDevice.h"

NS_ASSUME_NONNULL_BEGIN
@class QNPlugin;

@interface QNRulerPlugin : NSObject

/// Initialize the ruler component
/// @param plugin QNPlugin
+ (int)setRulerPlugin:(QNPlugin *)plugin;

/// Set device listener
/// @param deviceListener QNRulerDeviceListener
+ (void)setDeviceListener:(id<QNRulerDeviceListener>)deviceListener;

/// Set data listener
/// @param dataListener QNRulerDataListener
+ (void)setDataListener:(id<QNRulerDataListener>)dataListener;

/// Connect device
/// @param device QNRulerDevice
+ (int)connectDevice:(QNRulerDevice *)device;

/// Cancel connect device
/// @param device QNRulerDevice
+ (void)cancelConnectDevice:(QNRulerDevice *)device;

@end

NS_ASSUME_NONNULL_END
