//
//  ScaleViewController.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "ScaleViewController.h"
#import "QNPlugin.h"
#import "QNUnitTool.h"
#import "UnitChooseViewController.h"

#define QNScaleLogCode @"QingniuScaleLog="

#define QNBLEStatusStr_Scaning @"Scanning"
#define QNBLEStatusStr_Connecting @"Connecting"
#define QNBLEStatusStr_Connected @"Connected"
#define QNBLEStatusStr_Measuring @"Measuring"
#define QNBLEStatusStr_MeasureDone @"MeasureDone"
#define QNBLEStatusStr_Disconnected @"Disconnected"
#define QNBLEStatusStr_ConnectedFailed @"ConnecteFailed"


@implementation QNMeasureReport

+ (instancetype)reportWithTitle:(NSString *)title value:(NSString *)value {
    if (title.length == 0) return nil;

    QNMeasureReport *data = [[self alloc] init];
    data.title = title;
    data.value = value;
    return data;
}

@end


@interface ScaleViewController ()<UITableViewDelegate, UITableViewDataSource, QNHeightWeightScaleDataListener, QNHeightWeightScaleDeviceListener, QNHeightWeightScaleStatusListener>

@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, assign) BOOL isConnect;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomHeight;

@property (nonatomic, strong) QNHeightWeightScaleDevice *connectedDevice;

@property (nonatomic, strong) NSMutableArray<QNMeasureReport *> *reportDatas;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBleUnit];
    [self initBlePlugin];
    [self showMeasureResult:@"--" unit:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadBleStatusLabel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.plugin startScanCallback:^(int code) {
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.isConnect = NO;
    [self.plugin stopScan];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUnit:) name:@"UnitChoose" object:nil];
    if (self.connectedDevice != nil) {
        [QNHeightWeightScalePlugin cancelConnectHeightWeightScaleDevice:self.connectedDevice];
    }
}

- (void)initBleUnit {
    self.weightUnit = QNWeightUnitKg;
    self.heightUnit = QNHeightUnitCm;
}

- (void)initBlePlugin {
    // init centeral plugin
    self.plugin = [QNPlugin sharedPlugin];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test123456789" ofType:@"qn"];
    [self.plugin initSdk:@"test123456789" filePath:file callback:^(int code) {
        
    }];
    
    // init specified device plugin
    [QNHeightWeightScalePlugin setScalePlugin:self.plugin callback:^(int code) {
        
    }];
    
    // set device delegate
    [QNHeightWeightScalePlugin setDataListener:self];
    [QNHeightWeightScalePlugin setDeviceListener:self];
    [QNHeightWeightScalePlugin setStatusListener:self];
    
}

- (void)loadBleStatusLabel {
    
    int bleStatus = [self.plugin getBluetoothEnable];
    
    NSString *bleStatusStr = @"Bluetooth Power on";
    
    switch (bleStatus) {
        case 1: bleStatusStr = @"Bluetooth Resetting";break;
        case 2: bleStatusStr = @"Bluetooth Unsupported";break;
        case 3: bleStatusStr = @"Bluetooth Unauthorized";break;
        case 4: bleStatusStr = @"Bluetooth Power Off";break;
        default: bleStatusStr = @"Bluetooth Power on";break;
    }
    
    self.statusLbl.text = bleStatusStr;
}

#pragma mark - notification
- (void)reloadUnit:(NSNotification *)noti {
    NSDictionary *data = [noti userInfo];
    
    NSInteger type = [data[@"type"] integerValue];
    NSInteger value = [data[@"value"] integerValue];
    
    if (type == 0) {
        self.weightUnit = (QNWeightUnit)value;
    } else {
        self.heightUnit = (QNHeightUnit)value;
    }    
}

#pragma mark - show measure result
- (void)showMeasureResult:(NSString *)value unit:(NSString *)unit {
    NSString *result = [NSString stringWithFormat:@"%@%@", value, unit];
    
    NSRange valueRange = [result rangeOfString:value];
    NSRange unitRange = [result rangeOfString:unit];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:result];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:valueRange];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:unitRange];
    
    self.weightLbl.attributedText = att;
}

