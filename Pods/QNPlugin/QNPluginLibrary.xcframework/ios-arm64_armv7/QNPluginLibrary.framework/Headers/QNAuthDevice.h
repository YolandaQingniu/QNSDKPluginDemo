//
//  QNAuthDevice.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//  Authorized Device Information

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNAuthDevice : NSObject

/// Device name
@property(nonatomic, strong) NSString *model;
/// Device Model ID
@property (nonatomic, strong) NSString *modelId;

/// Device features
@property(nonatomic, strong) NSString *hmac;
@end

NS_ASSUME_NONNULL_END
