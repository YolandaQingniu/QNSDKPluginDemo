//
//  BPMachineVC.m
//  QNSDKDemo
//
//  Created by sumeng on 2022/12/13.
//

#import "BPMachineVC.h"
#import "BindDeviceModel.h"
#import "QNDBManager.h"

#define QNBLEStatusStr_Scaning @"Scanning"
#define QNBLEStatusStr_Connecting @"Connecting"
#define QNBLEStatusStr_Connected @"Connected"
#define QNBLEStatusStr_Measuring @"Measuring"
#define QNBLEStatusStr_MeasureDone @"MeasureDone"
#define QNBLEStatusStr_Disconnected @"Disconnected"
#define QNBLEStatusStr_ConnectedFailed @"ConnecteFailed"

@interface BPMachineDataCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeStampLable;
@property (weak, nonatomic) IBOutlet UILabel *userIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *systolicBPLabel;
@property (weak, nonatomic) IBOutlet UILabel *diastolicBPLabel;
@property (weak, nonatomic) IBOutlet UILabel *heartRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTypeLabel;


@end

@implementation BPMachineDataCell

- (void)setData:(QNBPMachineData *)data {
    _data = data;
    self.timeStampLable.text = data.timeStamp;
    self.userIndexLabel.text = [NSString stringWithFormat:@"%d",data.userIndex];
    self.unitLabel.text = data.unit == QNBPMachineUnitKPA ? @"KPA" : @"MMGH";
    self.systolicBPLabel.text = data.systolicBP;
    self.diastolicBPLabel.text = data.diastolicBP;
    self.heartRateLabel.text = data.heartRate;
    self.resultTypeLabel.text = @"";


    switch (data.resultType) {
        case QNBPMachineResultTypeNormal_CHN: self.resultTypeLabel.text = @"Normal_CHN";
            break;
        case QNBPMachineResultTypeNormalHighValue_CHN: self.resultTypeLabel.text = @"NormalHighValue_CHN";
            break;
        case QNBPMachineResultTypeFirstHighPressure_CHN: self.resultTypeLabel.text = @"FirstHighPressure_CHN";
            break;
        case QNBPMachineResultTypeSecondHighPressure_CHN: self.resultTypeLabel.text = @"SecondHighPressure_CHN";
            break;
        case QNBPMachineResultTypeThirdHighPressure_CHN: self.resultTypeLabel.text = @"ThirdHighPressure_CHN";
            break;
            
        case QNBPMachineResultTypeNormal_USA: self.resultTypeLabel.text = @"USA_Normal";
            break;
        case QNBPMachineResultTypeNormalHighValue_USA: self.resultTypeLabel.text = @"NormalHighValue_USA";
            break;
        case QNBPMachineResultTypeFirstHighPressure_USA: self.resultTypeLabel.text = @"FirstHighPressure_USA";
            break;
        case QNBPMachineResultTypeSecondHighPressure_USA: self.resultTypeLabel.text = @"SecondHighPressure_USA";
            break;
            
        case QNBPMachineResultTypeOptimalBloodPressure_EU: self.resultTypeLabel.text = @"OptimalBloodPressure_EU";
            break;
        case QNBPMachineResultTypeNormal_EU: self.resultTypeLabel.text = @"Normal_EU";
            break;
        case QNBPMachineResultTypeNormalHighValue_EU: self.resultTypeLabel.text = @"NormalHighValue_EU";
            break;
        case QNBPMachineResultTypeFirstHighPressure_EU: self.resultTypeLabel.text = @"FirstHighPressure_EU";
            break;
        case QNBPMachineResultTypeSecondHighPressure_EU: self.resultTypeLabel.text = @"SecondHighPressure_EU";
            break;
        case QNBPMachineResultTypeThirdHighPressure_EU: self.resultTypeLabel.text = @"ThirdHighPressure_EU";
            break;
            
        case QNBPMachineResultTypeNormal_JPN: self.resultTypeLabel.text = @"Normal_JPN";
            break;
        case QNBPMachineResultTypeNormalHighValue_JPN: self.resultTypeLabel.text = @"NormalHighValue_JPN";
            break;
        case QNBPMachineResultTypeHighBloodPressure_JPN: self.resultTypeLabel.text = @"HighBloodPressure_JPN";
            break;
        case QNBPMachineResultTypeFirstHighPressure_JPN: self.resultTypeLabel.text = @"FirstHighPressure_JPN";
            break;
        case QNBPMachineResultTypeSecondHighPressure_JPN: self.resultTypeLabel.text = @"SecondHighPressure_JPN";
            break;
        case QNBPMachineResultTypeThirdHighPressure_JPN: self.resultTypeLabel.text = @"ThirdHighPressure_JPN";
            break;
        default:
            break;
    }
}
@end

@interface BPMachineVC ()<UITableViewDelegate, UITableViewDataSource, QNSysBleStatusListener,QNLogListener, QNBPMachineDeviceListener, QNBPMachineDataListener>
@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, assign) BOOL isConnect;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UILabel *appIdLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) QNBPMachineDevice *connectedDevice;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BPMachineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appIdLbl.text = [NSString stringWithFormat:@"AppId: %@",QNAppId];
    [self initBlePlugin];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    QNSysBleStatus code = [[QNPlugin sharedPlugin] getSysBleStatus];
    [self onSysBleStatus:code];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.isConnect = NO;
    [self.plugin stopScan];
    if (self.connectedDevice != nil) {
        [QNBPMachinePlugin cancelConnectDevice:self.connectedDevice];
    }
}

