//
//  QNPlugin.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//  QingNiuSDK
//  V1.1.0

#import "QNBasePlugin.h"
#import "QNLogListener.h"
#import "QNScanListener.h"
#import "QNSysBleStatusListener.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QNResultCallback) (int code);

@interface QNPlugin : QNBasePlugin

@property(nonatomic, weak) id<QNLogListener> logListener;

@property(nonatomic, weak) id<QNScanListener> scanListener;

@property(nonatomic, weak) id<QNSysBleStatusListener> sysBleStatusListener;

+ (instancetype)sharedPlugin;

- (void)initSdkWithCallback:(QNResultCallback)callback;

- (QNSysBleStatus)getSysBleStatus;

- (int)startScan;

- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
