//
//  BindDeviceModel+WCTTableCoding.h
//  QNSDKDemo
//
//  Created by qushaohua on 2022/10/27.
//

#import "BindDeviceModel.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindDeviceModel (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(userId)
WCDB_PROPERTY(bleName)
WCDB_PROPERTY(modelId)
WCDB_PROPERTY(mode)
WCDB_PROPERTY(mac)
WCDB_PROPERTY(rssi)
WCDB_PROPERTY(firmwareVer)
WCDB_PROPERTY(supportWiFiFlag)
WCDB_PROPERTY(supportScaleUserFlag)
WCDB_PROPERTY(scaleUserFullFlag)

@end

NS_ASSUME_NONNULL_END
