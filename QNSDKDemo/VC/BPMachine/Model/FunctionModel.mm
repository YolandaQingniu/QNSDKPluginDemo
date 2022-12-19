//
//  FunctionModel.m
//  QNSDKDemo
//
//  Created by sumeng on 2022/12/14.
//

#import "FunctionModel.h"
#import "FunctionModel+WCTTableCoding.h"

@implementation FunctionModel

WCDB_IMPLEMENTATION(FunctionModel)

WCDB_SYNTHESIZE(FunctionModel, dataId)
WCDB_SYNTHESIZE(FunctionModel, unitType)
WCDB_SYNTHESIZE(FunctionModel, volumeType)
WCDB_SYNTHESIZE(FunctionModel, standardType)
WCDB_SYNTHESIZE(FunctionModel, languageType)

WCDB_PRIMARY(FunctionModel, dataId)

@end
