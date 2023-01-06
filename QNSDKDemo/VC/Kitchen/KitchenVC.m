//
//  KitchenVC.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/12/2.
//

#import "KitchenVC.h"
#import <QNPluginLibrary/QNPluginLibrary.h>
#import <QNKitchenScalePluginLibrary/QNKitchenScalePluginLibrary.h>
#import "HeightWeightScaleVC.h"

@interface KitchenVC ()<QNKitchenScaleDataListener, QNKitchenScaleDeviceListener, QNScanListener, QNLogListener, QNSysBleStatusListener>
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSwitch;
@property (weak, nonatomic) IBOutlet UILabel *overLoadedLbl;
@property (weak, nonatomic) IBOutlet UILabel *shellingLbl;
@property (weak, nonatomic) IBOutlet UILabel *stableLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (weak, nonatomic) IBOutlet UIButton *shellingBtn;

@property (nonatomic, strong) QNPlugin *plugin;
@property (nonatomic, strong) QNKitchenScaleDevice *connectedDevice;

@end

@implementation KitchenVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initBlePlugin];
    self.overLoadedLbl.hidden = self.shellingLbl.hidden = self.stableLbl.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.plugin startScan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.plugin stopScan];
    
    if (_connectedDevice) {
        [QNKitchenScalePlugin cancelConnectKitchenScaleDevice:_connectedDevice];
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
    
    // init specified device plugin
    [QNKitchenScalePlugin setScalePlugin:self.plugin];
    
    // set device delegate
    [QNKitchenScalePlugin setDataListener:self];
    [QNKitchenScalePlugin setDeviceListener:self];
}

- (IBAction)clickSwitchUnit:(UISegmentedControl *)sender {
    if (_connectedDevice == nil) return;
    
    QNUnit unit = [self getKitchenUnitFromSelect:sender.selectedSegmentIndex];
    [QNKitchenScalePlugin setDeviceUnit:unit device:_connectedDevice];
}

- (IBAction)clickShelling:(id)sender {
    if (_connectedDevice == nil) {
        [AlertTool showAlertMsg:@"Kitchen Device Disconnected"];
        return;
    }
    
    if ([_connectedDevice getDeviceSupportShelling]) {
        [QNKitchenScalePlugin setDeviceShelling:_connectedDevice];
    } else {
        [AlertTool showAlertMsg:@"Kitchen Device Does't Support Shelling"];
    }
}

- (QNUnit)getKitchenUnitFromSelect:(NSInteger)index {
    if (index == 0) return QNUnitG;
    if (index == 1) return QNUnitML;
    if (index == 2) return QNUnitMilkML;
    if (index == 3) return QNUnitLBOZ;
    if (index == 4) return QNUnitOZ;
    return QNUnitG;
}


#pragma mark - QNPluginDelegare
- (void)onLog:(nonnull NSString *)log {
    
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
            [self.plugin startScan];
        }break;
        default: bleStatusStr = @"Bluetooth Unknown";break;
    }
    self.statusLbl.text = bleStatusStr;
}

- (void)onScanResult:(int)code {
    
}

- (void)onStopScan {
    
}

#pragma mark - QNKitchenScaleDeviceListener
- (void)onDiscoverKitchenScaleDevice:(QNKitchenScaleDevice *)device {
    if (_connectedDevice) return;
    
    self.statusLbl.text = QNBLEStatusStr_Scaning;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    
    QNKitchenScaleOperate *operate = [[QNKitchenScaleOperate alloc] init];
    operate.unit = QNUnitG;
    [QNKitchenScalePlugin connectKitchenScaleDevice:device operate:operate];
}

- (void)onKitchenScaleConnectedSuccess:(QNKitchenScaleDevice *)device {
    _connectedDevice = device;
    self.statusLbl.text = QNBLEStatusStr_Connected;
}

- (void)onKitchenScaleConnectFail:(int)code device:(QNKitchenScaleDevice *)device {
    _connectedDevice = nil;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onKitchenScaleReadyInteract:(int)code device:(QNKitchenScaleDevice *)device {
    if (code != 0) return;
    
    QNUnit unit = [self getKitchenUnitFromSelect:self.unitSwitch.selectedSegmentIndex];
    [QNKitchenScalePlugin setDeviceUnit:unit device:_connectedDevice];
}

- (void)onKitchenScaleDisconnected:(QNKitchenScaleDevice *)device {
    _connectedDevice = nil;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}

- (void)onSetKitchenScaleUnitResult:(int)code device:(QNKitchenScaleDevice *)device {
    
}

- (void)onSetKitchenScaleShellingResult:(int)code device:(QNKitchenScaleDevice *)device {
    
}

- (void)onSetKitchenScaleStandTimeResult:(int)code device:(QNKitchenScaleDevice *)device {
    
}

#pragma mark - QNKitchenScaleDataListener
- (void)onKitchenScaleRealTimeData:(QNKitchenScaleData *)scaleData device:(QNKitchenScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Measuring;
    self.valueLbl.text = [QNKitchenScalePlugin getWeightWithUnit:scaleData.unit weight:scaleData.weight numberType:QNKitchenScaleNumberTypeInteger];
    
    self.overLoadedLbl.hidden = !scaleData.isOverWeightFlag;
    self.shellingLbl.hidden = !scaleData.isShellingFlag;
    self.stableLbl.hidden = !scaleData.isStableFlag;
}

@end
