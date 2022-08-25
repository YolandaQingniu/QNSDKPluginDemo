//
//  QNSysBleStatusListener.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNSysBleStatusListener <NSObject>

/// System Bluetooth Status
/// @param code 0：Unknown；1：Resetting；2：Unsupported；3：Unauthorized；4：PoweredOff；5：PoweredOn
- (void)onSysBleStatus:(int)code;
@end

NS_ASSUME_NONNULL_END
