//
//  QNScaleData.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>
#import <QNScalePluginLibrary/QNUser.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNScaleData : NSObject

/// Is data complete
@property (nonatomic, assign) BOOL isDataComplete;
/// Time stamp
@property (nonatomic, strong) NSString *timeStamp;
/// hmac
@property (nonatomic, strong) NSString *hmac;
/// User info
@property (nonatomic, strong, nullable) QNUser *user;

/// Weight
@property (nonatomic, strong) NSString *weight;
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
/// Heart rate
@property (nonatomic, strong) NSString *heartRate;
/// Heart index
@property (nonatomic, strong) NSString *heartIndex;
/// FattyLiver risk level
@property (nonatomic, strong) NSString *fattyLiverRiskLevel;
/// Resistance 50KHZ
@property (nonatomic, strong) NSString *res50KHZ;
/// Resistance 500KHZ
@property (nonatomic, strong) NSString *res500KHZ;

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

/// Eight-electrode professional equipment indicators
@property (nonatomic, strong) NSString *leftArmBodyfatRate;
@property (nonatomic, strong) NSString *leftLegBodyfatRate;
@property (nonatomic, strong) NSString *rightArmBodyfatRate;
@property (nonatomic, strong) NSString *rightLegBodyfatRate;
@property (nonatomic, strong) NSString *trunkBodyfatRate;

@property (nonatomic, assign) NSString *leftArmFatMass;
@property (nonatomic, assign) NSString *leftLegFatMass;
@property (nonatomic, assign) NSString *rightArmFatMass;
@property (nonatomic, assign) NSString *rightLegFatMass;
@property (nonatomic, assign) NSString *trunkFatMass;

@property (nonatomic, strong) NSString *leftArmMuscleMass;
@property (nonatomic, strong) NSString *leftLegMuscleMass;
@property (nonatomic, strong) NSString *rightArmMuscleMass;
@property (nonatomic, strong) NSString *rightLegMuscleMass;
@property (nonatomic, strong) NSString *trunkMuscleMass;

/// Skeletal muscle mass
@property (nonatomic, strong) NSString *skeletalMuscleMass;
/// Mineral salt rate
@property (nonatomic, strong) NSString *mineralSaltRate;

/// Make scale data complete
/// @param user data owner
- (QNScaleData *)makeDataComplete:(QNUser *)user;

@end

NS_ASSUME_NONNULL_END
