//
//  QNScaleStoredData.h
//  QNScalePluginLibrary
//
//  Created by qushaohua on 2022/9/29.
//

#import <Foundation/Foundation.h>
#import "QNUser.h"
#import "QNScaleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNScaleStoredData : NSObject
/// Is data complete
@property (nonatomic, assign) BOOL isDataComplete;
/// Time stamp
@property (nonatomic, strong) NSString *timeStamp;
/// hmac
@property (nonatomic, strong) NSString *hmac;
/// weight
@property (nonatomic, strong) NSString *weight;

- (int)setUser:(QNUser *)user;

- (QNScaleData *)getScaleData;

@end

NS_ASSUME_NONNULL_END
