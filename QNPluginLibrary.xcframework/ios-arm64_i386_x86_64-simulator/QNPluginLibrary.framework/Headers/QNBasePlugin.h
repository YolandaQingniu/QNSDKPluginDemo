//
//  QNBasePlugin.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>
@class QNBleManager;

NS_ASSUME_NONNULL_BEGIN

@interface QNBasePlugin : NSObject

@property(nonatomic, strong) QNBleManager *bleManager;

/// 获取秘钥
- (NSString *)getEncryption;

@end

NS_ASSUME_NONNULL_END
