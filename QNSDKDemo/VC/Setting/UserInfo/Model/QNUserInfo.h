//
//  QNUserInfo.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QNUnitType) {
    QNUnitTypeKG = 0,
    QNUnitTypeLB = 1,
    QNUnitTypeST = 2,
    QNUnitTypeSTLB = 3,
    QNUnitTypeJin = 4,
};

@interface QNUserInfo : NSObject

/// User ID
@property(nonatomic, strong) NSString *userId;
/// Gender (male or female)
@property (nonatomic, strong) NSString *gender;
/// Age (3 ~ 80)
@property (nonatomic, assign) int age;
/// selected（current user）
@property (nonatomic, assign) BOOL selected;

+ (QNUserInfo *)defaultUser;

+ (NSString *)getUserId;
@end

NS_ASSUME_NONNULL_END
