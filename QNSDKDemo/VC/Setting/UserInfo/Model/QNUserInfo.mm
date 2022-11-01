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
WCDB_SYNTHESIZE(QNUserInfo, height)
WCDB_SYNTHESIZE(QNUserInfo, selected)

WCDB_PRIMARY(QNUserInfo, userId)


+ (QNUserInfo *)currentUser {
    return [[QNDBManager sharedQNDBManager] curUser];
}

@end
