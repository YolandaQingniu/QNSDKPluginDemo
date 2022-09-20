//
//  QNAlgorithmData.h
//  QNAlgorithmPlugin
//
//  Created by sumeng on 2022/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNAlgorithmData : NSObject

/// hmac
@property (nonatomic, strong) NSString *hmac;

/// 测量时间
@property (nonatomic, strong) NSString *timeStamp;

/// 体重
@property (nonatomic, strong) NSString *weight;
/// 身高
@property (nonatomic, strong) NSString *height;
/// BMI
@property (nonatomic, strong) NSString *BMI;
/// 体脂率
@property (nonatomic, strong) NSString *bodyFatRate;
/// 皮下脂肪率
@property (nonatomic, strong) NSString *subcutaneousFatRate;
/// 内脏脂肪等级
@property (nonatomic, strong) NSString *visceralFatLevel;
/// 身体水分率
@property (nonatomic, strong) NSString *bodyWaterRate;
/// 骨骼肌率
@property (nonatomic, strong) NSString *skeletalMuscleRate;
/// 骨量
@property (nonatomic, strong) NSString *boneMass;
/// BMR
@property (nonatomic, strong) NSString *BMR;
/// 体型
@property (nonatomic, strong) NSString *bodyType;
/// 蛋白质率
@property (nonatomic, strong) NSString *proteinRate;
/// 去脂体重
@property (nonatomic, strong) NSString *leanBodyMass;
/// 肌肉量
@property (nonatomic, strong) NSString *muscleMass;
/// 体年龄
@property (nonatomic, strong) NSString *bodyAge;
/// 健康分数
@property (nonatomic, strong) NSString *healthScore;
/// 心率
@property (nonatomic, strong) NSString *heartRate;
/// 心脏指数
@property (nonatomic, strong) NSString *heartIndex;
/// 脂肪肝风险等级
@property (nonatomic, strong) NSString *fattyLiverRiskLevel;
/// 50加密阻抗
@property (nonatomic, strong) NSString *res50KHZ;
/// 500加密阻抗
@property (nonatomic, strong) NSString *res500KHZ;

/// 脂肪量
@property (nonatomic, strong) NSString *bodyFatMass;
/// 肥胖度
@property (nonatomic, strong) NSString *obesity;
/// 含水量
@property (nonatomic, strong) NSString *bodyWaterMass;
/// 蛋白质量
@property (nonatomic, strong) NSString *proteinMass;
/// 无机盐状况（low; stand; enough）
@property (nonatomic, strong) NSString *mineralLevel;
/// 理想视觉体重
@property (nonatomic, strong) NSString *dreamWeight;
/// 标准体重
@property (nonatomic, strong) NSString *standWeight;
/// 体重控制量
@property (nonatomic, strong) NSString *weightControl;
/// 脂肪控制量
@property (nonatomic, strong) NSString *bodyFatControl;
/// 肌肉控制量
@property (nonatomic, strong) NSString *muscleMassControl;
/// 肌肉率
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

/// 骨骼肌量
@property (nonatomic, strong) NSString *skeletalMuscleMass;
/// 无机盐百分比
@property (nonatomic, strong) NSString *mineralSaltRate;
@end

NS_ASSUME_NONNULL_END
