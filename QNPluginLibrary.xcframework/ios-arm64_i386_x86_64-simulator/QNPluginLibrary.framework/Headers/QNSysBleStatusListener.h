//
//  QNSysBleStatusListener.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNSysBleStatus) {
    QNSysBleStatusUnknown = 0,      //Unknown
    QNSysBleStatusResetting,        //Resetting
    QNSysBleStatusUnsupported,      //Unsupported
    QNSysBleStatusUnauthorized,     //Unauthorized
    QNSysBleStatusPoweredOff,       //Unauthorized
    QNSysBleStatusPoweredOn,        //PoweredOn
};

@protocol QNSysBleStatusListener <NSObject>

/// System Bluetooth Status
/// @param code QNSysBleStatus
- (void)onSysBleStatus:(QNSysBleStatus)code;
@end

NS_ASSUME_NONNULL_END
