//
//  ScaleUser.h
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScaleUser : NSObject
/** Scale User ID*/
@property (nonatomic, strong) NSString *scaleUserId;
/** Scale User Index*/
@property (nonatomic, assign) int secretIndex;
/** Scale User Key*/
@property (nonatomic, assign) int secretKey;
/** mac*/
@property (nonatomic, strong) NSString *mac;
@end

NS_ASSUME_NONNULL_END
