//
//  QNHeightWeightUser.h
//  QNHeightWeightScalePluginLibrary
//
//  Created by sumeng on 2022/9/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNHeightWeightUser : NSObject

/// User ID
@property(nonatomic, strong) NSString *userId;
/// Gender (male or female)
@property (nonatomic, strong) NSString *gender;
/// Age (3 ~ 80)
@property (nonatomic, assign) int age;

@end

NS_ASSUME_NONNULL_END
