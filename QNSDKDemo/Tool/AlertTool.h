//
//  AlertTool.h
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AlertBlock)(void);

@interface AlertTool : NSObject

+ (void)showAlertMsg:(NSString *)msg;

+ (void)showAlertMsg:(NSString *)msg cancelHandle:(nullable AlertBlock)cancelBlock sureHandle:(nullable AlertBlock)sureBlock;

@end

NS_ASSUME_NONNULL_END
