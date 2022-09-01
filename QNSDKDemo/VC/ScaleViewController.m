//
//  ScaleViewController.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "ScaleViewController.h"
#import <QNPluginLibrary/QNPluginLibrary.h>
#import "QNUnitTool.h"
#import "UnitChooseViewController.h"

#define QNAppId @"test123456789"

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


@interface ScaleViewController ()<UITableViewDelegate, UITableViewDataSource, QNHeightWeightScaleDataListener, QNHeightWeightScaleDeviceListener,QNLogListener,QNSysBleStatusListener,QNScanListener>

@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, assign) BOOL isConnect;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;
@property (weak, nonatomic) IBOutlet UILabel *appIdLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomHeight;

@property (nonatomic, strong) QNHeightWeightScaleDevice *connectedDevice;

@property (nonatomic, strong) NSMutableArray<QNMeasureReport *> *reportDatas;

@end

@implementation ScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appIdLbl.text = [NSString stringWithFormat:@"AppId: %@",QNAppId];
    
    [self initBlePlugin];
    [self showMeasureResult:@"--" unit:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initBleUnit];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    int code = [[QNPlugin sharedPlugin] getSysBleStatus];
    [self onSysBleStatus:code];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.isConnect = NO;
    [self.plugin stopScan];
    if (self.connectedDevice != nil) {
        [QNHeightWeightScalePlugin cancelConnectHeightWeightScaleDevice:self.connectedDevice];
    }
}

- (void)initBleUnit {
    self.weightUnit = (QNWeightUnit)[[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    self.heightUnit = (QNHeightUnit)[[NSUserDefaults standardUserDefaults] integerForKey:@"HeightUnit"];
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
    int code = [QNHeightWeightScalePlugin setScalePlugin:self.plugin];
    NSLog(@"init specified device plugin code = %d",code);
    
    // set device delegate
    [QNHeightWeightScalePlugin setDataListener:self];
    [QNHeightWeightScalePlugin setDeviceListener:self];
}

#pragma mark - QNPluginDelegare
- (void)onLog:(nonnull NSString *)log {
    [self qingniuScaleLog:log];
}

- (void)onSysBleStatus:(int)code {
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

- (void)onScanResult:(int)code {
    
}

- (void)onStopScan {
    
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
    NSLog(@"%@", message);
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
    int code = [QNHeightWeightScalePlugin connectHeightWeightScaleDevice:device operate:operate];
    NSLog(@"connect device code = %d",code);
    
    [self showMeasureResult:@"--" unit:@""];
    [self.reportDatas removeAllObjects];
    [self.tableView reloadData];
  
}

- (void)onSetHeightWeightScaleUnitResult:(int)code device:(QNHeightWeightScaleDevice *)device {
    
}

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

- (void)onHeightWeightScaleReadyInteractResult:(QNHeightWeightScaleDevice *)device {
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
        return [QNHeightWeightScalePlugin getWeightJin:weight];
    } else if (self.weightUnit == QNWeightUnitSt) {
        return [QNHeightWeightScalePlugin getWeightSt:weight];
    } else if (self.weightUnit == QNWeightUnitLb) {
        return [QNHeightWeightScalePlugin getWeightLb:weight];
    }
    return weight;
}

- (NSString *)adjustHeightValue:(NSString *)height {
    // the default height unit of QNSDK is cm.
    
    if (self.heightUnit == QNHeightUnitFt) {
        NSArray *ary = [QNHeightWeightScalePlugin getHeightFtIn:height];
        return [NSString stringWithFormat:@"%@'%@''", ary[0], ary[1]];
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
    QNMeasureReport *bmi = [QNMeasureReport reportWithTitle:@"BMI" value:scaleData.bmi];

    [self.reportDatas addObjectsFromArray:@[weight, height, bmi]];
    
    [self.tableView reloadData];
}

#pragma mark - lazy load
- (NSMutableArray *)reportDatas {
    if (!_reportDatas) {
        _reportDatas = [NSMutableArray array];
    }
    return _reportDatas;
}
@end
