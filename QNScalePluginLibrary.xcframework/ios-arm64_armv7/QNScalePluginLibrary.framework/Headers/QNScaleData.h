//
//  QNScaleData.h
//  QNScalePlugin
//
//  Created by sumeng on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QNScaleData : NSObject

/// Time stamp  时间戳，单位s
@property (nonatomic, strong) NSString *timeStamp;
/// Weight  体重，单位kg 两位有效数值
@property (nonatomic, strong) NSString *weight;

/// Resistance 50Hz阻抗，整数
@property (nonatomic, strong) NSString *resistance50;
/// Resistance 500Hz阻抗，整数
@property (nonatomic, strong) NSString *resistance500;

@end

NS_ASSUME_NONNULL_END
