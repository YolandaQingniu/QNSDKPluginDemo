//
//  QNPlugin.h
//  QNPlugin
//
//  Created by sumeng on 2022/6/6.
//  QingNiuSDK

#import "QNBasePlugin.h"
#import "QNLogListener.h"
#import "QNScanListener.h"
#import "QNSysBleStatusListener.h"
#import "QNAuthDevice.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QNResultCallback) (int code);

@interface QNPlugin : QNBasePlugin

@property(nonatomic, weak) id<QNLogListener> logListener;

@property(nonatomic, weak) id<QNScanListener> scanListener;

@property(nonatomic, weak) id<QNSysBleStatusListener> sysBleStatusListener;

+ (instancetype)sharedPlugin;

- (void)initSdk:(NSString *)appId filePath:(NSString *)filePath callback:(QNResultCallback)callback;

- (QNAuthDevice * _Nullable)getAuthDevice:(NSString *)modelId;

- (int)getBluetoothEnable;

- (void)startScanCallback:(QNResultCallback)callback;

- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
