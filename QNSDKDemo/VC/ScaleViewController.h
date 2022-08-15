//
//  ScaleViewController.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import <UIKit/UIKit.h>
//#import "QNHeightWeightScalePlugin.h"
#import <QNHeightWeightScalePlugin/QNHeightWeightScalePlugin.h>
//#import ".h"
NS_ASSUME_NONNULL_BEGIN

@interface ScaleViewController : UIViewController

@property (nonatomic, assign) QNHeightUnit heightUnit;

@property (nonatomic, assign) QNWeightUnit weightUnit;

@end



@interface QNMeasureReport : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *value;

+ (instancetype)reportWithTitle:(NSString *)title value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
