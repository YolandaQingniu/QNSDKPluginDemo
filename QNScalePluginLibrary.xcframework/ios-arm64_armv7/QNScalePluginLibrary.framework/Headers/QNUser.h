//
//  QNUser.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNUser : NSObject
/// User ID
@property (nonatomic, strong) NSString *userId;
/// Gender (male or female)
@property (nonatomic, strong) NSString *gender;
/// Age
@property (nonatomic, assign) int age;
/// Height (40~240cm)
@property (nonatomic, assign) int height;
/// SportMode (Valid for users over 18 years old)
@property (nonatomic, assign) BOOL sportMode;

@end

NS_ASSUME_NONNULL_END
