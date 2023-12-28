//
//  QNMeasureReport.h
//  QNSDKDemo
//
//  Created by xiaopeng on 2023/12/25.
//

#import <Foundation/Foundation.h>

#define QNBLEStatusStr_Scaning @"Scanning"
#define QNBLEStatusStr_Connecting @"Connecting"
#define QNBLEStatusStr_Connected @"Connected"
#define QNBLEStatusStr_Interactive @"Interactive"
#define QNBLEStatusStr_Measuring @"Measuring"
#define QNBLEStatusStr_MeasureDone @"MeasureDone"
#define QNBLEStatusStr_Disconnected @"Disconnected"
#define QNBLEStatusStr_ConnectedFailed @"ConnecteFailed"

NS_ASSUME_NONNULL_BEGIN

@interface QNMeasureReport : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *value;

+ (instancetype)reportWithTitle:(NSString *)title value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
