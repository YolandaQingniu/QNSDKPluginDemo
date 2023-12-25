//
//  QNScanListener.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNScanListener <NSObject>

///Start scanning
- (void)onStartScan;

/// Stop scanning
- (void)onStopScan;
@end

NS_ASSUME_NONNULL_END
