//
//  WiFiPairVC.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/24.
//

#import "WiFiPairVC.h"
#import "HeightWeightScaleVC.h"
#import "QNUserInfo.h"


@interface WiFiPairVC ()<QNScaleWiFiListener, QNScaleStatusListener, QNLogListener, QNSysBleStatusListener, QNScanListener, QNScaleDeviceListener, QNBPMachineDeviceListener, QNBPMachineWiFiListener>
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UITextField *accountLbl;
@property (weak, nonatomic) IBOutlet UITextField *pwdLbl;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;

@property (nonatomic, strong) QNPlugin *plugin;
@property (nonatomic, strong) QNScaleDevice *connectedScale;
@property (nonatomic, strong) QNBPMachineDevice *connectedBPMachine;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WiFiPairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBlePlugin];
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", _mac];
    self.progressLbl.text = [NSString stringWithFormat:@"0%%"];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.plugin stopScan];
    
    if (_connectedScale) {
        [QNScalePlugin cancelConnectDevice:_connectedScale];
    }
    
    if (_connectedBPMachine) {
        [QNBPMachinePlugin cancelConnectDevice:_connectedBPMachine];
    }
}

- (void)initBlePlugin {
    // init centeral plugin
    self.plugin = [QNPlugin sharedPlugin];
    NSString *file = [[NSBundle mainBundle] pathForResource:QNAppId ofType:@"qn"];
    [self.plugin initSdk:QNAppId filePath:file callback:^(int code) {
        
    }];
    self.plugin.scanListener = self;
    self.plugin.logListener = self;
    self.plugin.sysBleStatusListener = self;
    
    // init scale plugin
    [self initScalePlugin];
    // init bp machine plugin
    [self initBPMachinePlugin];
}

- (void)initScalePlugin {
    // init specified device plugin
    int code = [QNScalePlugin setScalePlugin:self.plugin];
    NSLog(@"init specified device plugin code = %d",code);
    // set device delegate
    [QNScalePlugin setStatusListener:self];
    [QNScalePlugin setDeviceListener:self];
    [QNScaleWiFiMp setWiFiStatusListener:self];
}


- (void)initBPMachinePlugin {
    // init bp machine plugin
    int code = [QNBPMachinePlugin setBPMachinePlugin:self.plugin];
    NSLog(@"init bp machine plugin code = %d",code);
    // set device delegate
    [QNBPMachinePlugin setDeviceListener:self];
    [QNBPMachineWiFiMp setWiFiStatusListener:self];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)clickPairNetwork:(id)sender {
    [self.view endEditing:YES];
    
    if (_accountLbl.text.length == 0 || _pwdLbl.text.length == 0) {
        self.statusLbl.text = @"Please Input WiFi Name Or Password";
        return;
    }

    [self.plugin startScan];
    self.statusLbl.text = QNBLEStatusStr_Scaning;
}

#pragma mark -
#pragma mark - QNPluginDelegare
- (void)onLog:(nonnull NSString *)log {
    NSLog(@"HouseholdScaleLog=%@", log);
}

- (void)onSysBleStatus:(QNSysBleStatus)code {
    NSString *bleStatusStr = @"Bluetooth Unknown";
    switch (code) {
        case 1: bleStatusStr = @"Bluetooth Resetting";break;
        case 2: bleStatusStr = @"Bluetooth Unsupported";break;
        case 3: bleStatusStr = @"Bluetooth Unauthorized";break;
        case 4: bleStatusStr = @"Bluetooth Power Off";break;
        case 5: {
            bleStatusStr = @"Bluetooth Power on";
            int tempCode = [self.plugin startScan];
            NSLog(@"HouseholdScaleLog start Scan code = %d",tempCode);
        }break;
        default: bleStatusStr = @"Bluetooth Unknown";break;
    }
    self.statusLbl.text = bleStatusStr;
}

- (void)onScanResult:(int)code {
    
}

- (void)onStopScan {
    
}

#pragma mark - timer
- (void)startTimer {
    __block CGFloat number = 0.0;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        weakSelf.progressView.progress = number;
        weakSelf.progressLbl.text = [NSString stringWithFormat:@"%.0f%%", number*100];
        number = number + 0.01;
        
        if (number >= 0.9) {
            weakSelf.progressView.progress = 0.9;
            weakSelf.progressLbl.text = [NSString stringWithFormat:@"90%%"];
            [weakSelf stopTimer];
        }
    }];
    [self.timer fire];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -
