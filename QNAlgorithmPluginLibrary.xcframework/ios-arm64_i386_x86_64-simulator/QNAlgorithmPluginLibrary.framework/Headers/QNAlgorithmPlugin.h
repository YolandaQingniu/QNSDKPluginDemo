//
//  QNAlgorithmPlugin.h
//  QNAlgorithmPlugin
//
//  Created by sumeng on 2022/6/16.
//  

#import <Foundation/Foundation.h>
#import "QNAlgorithmData.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNAlgorithmPlugin : NSObject

/// Calculate the data
/// @param hmac Data characteristics
/// @param lastHmac Previous data characteristics
+ (QNAlgorithmData *)algorithm:(NSString *)hmac lastHmac:(NSString * _Nullable)lastHmac;

@end
NS_ASSUME_NONNULL_END
