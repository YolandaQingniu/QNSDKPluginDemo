//
//  QNScaleUser.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/9.
//

#import "QNUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface QNScaleUser : QNUser
/// Scale user index (1~8)
@property (nonatomic, assign) int index;
/// Secret key
@property (nonatomic, assign) int key;
/// Visitor Mode
@property (nonatomic, assign) BOOL visitorMode;
@end

NS_ASSUME_NONNULL_END
