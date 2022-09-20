//
//  QNRulerData.h
//  QNRulerPluginLibrary
//
//  Created by zhoushenbin on 2022/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int, QNRulerUnit) {
    QNRulerUnitCm = 0,  // cm
    QNRulerUnitInch,    // inch
};

@interface QNRulerData : NSObject

/// Time stamp(This value is unavailable for real-time data)
@property (nonatomic, strong) NSString *timeTemp;
/// Ruler's Value
@property (nonatomic, strong) NSString *value;
/// Ruler's Unit
@property (nonatomic, assign) QNRulerUnit unit;

@end

NS_ASSUME_NONNULL_END
