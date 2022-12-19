//
// QNDBManager.h
// SDKDemo
//
// Created by qingniu on 2022/6/10.
//

#import <Foundation/Foundation.h>
#import "QNUserInfo.h"
#import "ScaleUser.h"
#import "BindDeviceModel.h"
#import "FunctionModel.h"

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

- (BOOL)updateUserInfo:(QNUserInfo *)user;

- (QNUserInfo *)userWithUserId:(NSString *)userId;

///  current user
- (QNUserInfo *)curUser;

/// all user
- (NSArray <QNUserInfo *>*)getAllUserInfo;

/// delete user
- (BOOL)deleteUserWithUserId:(NSString *)userId;

#pragma mark -
#pragma mark - ScaleUser

- (BOOL)insertOrReplaceScaleUser:(ScaleUser *)user;

- (BOOL)updateScaleUserInfo:(ScaleUser *)user mac:(NSString *)mac;

- (nullable ScaleUser *)scaleUserWithUserId:(NSString *)userId mac:(NSString *)mac;

- (BOOL)deleteScaleUserWithUserId:(NSString *)userId mac:(NSString *)mac;

#pragma mark -
#pragma mark - Bind Device
- (BOOL)insertOrReplaceBindDevice:(BindDeviceModel *)device;

- (NSArray <BindDeviceModel *>*)getAllBindDeviceWithUserId:(NSString *)userId;

/// delete user
- (BOOL)deleteDeviceWithUserId:(NSString *)userId mac:(NSString *)mac;

#pragma mark -
#pragma mark - BPMachine function
- (BOOL)insertOrReplaceFunctionMode:(FunctionModel *)model;

- (nullable FunctionModel *)functionModelWithDataId:(NSString *)dataId;

- (BOOL)deleteFunctionMode:(NSString *)dataId;

@end

NS_ASSUME_NONNULL_END
