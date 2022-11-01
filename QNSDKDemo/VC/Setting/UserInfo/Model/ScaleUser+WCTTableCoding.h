//
//  ScaleUser+WCTTableCoding.h
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/26.
//

#import "ScaleUser.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScaleUser (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(scaleUserId)
WCDB_PROPERTY(secretIndex)
WCDB_PROPERTY(secretKey)
WCDB_PROPERTY(mac)

@end

NS_ASSUME_NONNULL_END
