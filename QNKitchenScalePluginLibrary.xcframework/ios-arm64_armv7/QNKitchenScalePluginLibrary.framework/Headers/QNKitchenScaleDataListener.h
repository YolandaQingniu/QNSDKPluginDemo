//
//  QNKitchenScaleDataListener.h
//  QNKitchenScalePlugin
//
//  Created by sumeng on 2022/7/11.
//

#import <Foundation/Foundation.h>
#import "QNKitchenScaleDevice.h"
#import "QNKitchenScaleData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNKitchenScaleDataListener <NSObject>

/// Real time measure
/// @param scaleData NSString
/// @param device QNKitchenScaleDevice
- (void)onKitchenScaleRealTimeData:(QNKitchenScaleData *)scaleData device:(QNKitchenScaleDevice *)device;
@end

NS_ASSUME_NONNULL_END
