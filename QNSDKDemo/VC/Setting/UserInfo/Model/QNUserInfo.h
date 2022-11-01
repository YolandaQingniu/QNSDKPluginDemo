//
//  QNUserInfo.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNUserInfo : NSObject

/// User ID
@property (nonatomic, strong) NSString *userId;
/// Gender (male or female)
@property (nonatomic, strong) NSString *gender;
/// Age (3 ~ 80)
@property (nonatomic, assign) int age;
/// Height
@property (nonatomic, assign) int height;
/// selected（current user）
@property (nonatomic, assign) BOOL selected;

+ (QNUserInfo *)currentUser;
@end

NS_ASSUME_NONNULL_END