#pragma mark - QNScaleDeviceListener
- (void)onDiscoverScaleDevice:(QNScaleDevice *)device {
    if (_connectedScale || ![device.mac isEqualToString:_mac]) return;
    _connectedScale = device;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    QNScaleOperate *operate = [[QNScaleOperate alloc] init];
    operate.unit = [self unitFromSetting];
    [QNScalePlugin connectDevice:device operate:operate];
}

- (QNUnit)unitFromSetting {
    NSInteger unit = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    
    QNUnit result = QNUnitKg;
    switch (unit) {
        case 1: result = QNUnitLb;break;
        case 2: result = QNUnitJin;break;
        case 3: result = QNUnitSt;break;
        case 4: result = QNUnitStLb;break;
        default:break;
    }
    return result;
}

- (void)onSetUnitResult:(int)code device:(QNScaleDevice *)device {
    
}

#pragma mark - QNScaleStatusListener
- (void)onConnectedSuccess:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Connected;
}

- (void)onConnectFail:(int)code device:(QNScaleDevice *)device {
    _connectedScale = nil;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onReadyInteractResult:(int)code device:(QNScaleDevice *)device {
    if (code != 0) return;
    
    self.statusLbl.text = @"Ready To Pair Network";
    _connectedScale = device;
    
    [self startTimer];
        
    QNWiFiInfo *config = [[QNWiFiInfo alloc] init];
    config.ssid = self.accountLbl.text;
    config.pwd = self.pwdLbl.text;
    config.serverUrl = @"http://wsp-lite.yolanda.hk/yolanda/wsp?code=";
    [QNScaleWiFiMp startConnectWiFi:config device:_connectedScale];
}

- (void)onDisconnected:(QNScaleDevice *)device {
    _connectedScale = nil;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}

#pragma mark - QNScaleWiFiListener
- (void)onStartWiFiConnect:(QNScaleDevice *)device {
    self.statusLbl.text = @"Start Pair Network";
}

- (void)onConnectWiFiStatus:(int)code device:(QNScaleDevice *)device {
    [self stopTimer];
    
    if (code == 0) {
        self.progressView.progress = 1;
        self.progressLbl.text = [NSString stringWithFormat:@"100%%"];
        self.statusLbl.text = @"Pairing Network Success";
    } else {
        self.progressView.progress = 0;
        self.progressLbl.text = [NSString stringWithFormat:@"0%%"];
        self.statusLbl.text = @"Pairing Network Failed";
    }
}

#pragma mark -
#pragma mark - QNBPMachineDeviceListener
- (void)onDiscoverBPMachineDevice:(QNBPMachineDevice *)device {
    if (_connectedBPMachine || ![device.mac isEqualToString:_mac]) return;
    _connectedBPMachine = device;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    [QNBPMachinePlugin connectDevice:device];
}

- (void)onBPMachineConnectedSuccess:(QNBPMachineDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Connected;
}

- (void)onBPMachineConnectFail:(int)code device:(QNBPMachineDevice *)device {
    _connectedBPMachine = nil;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onBPMachineReadyInteractResult:(int)code device:(QNBPMachineDevice *)device {
    if (code != 0) return;
    self.statusLbl.text = @"Ready To Pair Network";
    _connectedBPMachine = device;
    [self startTimer];
    QNBPMachineWiFi *config = [[QNBPMachineWiFi alloc] init];
    config.ssid = self.accountLbl.text;
    config.pwd = self.pwdLbl.text;
    config.serverUrl = @"http://wsp-lite.yolanda.hk/yolanda/wsp?code=";
    [QNBPMachineWiFiMp startConnectWiFi:config device:device];
}

- (void)onBPMachineDisconnected:(QNBPMachineDevice *)device {
    _connectedBPMachine = nil;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}

#pragma mark - QNBPMachineWiFiListener
- (void)onBPMachineStartWiFiConnect:(QNBPMachineDevice *)device {
    self.statusLbl.text = @"Start Pair Network";
}
- (void)onBPMachineConnectWiFiStatus:(int)code device:(QNBPMachineDevice *)device {
    [self stopTimer];
    
    if (code == 0) {
        self.progressView.progress = 1;
        self.progressLbl.text = [NSString stringWithFormat:@"100%%"];
        self.statusLbl.text = @"Pairing Network Success";
    } else {
        self.progressView.progress = 0;
        self.progressLbl.text = [NSString stringWithFormat:@"0%%"];
        self.statusLbl.text = @"Pairing Network Failed";
    }
}
@end
