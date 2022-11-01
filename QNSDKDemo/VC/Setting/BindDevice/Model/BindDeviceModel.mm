//
//  BindDeviceModel.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/27.
//

#import "BindDeviceModel.h"
#import "BindDeviceModel+WCTTableCoding.h"
#import "QNDBManager.h"

@implementation BindDeviceModel

WCDB_IMPLEMENTATION(BindDeviceModel)

WCDB_SYNTHESIZE(BindDeviceModel, userId)
WCDB_SYNTHESIZE(BindDeviceModel, bleName)
WCDB_SYNTHESIZE(BindDeviceModel, modelId)
WCDB_SYNTHESIZE(BindDeviceModel, mode)
WCDB_SYNTHESIZE(BindDeviceModel, mac)
WCDB_SYNTHESIZE(BindDeviceModel, rssi)
WCDB_SYNTHESIZE(BindDeviceModel, firmwareVer)
WCDB_SYNTHESIZE(BindDeviceModel, supportWiFiFlag)
WCDB_SYNTHESIZE(BindDeviceModel, supportScaleUserFlag)
WCDB_SYNTHESIZE(BindDeviceModel, scaleUserFullFlag)

WCDB_MULTI_PRIMARY(BindDeviceModel, "_primary", userId)
WCDB_MULTI_PRIMARY(BindDeviceModel, "_primary", mac)

+ (instancetype)bindDeviceWithQNScale:(QNScaleDevice *)device {
    QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
    
    BindDeviceModel *model = [[self alloc] init];
    model.userId = curUser.userId;
    model.bleName = device.bleName;
    model.modelId = device.modelId;
    model.mode = device.mode;
    model.rssi = device.rssi;
    model.mac = device.mac;
    model.firmwareVer = device.firmwareVer;
    model.supportWiFiFlag = [device getSupportWiFi];
    model.supportScaleUserFlag = [device getSupportScaleUser];
    model.scaleUserFullFlag = [device getScaleUserFull];
    
    return model;
}

@end
