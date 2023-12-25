//
//  QNMeasureReport.m
//  QNSDKDemo
//
//  Created by xiaopeng on 2023/12/25.
//

#import "QNMeasureReport.h"

@implementation QNMeasureReport

+ (instancetype)reportWithTitle:(NSString *)title value:(NSString *)value {
    if (title.length == 0) return nil;

    QNMeasureReport *data = [[self alloc] init];
    data.title = title;
    data.value = value;
    return data;
}

@end
