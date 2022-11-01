//
//  QNUserScaleMp.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/9.
//

#import <Foundation/Foundation.h>
#import "QNScaleUserEventListener.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNUserScaleMp : NSObject

/// Configure User Event listener
/// - Parameter userEventListener: listener
+ (void)setUserScaleEventListener:(id<QNScaleUserEventListener>)userEventListener;

/// set measure user info
/// @param user user info
/// @param device device
+ (int)setMeasureUserToUserDevice:(QNScaleUser *)user device:(QNScaleDevice *)device;

/// delete measure user info
/// @param userIndexList user's index
/// @param device device
+ (int)deleteUserList:(NSArray<NSNumber *> *)userIndexList device:(QNScaleDevice *)device;

@end

NS_ASSUME_NONNULL_END
