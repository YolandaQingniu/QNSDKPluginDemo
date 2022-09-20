//
//  QNUserInfo.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/7.
//

#import "QNUserInfo.h"
#import "QNUserInfo+WCTTableCoding.h"
#import "QNDBManager.h"

@implementation QNUserInfo

WCDB_IMPLEMENTATION(QNUserInfo)
WCDB_SYNTHESIZE(QNUserInfo, userId)
WCDB_SYNTHESIZE(QNUserInfo, gender)
WCDB_SYNTHESIZE(QNUserInfo, age)
WCDB_SYNTHESIZE(QNUserInfo, selected)
WCDB_PRIMARY(QNUserInfo, userId)

+ (QNUserInfo *)defaultUser {
    QNUserInfo *user = [[QNUserInfo alloc] init];
    user.userId = [NSString stringWithFormat:@"%ld",(long)[NSDate date].timeIntervalSince1970];
    user.selected = YES;
    return user;
}

@end
