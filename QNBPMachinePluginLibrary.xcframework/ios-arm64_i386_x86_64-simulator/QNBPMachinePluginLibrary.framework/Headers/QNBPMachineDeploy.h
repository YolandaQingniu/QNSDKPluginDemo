//
//  QNBPMachineDeploy.h
//  QNBPMachinePluginLibrary
//
//  Created by sumeng on 2022/12/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNBPMachineUnit) {
    QNBPMachineUnitMMHG = 0, // mmHg
    QNBPMachineUnitKPA,      // kPa
};

typedef NS_ENUM(int, QNBPMachineVolume) {
    QNBPMachineVolumeMute = 0,     // Mute
    QNBPMachineVolumeFirstLevel,   // LV1
    QNBPMachineVolumeSecondLevel,  // LV2
    QNBPMachineVolumeThirdLevel,   // LV3
    QNBPMachineVolumeFourthLevel,  // LV4
    QNBPMachineVolumeFifthLevel,   // LV5
};

typedef NS_ENUM(int, QNBPMachineLanguage) {
    QNBPMachineLanguageChinese = 0,
    QNBPMachineLanguageEnglish,
};

typedef NS_ENUM(int, QNBPMachineStandard) {
    QNBPMachineStandardChina = 0,
    QNBPMachineStandardUSA,
    QNBPMachineStandardEurope,
    QNBPMachineStandardJapan,
};

typedef NS_ENUM(int,QNBPMachineTimeZone) {
    QNBPMachineTimeZoneUTC = 0x00,   // Zero time zone
    
    QNBPMachineTimeZoneE1 = 0x04,
    QNBPMachineTimeZoneE2 = 0x08,
    QNBPMachineTimeZoneE3 = 0x0C,
    QNBPMachineTimeZoneE4 = 0x10,
    QNBPMachineTimeZoneE5 = 0x14,
    QNBPMachineTimeZoneE6 = 0x18,
    QNBPMachineTimeZoneE7 = 0x1C,
    QNBPMachineTimeZoneE8 = 0x20,  // East Eighth District
    QNBPMachineTimeZoneE9 = 0x24,
    QNBPMachineTimeZoneE10 = 0x28,
    QNBPMachineTimeZoneE11 = 0x2C,
    QNBPMachineTimeZoneE12 = 0x30,
    
    QNBPMachineTimeZoneW1 = 0x84,
    QNBPMachineTimeZoneW2 = 0x88,
    QNBPMachineTimeZoneW3 = 0x8C,
    QNBPMachineTimeZoneW4 = 0x90,
    QNBPMachineTimeZoneW5 = 0x94,
    QNBPMachineTimeZoneW6 = 0x98,
    QNBPMachineTimeZoneW7 = 0x9C,
    QNBPMachineTimeZoneW8 = 0xA0,  // West Eighth District
    QNBPMachineTimeZoneW9 = 0xA4,
    QNBPMachineTimeZoneW10 = 0xA8,
    QNBPMachineTimeZoneW11 = 0xAC,
    QNBPMachineTimeZoneW12 = 0xB0, 
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
/// Time zone
@property (nonatomic, assign) QNBPMachineTimeZone timeZone;

@end

NS_ASSUME_NONNULL_END
