//
//  QNKitchenScaleData.h
//  QNKitchenScalePlugin
//
//  Created by sumeng on 2022/7/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNKitchenScaleStandbyTimeType) {
    QNKitchenScaleStandbyTimeType120S = 0,   //2 mins（ default ）
    QNKitchenScaleStandbyTimeType210S,       //3.5 mins
    QNKitchenScaleStandbyTimeType300S,       //5 mins
};

typedef NS_ENUM(int, QNKitchenScaleNumberType) {
    QNKitchenScaleNumberTypeInteger = 0, //integer
    QNKitchenScaleNumberTypeOneDecimal, //one decimal
    QNKitchenScaleNumberTypeTwoDecimal, //two decimal
};

typedef NS_ENUM(int, QNKitchenScaleRangeType) {
    QNKitchenScaleRangeType3KG = 0, //0~3kg
    QNKitchenScaleRangeType5KG,     //0~5kg
};

typedef NS_ENUM(int, QNKitchenUnit) {
    QNKitchenUnitG,
    QNKitchenUnitML,
    QNKitchenUnitOZ,
    QNKitchenUnitLBOZ,
    QNKitchenUnitMilkML
};

@interface QNKitchenScaleData : NSObject
/** weight */
@property (nonatomic, strong) NSString *weight;
/** unit */
@property (nonatomic, assign) QNKitchenUnit unit;
/** timeStamp */
@property (nonatomic, strong) NSString *timeStamp;
/** is Shell */
@property (nonatomic, assign) BOOL isShellingFlag;
/** is Reverse Weight */
@property (nonatomic, assign) BOOL isReverseWeightFlag;
/** is OverWeight */
@property (nonatomic, assign) BOOL isOverWeightFlag;
/** is Stable */
@property (nonatomic, assign) BOOL isStableFlag;

@end

NS_ASSUME_NONNULL_END
