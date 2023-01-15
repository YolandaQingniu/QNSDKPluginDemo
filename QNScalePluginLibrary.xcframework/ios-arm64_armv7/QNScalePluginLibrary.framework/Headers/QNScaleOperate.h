//
//  QNScaleOperate.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNUnit) {
    QNUnitKg = 1,
    QNUnitLb = 2,
    QNUnitJin = 3,  //If the scale does not support the display of jin, it will display KG
    QNUnitStLb = 4, //If the scale does not support the display of STLB, it will display Lb
    QNUnitSt = 5,   //If the scale does not support the display of ST, it will display Lb
};

@interface QNScaleOperate : NSObject

/// Unit
@property(nonatomic, assign) QNUnit unit;

@end

NS_ASSUME_NONNULL_END
