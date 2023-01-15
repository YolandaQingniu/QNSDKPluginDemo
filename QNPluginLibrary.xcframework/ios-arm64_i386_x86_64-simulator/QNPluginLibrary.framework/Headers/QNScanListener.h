//
//  QNScanListener.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNScanListener <NSObject>

/// Launch scan results
/// @param code <#code description#>
- (void)onScanResult:(int)code;

/// Stop scanning
- (void)onStopScan;
@end

NS_ASSUME_NONNULL_END
