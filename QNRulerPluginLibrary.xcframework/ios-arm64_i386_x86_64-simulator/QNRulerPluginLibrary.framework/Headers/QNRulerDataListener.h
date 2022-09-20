//
//  QNRulerDataListener.h
//  QNRulerPluginLibrary
//
//  Created by zhoushenbin on 2022/9/16.
//

#import <Foundation/Foundation.h>
#import "QNRulerData.h"
#import "QNRulerDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNRulerDataListener <NSObject>
@required
/// Real time measure
/// @param data QNRulerData
/// @param device QNRulerDevice
- (void)onRulerRealTimeData:(QNRulerData *)data device:(QNRulerDevice *)device;

/// Measure result
/// @param data QNRulerData
/// @param device QNRulerDevice
- (void)onRulerReceiveMeasureResult:(QNRulerData *)data device:(QNRulerDevice *)device;

@end

NS_ASSUME_NONNULL_END
