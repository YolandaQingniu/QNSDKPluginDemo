//
//  RulerVC.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/9/20.
//

#import "RulerVC.h"
#import <QNPluginLibrary/QNPluginLibrary.h>
#import <QNRulerPluginLibrary/QNRulerPluginLibrary.h>

@interface RulerVC ()<QNRulerDataListener, QNRulerDeviceListener>

@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, strong) QNRulerDevice *connectDevice;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@end

@implementation RulerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLbl];
    [self initBlePlugin];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.plugin startScan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.isConnected = NO;
    [self.plugin stopScan];
    [QNRulerPlugin cancelConnectDevice:self.connectDevice];
}

- (void)initLbl {
    self.statusLbl.text = @"Searching";
    self.valueLbl.text = @"Value: 0";
}

- (void)initBlePlugin {
    // init centeral plugin
    self.plugin = [QNPlugin sharedPlugin];
    NSString *file = [[NSBundle mainBundle] pathForResource:QNAppId ofType:@"qn"];
    [self.plugin initSdk:QNAppId filePath:file callback:^(int code) {
        
    }];
    
    // init specified device plugin
    [QNRulerPlugin setRulerPlugin:self.plugin];
    
    // set device delegate
    [QNRulerPlugin setDataListener:self];
    [QNRulerPlugin setDeviceListener:self];
}

#pragma mark - QNRulerDeviceListener
- (void)onDiscoverRulerDevice:(QNRulerDevice *)device {
    
    if (self.isConnected == YES) return;
    self.statusLbl.text = @"Scanning";
    self.statusLbl.text = @"Connecting";
    self.connectDevice = device;
    int code = [QNRulerPlugin connectDevice:device];
    NSLog(@"%d",code);
}

- (void)onRulerConnectedSuccess:(QNRulerDevice *)device {
    self.isConnected = YES;
    self.statusLbl.text = @"Connect Success";
}

- (void)onRulerConnectFail:(int)code device:(QNRulerDevice *)device {
    self.isConnected = NO;
    self.statusLbl.text = @"Connect Fail";
}

- (void)onRulerReadyInteract:(QNRulerDevice *)device {
    
}

- (void)onRulerDisconnected:(QNRulerDevice *)device {
    self.statusLbl.text = @"Ruler Disconnected";
    self.isConnected = NO;
    [self initLbl];
}

#pragma mark - QNRulerDataListener
- (void)onRulerRealTimeData:(QNRulerData *)data device:(QNRulerDevice *)device {
    NSString *unit = data.unit == QNRulerUnitInch ? @"inch" : @"cm";
    self.valueLbl.text = [NSString stringWithFormat:@"Result Value: %@ %@", data.value,unit];
}

- (void)onRulerReceiveMeasureResult:(QNRulerData *)data device:(QNRulerDevice *)device {
    NSString *unit = data.unit == QNRulerUnitInch ? @"inch" : @"cm";
    self.valueLbl.text = [NSString stringWithFormat:@"Result Value: %@ %@", data.value,unit];
}

@end
