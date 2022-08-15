//
//  QNUnitTool.h
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct QNWeightUnitSTLB {
    int st;
    float lb;
};

typedef struct QNWeightUnitSTLB QNWeightUnitSTLB;

@interface QNUnitTool : NSObject

/// kg -> lb
/// @param kg kg
+ (CGFloat)lbFromKg:(CGFloat)kg;

/// lb -> kg
/// @param lb lb
+ (CGFloat)kgFromLb:(CGFloat)lb;

/// st -> kg
/// @param st kg
+ (CGFloat)kgFromSt:(CGFloat)st;

/// kg -> st
/// @param kg  kg
+ (CGFloat)stFromKg:(CGFloat)kg;

/// lb -> st_lb
/// @param lb lb
+ (QNWeightUnitSTLB)getWeightUnitStFromLb:(CGFloat)lb;

/// cm -> ft
/// @param cm cm
+ (NSString *)ftFromCm:(CGFloat)cm;


@end
