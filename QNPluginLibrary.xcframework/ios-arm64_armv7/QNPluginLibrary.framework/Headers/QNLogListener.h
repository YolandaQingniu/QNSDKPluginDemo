//
//  QNLogListener.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QNLogListener <NSObject>

/// output log
/// @param log NSString
- (void)onLog:(NSString *)log;
@end

NS_ASSUME_NONNULL_END
