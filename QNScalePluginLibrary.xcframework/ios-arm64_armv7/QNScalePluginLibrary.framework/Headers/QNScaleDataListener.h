//
//  QNScaleDataListener.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "QNScaleData.h"
#import "QNScaleUser.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNScaleDataListener <NSObject>

/// Real time measure
/// @param weight NSString
/// @param device QNScaleDevice
- (void)onRealTimeWeight:(NSString *)weight device:(QNScaleDevice *)device;

/// Measure result
/// @param scaleData QNScaleData
/// @param device QNScaleDevice
- (void)onReceiveMeasureResult:(QNScaleData *)scaleData device:(QNScaleDevice *)device;

/// Stored data
/// @param scaleData NSArray<QNScaleData *>*
/// @param device device
- (void)onReceiveStoredData:(NSArray<QNScaleData *>*)scaleData device:(QNScaleDevice *)device;

/// Get last data hmac
/// @param user QNScaleUser
/// @param device QNScaleDevice
- (NSString *)onGetLastDataHmac:(QNScaleUser *)user device:(QNScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
