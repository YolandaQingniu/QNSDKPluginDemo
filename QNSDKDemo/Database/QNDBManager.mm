//
//  QNDBManager.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/10.
//

#import <UIKit/UIKit.h>
#import "QNDBManager.h"
#import "QNUserInfo+WCTTableCoding.h"
#import "ScaleUser+WCTTableCoding.h"
#import "BindDeviceModel+WCTTableCoding.h"
#import "FunctionModel+WCTTableCoding.h"

#define YLUserTableName @"UserTable"
#define YLScaleUserTableName @"ScaleUserTable"
#define YLBindDeviceTableName @"BindDeviceTable"
#define YLFunctionModelTableName @"FunctionModelTable"

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
    [_database createTableAndIndexesOfName:YLScaleUserTableName withClass:ScaleUser.class];
    [_database createTableAndIndexesOfName:YLUserTableName withClass:QNUserInfo.class];
    [_database createTableAndIndexesOfName:YLBindDeviceTableName withClass:BindDeviceModel.class];
    [_database createTableAndIndexesOfName:YLFunctionModelTableName withClass:FunctionModel.class];
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

- (BOOL)updateUserInfo:(QNUserInfo *)user {
    if (user == nil || user.userId.length == 0) return NO;
    [_database updateRowsInTable:YLUserTableName onProperty:QNUserInfo.selected withObject:user where:QNUserInfo.userId == user.userId];
    return YES;
}

- (QNUserInfo *)userWithUserId:(NSString *)userId {
    if (userId.length == 0) return nil;
    
    QNUserInfo *user = [_database getOneObjectOfClass:QNUserInfo.class fromTable:YLUserTableName where:QNUserInfo.userId == userId];
    return user == nil? [self defaultUser] : user;
}

- (QNUserInfo *)curUser {
    QNUserInfo *user = [_database getOneObjectOfClass:QNUserInfo.class fromTable:YLUserTableName where:QNUserInfo.selected == YES];
    return user == nil? [self defaultUser] : user;
}

- (NSArray<QNUserInfo *> *)getAllUserInfo {
    NSArray *userArray = [_database getAllObjectsOfClass:QNUserInfo.class fromTable:YLUserTableName];
    return userArray.count == 0? @[[self defaultUser]] : userArray;
}

- (QNUserInfo *)defaultUser {
    QNUserInfo *user = [[QNUserInfo alloc] init];
    user.userId = [NSString stringWithFormat:@"%ld",(long)[NSDate date].timeIntervalSince1970];
    user.gender = @"male";
    user.age = 18;
    user.height = 180;
    user.selected = YES;
    [self insertOrReplaceUser:user];
    return user;
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

#pragma mark - ScaleUser
- (BOOL)insertOrReplaceScaleUser:(ScaleUser *)user {
    BOOL ret = [_database beginTransaction];
    ret = [_database insertOrReplaceObject:user into:YLScaleUserTableName];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

- (BOOL)updateScaleUserInfo:(ScaleUser *)user mac:(NSString *)mac {
    if (user == nil || user.scaleUserId.length == 0) return NO;
    
    [_database updateRowsInTable:YLScaleUserTableName onProperties:ScaleUser.secretIndex withObject:user where:ScaleUser.scaleUserId == user.scaleUserId && ScaleUser.mac == mac];
    [_database updateRowsInTable:YLScaleUserTableName onProperties:ScaleUser.secretKey withObject:user where:ScaleUser.scaleUserId == user.scaleUserId && ScaleUser.mac == mac];
    return YES;
}

- (ScaleUser *)scaleUserWithUserId:(NSString *)userId mac:(NSString *)mac {
    return [_database getOneObjectOfClass:ScaleUser.class fromTable:YLScaleUserTableName where:ScaleUser.scaleUserId == userId && ScaleUser.mac == mac];
}

- (BOOL)deleteScaleUserWithUserId:(NSString *)userId mac:(NSString *)mac {
    BOOL ret = [_database beginTransaction];
    ret = [_database deleteObjectsFromTable:YLScaleUserTableName where:ScaleUser.scaleUserId == userId && ScaleUser.mac == mac];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

#pragma mark -
#pragma mark - Bind Device
- (BOOL)insertOrReplaceBindDevice:(BindDeviceModel *)device {
    BOOL ret = [_database beginTransaction];
    ret = [_database insertOrReplaceObject:device into:YLBindDeviceTableName];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

- (NSArray<BindDeviceModel *> *)getAllBindDeviceWithUserId:(NSString *)userId {
    return [_database getObjectsOfClass:BindDeviceModel.class fromTable:YLBindDeviceTableName where:BindDeviceModel.userId == userId];
}

- (BOOL)deleteDeviceWithUserId:(NSString *)userId mac:(NSString *)mac {
    BOOL ret = [_database beginTransaction];
    ret = [_database deleteObjectsFromTable:YLBindDeviceTableName where:BindDeviceModel.userId == userId && BindDeviceModel.mac == mac];
    
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

#pragma mark -
#pragma mark - BPMachine function
- (BOOL)insertOrReplaceFunctionMode:(FunctionModel *)model {
    BOOL ret = [_database beginTransaction];
    ret = [_database insertOrReplaceObject:model into:YLFunctionModelTableName];
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

- (nullable FunctionModel *)functionModelWithDataId:(NSString *)dataId {
    FunctionModel *tempModel = [_database getOneObjectOfClass:FunctionModel.class fromTable:YLFunctionModelTableName where: FunctionModel.dataId == dataId];
    if (tempModel == nil) {
        tempModel = [[FunctionModel alloc] init];
        tempModel.unitType = QNBPMachineUnitMMHG;
        tempModel.volumeType = QNBPMachineVolumeFirstLevel;
        tempModel.standardType = QNBPMachineStandardChina;
        tempModel.languageType = QNBPMachineLanguageChinese;
        tempModel.dataId = dataId;
    }
    return tempModel;
}

- (BOOL)deleteFunctionMode:(NSString *)dataId{
    BOOL ret = [_database beginTransaction];
    ret = [_database deleteObjectsFromTable:YLFunctionModelTableName where:FunctionModel.dataId == dataId];
    if (ret) {
        [_database commitTransaction];
    }else {
        [_database rollbackTransaction];
    }
    return ret;
}

@end
