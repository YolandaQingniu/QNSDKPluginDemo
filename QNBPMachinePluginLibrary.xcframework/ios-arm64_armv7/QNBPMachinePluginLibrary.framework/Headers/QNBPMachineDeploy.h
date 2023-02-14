//
//  QNBPMachineDeploy.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNBPMachineUnit) {
    QNBPMachineUnitMMHG = 1, // mmHg
    QNBPMachineUnitKPA,      // kPa
};

typedef NS_ENUM(int, QNBPMachineVolume) {
    QNBPMachineVolumeMute = 1,     // Mute
    QNBPMachineVolumeFirstLevel,   // LV1
    QNBPMachineVolumeSecondLevel,  // LV2
    QNBPMachineVolumeThirdLevel,   // LV3
    QNBPMachineVolumeFourthLevel,  // LV4
    QNBPMachineVolumeFifthLevel,   // LV5
};

typedef NS_ENUM(int, QNBPMachineLanguage) {
    QNBPMachineLanguageChinese = 1,
    QNBPMachineLanguageEnglish,
};

typedef NS_ENUM(int, QNBPMachineStandard) {
    QNBPMachineStandardChina = 1,
    QNBPMachineStandardUSA,
    QNBPMachineStandardEurope,
    QNBPMachineStandardJapan,
};

@interface QNBPMachineDeploy : NSObject
/// Unit
@property (nonatomic, assign) QNBPMachineUnit unit;
/// Volume
@property (nonatomic, assign) QNBPMachineVolume volume;
/// Blood pressure standard
@property (nonatomic, assign) QNBPMachineStandard standard;
/// Language
@property (nonatomic, assign) QNBPMachineLanguage language;

@end

NS_ASSUME_NONNULL_END
