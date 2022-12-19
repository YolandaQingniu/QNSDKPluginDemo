//
//  FunctionModel.h
//  QNSDKDemo
//
//  Created by sumeng on 2022/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionModel : NSObject

@property (nonatomic, strong) NSString *dataId;

@property (nonatomic, assign) QNBPMachineUnit unitType;

@property (nonatomic, assign) QNBPMachineVolume volumeType;

@property (nonatomic, assign) QNBPMachineStandard standardType;

@property (nonatomic, assign) QNBPMachineLanguage languageType;

@end

NS_ASSUME_NONNULL_END
