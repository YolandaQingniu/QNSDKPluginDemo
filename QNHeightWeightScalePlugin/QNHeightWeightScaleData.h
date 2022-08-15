//
//  QNHeightWeightScaleData.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNHeightWeightScaleData : NSObject

/// Time stamp
@property (nonatomic, strong) NSString *timeStamp;
/// Weight
@property (nonatomic, strong) NSString *weight;
/// Height
@property (nonatomic, strong) NSString *height;

@end

NS_ASSUME_NONNULL_END
