//
//  FunctionModel+WCTTableCoding.h
//  QNSDKDemo
//
//  Created by sumeng on 2022/12/14.
//

#import "FunctionModel.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionModel (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(dataId)
WCDB_PROPERTY(unitType)
WCDB_PROPERTY(volumeType)
WCDB_PROPERTY(standardType)
WCDB_PROPERTY(languageType)

@end

NS_ASSUME_NONNULL_END