#pragma mark - Log msg
- (void)qingniuScaleLog:(NSString *)message {
    NSLog(@"%@", [NSString stringWithFormat:@"%@", [QNScaleLogCode stringByAppendingString:message]]);
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reportDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    QNMeasureReport *data = self.reportDatas[indexPath.row];
    
    cell.textLabel.text = data.title;
    cell.detailTextLabel.text = data.value;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - HeightWeightScale DeviceListener
- (void)onDiscoverHeightWeightScaleDevice:(QNHeightWeightScaleDevice *)device {
    
    if (self.isConnect == YES) return;
    
    self.statusLbl.text = QNBLEStatusStr_Scaning;
    
    
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    
    QNHeightWeightScaleOperate *operate = [[QNHeightWeightScaleOperate alloc] init];
    operate.weightUnit = self.weightUnit;
    operate.heightUnit = self.heightUnit;
    
    [QNHeightWeightScalePlugin connectHeightWeightScaleDevice:device operate:operate callback:^(int code) {
        [self showMeasureResult:@"--" unit:@""];
        [self.reportDatas removeAllObjects];
        [self.tableView reloadData];
    }];
}

- (void)onSetHeightWeightScaleUnitResult:(int)code device:(QNHeightWeightScaleDevice *)device {
    
}

#pragma mark - HeightWeightScale StatusListener
- (void)onHeightWeightScaleConnectedSuccess:(QNHeightWeightScaleDevice *)device {
    self.isConnect = YES;
    self.connectedDevice = device;
    self.statusLbl.text = QNBLEStatusStr_Connected;
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", device.mac];
    [self qingniuScaleLog:[NSString stringWithFormat:@"device connected___%@___%@", device.bleName, device.mac]];
}

- (void)onHeightWeightScaleConnectFail:(int)code device:(QNHeightWeightScaleDevice *)device {
    self.connectedDevice = nil;
    self.isConnect = NO;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
    [self qingniuScaleLog:[NSString stringWithFormat:@"device connect fail%@___%@", device.bleName, device.mac]];
}

- (void)onHeightWeightScaleReadyInteractResult:(int)code device:(QNHeightWeightScaleDevice *)device {
    [self qingniuScaleLog:[NSString stringWithFormat:@"device ready interact%@___%@", device.bleName, device.mac]];
}

- (void)onHeightWeightScaleDisconnected:(QNHeightWeightScaleDevice *)device {
    self.connectedDevice = nil;
    self.isConnect = NO;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
    [self qingniuScaleLog:[NSString stringWithFormat:@"device disConnected___%@___%@", device.bleName, device.mac]];
}

#pragma mark - HeightWeightScale DataListener
- (void)onHeightWeightScaleRealTimeWeight:(NSString *)weight device:(QNHeightWeightScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Measuring;
    [self qingniuScaleLog:[NSString stringWithFormat:@"real-time weight___%@", weight]];
    [self showMeasureResult:[self adjustWeightValue:weight] unit:[self curWeightUnit]];
}

- (void)onHeightWeightScaleRealTimeHeight:(NSString *)height device:(QNHeightWeightScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Measuring;
    [self qingniuScaleLog:[NSString stringWithFormat:@"real-time height___%@", height]];
    [self showMeasureResult:[self adjustHeightValue:height] unit:[self curHeightUnit]];
}

- (void)onHeightWeightScaleReceiveMeasureResult:(QNHeightWeightScaleData *)scaleData device:(QNHeightWeightScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_MeasureDone;
    [self qingniuScaleLog:[NSString stringWithFormat:@"measure result___Weight=%@___height=%@", scaleData.weight, scaleData.height]];
    
    [self loadMeasureReportData:scaleData];
}

#pragma mark - unit

- (NSString *)curWeightUnit {
    NSString *unit = @"kg";
    switch (self.weightUnit) {
        case QNWeightUnitLb:unit = @"lb"; break;
        case QNWeightUnitSt:unit = @"st"; break;
        case QNWeightUnitJin:unit = @"jin"; break;
        case QNWeightUnitStLb:unit = @"st-lb"; break;
        default:break;
    }
    return unit;
}

- (NSString *)curHeightUnit {
    NSString *unit = @"cm";
    switch (self.heightUnit) {
        case QNHeightUnitFt:unit = @"ft"; break;
        default:break;
    }
    return unit;
}

- (NSString *)adjustWeightValue:(NSString *)weight {
    // the default weight unit of QNSDK is kg.
    
    if (self.weightUnit == QNWeightUnitJin) {
        weight = [NSString stringWithFormat:@"%.1f", [weight floatValue] * 2];
    } else if (self.weightUnit == QNWeightUnitSt) {
        weight = [NSString stringWithFormat:@"%.1f", [QNUnitTool stFromKg:[weight floatValue]]];
    } else if (self.weightUnit == QNWeightUnitLb) {
        weight = [NSString stringWithFormat:@"%.1f", [QNUnitTool lbFromKg:[weight floatValue]]];
    }
    return weight;
}

- (NSString *)adjustHeightValue:(NSString *)height {
    // the default height unit of QNSDK is cm.
    
    if (self.heightUnit == QNHeightUnitFt) {
        height = [QNUnitTool ftFromCm:[height floatValue]];
    }
    return height;
}


#pragma mark - load measure data
- (void)loadMeasureReportData:(QNHeightWeightScaleData *)scaleData {
    
    [self.reportDatas removeAllObjects];
    
    NSString *weightStr = [NSString stringWithFormat:@"%@%@", [self adjustWeightValue:scaleData.weight], [self curWeightUnit]];
    NSString *heightStr = [NSString stringWithFormat:@"%@%@", [self adjustHeightValue:scaleData.height], [self curHeightUnit]];
    
    QNMeasureReport *weight = [QNMeasureReport reportWithTitle:@"Weight" value:weightStr];
    QNMeasureReport *height = [QNMeasureReport reportWithTitle:@"Height" value:heightStr];

    [self.reportDatas addObjectsFromArray:@[weight, height]];
    
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (NSMutableArray *)reportDatas {
    if (!_reportDatas) {
        _reportDatas = [NSMutableArray array];
    }
    return _reportDatas;
}

#pragma mark - dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
