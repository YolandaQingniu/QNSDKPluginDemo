//
//  ScaleUser.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/26.
//

#import "ScaleUser.h"
#import "ScaleUser+WCTTableCoding.h"

@implementation ScaleUser

WCDB_IMPLEMENTATION(ScaleUser)

WCDB_SYNTHESIZE(ScaleUser, scaleUserId)
WCDB_SYNTHESIZE(ScaleUser, secretIndex)
WCDB_SYNTHESIZE(ScaleUser, secretKey)
WCDB_SYNTHESIZE(ScaleUser, mac)

WCDB_MULTI_PRIMARY(ScaleUser, "_primary", scaleUserId)
WCDB_MULTI_PRIMARY(ScaleUser, "_primary", mac)

@end
