//
//  QNUnitTool.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//


#import "QNUnitTool.h"

#define UnitKG @"kg"
#define UnitLB @"lb"
#define UnitST @"st"
#define UnitSTLB @"stlb"
#define UnitJin @"jin"

@implementation QNUnitTool

#pragma mark kg -> lb
+ (CGFloat)lbFromKg:(CGFloat)kg{
    CGFloat lbValue = ((int)(((kg * 100) * 11023 + 50000)/100000) << 1 ) / 10.0;
    return lbValue;
}

#pragma mark lb -> kg
+ (CGFloat)kgFromLb:(CGFloat)lb {
    CGFloat lbValue = lb*10000/11023/2;
    return lbValue;
}

#pragma mark st -> kg
+ (CGFloat)kgFromSt:(CGFloat)st {
    return [self kgFromLb:st * 14.0];
}

#pragma mark kg -> st
+ (CGFloat)stFromKg:(CGFloat)kg {
    CGFloat lb = [self lbFromKg:kg];
    return (floorf(lb/14.0*100.0 + 0.5))/100.0;
}

#pragma mark lb -> st_lb
+ (QNWeightUnitSTLB)getWeightUnitStFromLb:(CGFloat)lb{
    int st = lb / 14;
    float remainder = lb - st * 14;
    
    QNWeightUnitSTLB weightUnitSt;
    weightUnitSt.st = st;
    weightUnitSt.lb = remainder;
    return weightUnitSt;
}

#pragma mark - cm -> ft
+ (NSString *)ftFromCm:(CGFloat)cm {
    CGFloat inch = cm / 2.54;
    
    NSString *inchStr = [NSString stringWithFormat:@"%.1f", inch];
    
    NSArray *arr = [inchStr componentsSeparatedByString:@"."];
    NSString *str1 = arr[0];
    NSString *str2 = arr[1];
    
    NSInteger feet = [str1 integerValue] / 12;
    NSInteger inchPrefix = [str1 integerValue] % 12;
    
    if (feet == 0) {
        return [NSString stringWithFormat:@"%ld.%@''", (long)inchPrefix, str2];
    }
    return [NSString stringWithFormat:@"%ld'%ld.%@''", (long)feet, (long)inchPrefix, str2];
}


@end
