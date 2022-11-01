//
//  QNUserInfo+WCTTableCoding.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/10.
//

#import "QNUserInfo.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNUserInfo (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(userId)
WCDB_PROPERTY(age)
WCDB_PROPERTY(gender)
WCDB_PROPERTY(selected)
WCDB_PROPERTY(height)

@end

NS_ASSUME_NONNULL_END
