//
//  QNBasePlugin.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "QNDiscoverPeripheralListener.h"
@class QNBleManager;

NS_ASSUME_NONNULL_BEGIN

@interface QNBasePlugin : NSObject

@property(nonatomic, strong) QNBleManager *bleManager;

/// Discover device broadcast
@property(nonatomic, weak) id<QNDiscoverPeripheralListener> discoverPeripheralListener;
@end

NS_ASSUME_NONNULL_END
