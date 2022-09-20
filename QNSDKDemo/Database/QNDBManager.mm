//
//  QNDBManager.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/10.
//

#import <UIKit/UIKit.h>
#import "QNDBManager.h"
#import "QNUserInfo+WCTTableCoding.h"

#define YLUserTableName @"UserTable"
@interface QNDBManager () {
    WCTDatabase *_database;
}
@end

@implementation QNDBManager

singleton_implementation(QNDBManager)

- (BOOL)initDataBase {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [documentPath stringByAppendingString:@"/qingniu.sqlite"];
    
    _database = [[WCTDatabase alloc] initWithPath:dbPath];
    if ([_database canOpen]) {
        if ([_database isOpened]) {
            [self createTable];
        }
    }
    return NO;
}

- (void)createTable {
    [_database createTableAndIndexesOfName:YLUserTableName withClass:QNUserInfo.class];
}

- (BOOL)insertOrReplaceUser:(QNUserInfo *)user {
    BOOL ret = [_database beginTransaction];
    ret = [_database insertOrReplaceObject:user into:YLUserTableName];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

- (QNUserInfo *)curUser {
    return [_database getOneObjectOfClass:QNUserInfo.class fromTable:YLUserTableName where:QNUserInfo.selected == YES];
}

- (NSArray<QNUserInfo *> *)getAllUserInfo {
    return [_database getAllObjectsOfClass:QNUserInfo.class fromTable:YLUserTableName];
}

- (BOOL)deleteUserWithUserId:(NSString *)userId {
    BOOL ret = [_database beginTransaction];
    ret = [_database deleteObjectsFromTable:YLUserTableName where:QNUserInfo.userId == userId];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}
@end
