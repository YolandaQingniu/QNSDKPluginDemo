//
// QNDBManager.h
// SDKDemo
//
// Created by qingniu on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import "QNUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

#define singleton_interface(className) \
+ (className *)shared##className;

#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[super allocWithZone:zone] init]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [self alloc]; \
}); \
return _instance; \
}

@interface QNDBManager : NSObject

singleton_interface(QNDBManager)

- (BOOL)initDataBase;

#pragma mark -
#pragma mark - User

- (BOOL)insertOrReplaceUser:(QNUserInfo *)user;

///  current user
- (QNUserInfo *)curUser;

/// all user
- (NSArray <QNUserInfo *>*)getAllUserInfo;

/// delete user
- (BOOL)deleteUserWithUserId:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
