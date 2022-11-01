//
//  HeightWeightScaleVC.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import <UIKit/UIKit.h>
#import <QNHeightWeightScalePluginLibrary/QNHeightWeightScalePluginLibrary.h>
NS_ASSUME_NONNULL_BEGIN

#define QNBLEStatusStr_Scaning @"Scanning"
#define QNBLEStatusStr_Connecting @"Connecting"
#define QNBLEStatusStr_Connected @"Connected"
#define QNBLEStatusStr_Measuring @"Measuring"
#define QNBLEStatusStr_MeasureDone @"MeasureDone"
#define QNBLEStatusStr_Disconnected @"Disconnected"
#define QNBLEStatusStr_ConnectedFailed @"ConnecteFailed"

@interface HeightWeightScaleVC : UIViewController

@property (nonatomic, assign) QNHeightUnit heightUnit;

@property (nonatomic, assign) QNWeightUnit weightUnit;

@end



@interface QNMeasureReport : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *value;

+ (instancetype)reportWithTitle:(NSString *)title value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
