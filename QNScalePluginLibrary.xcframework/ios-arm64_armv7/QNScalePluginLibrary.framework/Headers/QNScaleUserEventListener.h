//
//  QNScaleUserEventListener.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import "QNScaleDevice.h"
#import "QNScaleUser.h"
#import "QNUser.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QNScaleUserEventListener <NSObject>

/// Register user result
/// @param code int
/// @param user QNScaleUser
/// @param device QNScaleDevice
- (void)onRegisterUserResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device;

/// sync user info result
/// @param code int
/// @param user QNScaleUser
/// @param device QNScaleDevice
- (void)onSyncUserInfoResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device;

/// Delete users result
/// @param code int
/// @param device QNScaleDevice
- (void)onDeleteUsersResult:(int)code device:(QNScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
