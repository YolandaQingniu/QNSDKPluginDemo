//
//  QNHeightWeightScaleOperate.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 秤单位设置
typedef NS_ENUM(int, QNWeightUnit) {
    QNWeightUnitKg = 0,
    QNWeightUnitLb ,
    QNWeightUnitJin,
    QNWeightUnitSt,
    QNWeightUnitStLb,
};

typedef NS_ENUM(int, QNHeightUnit) {
    QNHeightUnitCm = 0,
    QNHeightUnitFt,
};

@interface QNHeightWeightScaleOperate : NSObject

/// Weight uni
@property (nonatomic, assign) QNWeightUnit weightUnit;

/// Height unit
@property (nonatomic, assign) QNHeightUnit heightUnit;

@end

NS_ASSUME_NONNULL_END