- (void)initBlePlugin {
    // init centeral plugin
    self.plugin = [QNPlugin sharedPlugin];
    NSString *file = [[NSBundle mainBundle] pathForResource:QNAppId ofType:@"qn"];
    [self.plugin initSdk:QNAppId filePath:file callback:^(int code) {
        
    }];
    self.plugin.sysBleStatusListener = self;
    self.plugin.logListener = self;
    
    // init specified device plugin
    int code = [QNBPMachinePlugin setBPMachinePlugin:self.plugin];
    NSLog(@"init specified device plugin code = %d",code);
    
    // set device delegate
    [QNBPMachinePlugin setDataListener:self];
    [QNBPMachinePlugin setDeviceListener:self];
}

#pragma mark -
#pragma mark - QNPluginDelegare
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
            NSLog(@"start Scan code = %d",tempCode);
        }break;
        default: bleStatusStr = @"Bluetooth Unknown";break;
    }
    self.statusLbl.text = bleStatusStr;
}

- (void)onLog:(NSString *)log {
    NSLog(@"%@", log);
}

#pragma mark -
#pragma mark - QNBPMachineDeviceListener
- (void)onDiscoverDevice:(QNBPMachineDevice *)device {
    if (_connectedDevice) return;
    _connectedDevice = device;
    self.statusLbl.text = QNBLEStatusStr_Scaning;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    int flag = [QNBPMachinePlugin connectDevice:device];
    if (flag == 0) {
        // save a new device
        BindDeviceModel *bindDevice = [BindDeviceModel bindDeviceWithBPMachineDevice:device];
        [[QNDBManager sharedQNDBManager] insertOrReplaceBindDevice:bindDevice];
    }
    [self.tableView reloadData];
}
- (void)onConnectedSuccess:(QNBPMachineDevice *)device {
    self.isConnect = YES;
    self.connectedDevice = device;
    self.statusLbl.text = QNBLEStatusStr_Connected;
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", device.mac];
}
- (void)onConnectFail:(int)code device:(QNBPMachineDevice *)device {
    self.connectedDevice = nil;
    self.isConnect = NO;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}
- (void)onDisconnected:(QNBPMachineDevice *)device {
    self.connectedDevice = nil;
    self.isConnect = NO;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}
- (void)onReadyInteractResult:(int)code device:(QNBPMachineDevice *)device {
    if (code != 0) return;
    [AlertTool showAlertMsg:[NSString stringWithFormat:@"Storage count: %d",[device getCurrentStorageCount]]];
    _connectedDevice = device;
    FunctionModel *model = [[QNDBManager sharedQNDBManager] functionModelWithDataId:@"123456"];
    QNBPMachineDeploy *deploy = nil;
    if (model) {
        deploy = [[QNBPMachineDeploy alloc] init];
        deploy.unit = model.unitType;
        deploy.volume =  model.volumeType;
        deploy.standard =  model.standardType;
        deploy.language =  model.languageType;
    }
   
    [QNBPMachinePlugin setDeviceFunction:device deploy:deploy];
    [QNBPMachinePlugin readStoredData:device];
}
- (void)onSetBPMachineFunctionResult:(int)code device:(QNBPMachineDevice *)device {
    
}

- (void)onSetReadStoredDataResult:(int)code device:(QNBPMachineDevice *)device {
    
}

- (void)onSetFunctionResult:(int)code device:(nonnull QNBPMachineDevice *)device {
    
}


#pragma mark -
#pragma mark - QNBPMachineDeviceListener
- (void)onBPMachineReceiveRealTimeData:(QNBPMachineMeasureResult)measureResult data:(nullable QNBPMachineData *)data device:(QNBPMachineDevice *)device {
    if (measureResult == QNBPMachineMeasureResultSuccess) {
        [self.dataSource addObject:data];
        [self.tableView reloadData];
    }else {
        NSString *message = @"";
        switch (measureResult) {
            case QNBPMachineMeasureResultUndone: message = @"Measurement not completed";
                break;
            case QNBPMachineMeasureResultErr1: message = @"Device not calibrated";
                break;
            case QNBPMachineMeasureResultErr2: message = @"Cuff comes off or Excessive movement";
                break;
            case QNBPMachineMeasureResultErr3: message = @"High voltage detection failed";
                break;
            case QNBPMachineMeasureResultErr4: message = @"Low voltage detection failed";
                break;
            case QNBPMachineMeasureResultErr5: message = @"Blood pressure pulses not detected";
                break;
            case QNBPMachineMeasureResultErr6: message = @"Measurement timeout";
                break;
            case QNBPMachineMeasureResultErr7: message = @"Over pressurization";
                break;
            case QNBPMachineMeasureResultErr8: message = @"Air leaks during pressurization";
                break;
            case QNBPMachineMeasureResultErr9: message = @"Missing cuff";
                break;
            default:
                break;
        }
        [AlertTool showAlertMsg:[NSString stringWithFormat:@"Measurement failed: %@",message]];
    }
}
- (void)onBPMachineReceiveStoredData:(QNBPMachineData *)data device:(QNBPMachineDevice *)device {
    [self.dataSource addObject:data];
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMachineDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BPMachineDataCell"];
    cell.data = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - lazy load
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
