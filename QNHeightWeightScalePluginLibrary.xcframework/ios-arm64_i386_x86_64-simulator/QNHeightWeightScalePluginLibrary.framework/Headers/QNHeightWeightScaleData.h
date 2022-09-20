//
//  QNHeightWeightScaleData.h
//  QNHeightWeightScalePlugin
//
//  Created by sumeng on 2022/8/9.
//

#import <Foundation/Foundation.h>
#import <QNHeightWeightScalePluginLibrary/QNHeightWeightUser.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNHeightWeightMode) {
    QNHeightWeightModeHeightWeight = 0,
    QNHeightWeightModeHeightBodyFat,
};

@interface QNHeightWeightScaleData : NSObject

/// Is data complete
@property (nonatomic, assign) BOOL isDataComplete;
/// Device mode
@property(nonatomic, assign) QNHeightWeightMode deviceMode;
/// Time stamp
@property (nonatomic, strong) NSString *timeStamp;
/// hmac
@property (nonatomic, strong) NSString *hmac;
/// User info
@property (nonatomic, strong, nullable) QNHeightWeightUser *user;

/// Weight
@property (nonatomic, strong) NSString *weight;
/// Height
@property (nonatomic, strong) NSString *height;
/// BMI
@property (nonatomic, strong) NSString *BMI;
/// Body fat rate
@property (nonatomic, strong) NSString *bodyFatRate;

/// Subcutaneous fat rate
@property (nonatomic, strong) NSString *subcutaneousFatRate;
/// Visceral fat level
@property (nonatomic, strong) NSString *visceralFatLevel;
/// Body water rate
@property (nonatomic, strong) NSString *bodyWaterRate;
/// Skeletal muscle rate
@property (nonatomic, strong) NSString *skeletalMuscleRate;

/// Bone mass
@property (nonatomic, strong) NSString *boneMass;
/// BMR
@property (nonatomic, strong) NSString *BMR;
/// Body type
@property (nonatomic, strong) NSString *bodyType;
/// Protein rate
@property (nonatomic, strong) NSString *proteinRate;

/// Lean body mass
@property (nonatomic, strong) NSString *leanBodyMass;
/// Muscle mass
@property (nonatomic, strong) NSString *muscleMass;
/// Body age
@property (nonatomic, strong) NSString *bodyAge;
/// Health score
@property (nonatomic, strong) NSString *healthScore;

/// FattyLiver risk level
@property (nonatomic, strong) NSString *fattyLiverRiskLevel;
/// Body fat mass
@property (nonatomic, strong) NSString *bodyFatMass;
/// Obesity
@property (nonatomic, strong) NSString *obesity;
/// Body water mass
@property (nonatomic, strong) NSString *bodyWaterMass;

/// Protein mass
@property (nonatomic, strong) NSString *proteinMass;
/// Mineral level（low; stand; enough）
@property (nonatomic, strong) NSString *mineralLevel;
/// Dream weight
@property (nonatomic, strong) NSString *dreamWeight;
/// Stand weight
@property (nonatomic, strong) NSString *standWeight;

/// Weight control
@property (nonatomic, strong) NSString *weightControl;
/// Body fat control
@property (nonatomic, strong) NSString *bodyFatControl;
/// Muscle mass control
@property (nonatomic, strong) NSString *muscleMassControl;
/// Muscle rate
@property (nonatomic, strong) NSString *muscleRate;

/// Make scale data complete
/// @param user data owner
- (QNHeightWeightScaleData *)makeDataComplete:(QNHeightWeightUser *)user;

@end

NS_ASSUME_NONNULL_END
