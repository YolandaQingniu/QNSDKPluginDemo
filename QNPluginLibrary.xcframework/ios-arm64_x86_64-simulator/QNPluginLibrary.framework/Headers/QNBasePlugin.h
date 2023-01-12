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

- (NSString *)getAppId;

- (NSString *)getEncryption;

@end

NS_ASSUME_NONNULL_END
