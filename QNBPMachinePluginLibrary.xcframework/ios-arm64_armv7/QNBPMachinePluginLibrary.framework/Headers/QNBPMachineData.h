//
//  QNBPMachineData.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>
#import <QNBPMachinePluginLibrary/QNBPMachineDeploy.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNBPMachineResultType) {
    QNBPMachineResultTypeNormal_CHN = 0,
    QNBPMachineResultTypeNormalHighValue_CHN,
    QNBPMachineResultTypeFirstHighPressure_CHN,
    QNBPMachineResultTypeSecondHighPressure_CHN,
    QNBPMachineResultTypeThirdHighPressure_CHN,
    
    QNBPMachineResultTypeNormal_USA,
    QNBPMachineResultTypeNormalHighValue_USA,
    QNBPMachineResultTypeFirstHighPressure_USA,
    QNBPMachineResultTypeSecondHighPressure_USA,
    
    QNBPMachineResultTypeOptimalBloodPressure_EU,
    QNBPMachineResultTypeNormal_EU,
    QNBPMachineResultTypeNormalHighValue_EU,
    QNBPMachineResultTypeFirstHighPressure_EU,
    QNBPMachineResultTypeSecondHighPressure_EU,
    QNBPMachineResultTypeThirdHighPressure_EU,
    
    QNBPMachineResultTypeNormal_JPN,
    QNBPMachineResultTypeNormalHighValue_JPN,
    QNBPMachineResultTypeHighBloodPressure_JPN,
    QNBPMachineResultTypeFirstHighPressure_JPN,
    QNBPMachineResultTypeSecondHighPressure_JPN,
    QNBPMachineResultTypeThirdHighPressure_JPN,
};

@interface QNBPMachineData : NSObject
/// Time stamp
@property (nonatomic, strong) NSString *timeStamp;
/// User index (1~2)
@property (nonatomic, assign) int userIndex;
/// Unit
@property (nonatomic, assign) QNBPMachineUnit unit;
/// Systolic blood pressure
@property (nonatomic, strong) NSString *systolicBP;
/// Diastolic blood pressure
@property (nonatomic, strong) NSString *diastolicBP;
/// Heart rate
@property (nonatomic, strong) NSString *heartRate;
/// Blood pressure judgment result
@property (nonatomic, assign) QNBPMachineResultType resultType;

@end

NS_ASSUME_NONNULL_END
