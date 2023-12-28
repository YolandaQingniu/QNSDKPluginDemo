//
//  HouseholdScaleVC.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/21.
//

#import "HouseholdScaleVC.h"
#import <QNPluginLibrary/QNPluginLibrary.h>
#import "QNScalePluginLibrary/QNScalePluginLibrary.h"
#import "QNMeasureReport.h"


@interface HouseholdScaleVC ()<UITableViewDelegate, UITableViewDataSource, QNScaleDataListener, QNScaleDeviceListener, QNScaleStatusListener, QNLogListener, QNSysBleStatusListener, QNScanListener>
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, strong) QNScaleDevice *connectedDevice;

@property (nonatomic, strong) NSMutableArray<QNMeasureReport *> *reportDatas;

/// 存储数据
@property (nonatomic, strong) NSMutableArray<QNScaleData *> *dataArr;

@end

@implementation HouseholdScaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self showMeasureResult:@"--" unit:@""];
    
    // init centeral plugin
    self.plugin = [QNPlugin sharedPlugin];
    [self.plugin initSdkWithCallback:^(int code) {
        
    }];
    
    // init specified device plugin
    [QNScalePlugin setScalePlugin:self.plugin];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.plugin.scanListener = self;
    self.plugin.logListener = self;
    self.plugin.sysBleStatusListener = self;
    
    // set device delegate
    [QNScalePlugin setDataListener:self];
    [QNScalePlugin setStatusListener:self];
    [QNScalePlugin setDeviceListener:self];

    [self.plugin startScan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
        
    [QNScalePlugin cancelConnectDevice:_connectedDevice];
    [self.plugin stopScan];
    
    _connectedDevice = nil;
    self.plugin.scanListener = nil;
    self.plugin.logListener = nil;
    self.plugin.sysBleStatusListener = nil;
    
    // set device delegate
    [QNScalePlugin setDataListener:nil];
    [QNScalePlugin setStatusListener:nil];
    [QNScalePlugin setDeviceListener:nil];
}

- (void)showMeasureResult:(NSString *)value unit:(NSString *)unit {
    NSString *tmp = [self adjustWeightValue:value];
    
    NSString *result = [NSString stringWithFormat:@"%@%@", tmp, unit];
    
    NSRange valueRange = [result rangeOfString:value];
    NSRange unitRange = [result rangeOfString:unit];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:result];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:valueRange];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:unitRange];
    
    self.valueLbl.attributedText = att;
}

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

#pragma mark - QNScanListener
- (void)onStopScan {
    
}

- (void)onStartScan {
    
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = UIColor.lightGrayColor;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = section == 0 ? @"当前测量数据：" : @"存储数据：";
    titleLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    [headerView addSubview:titleLabel];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.reportDatas.count : self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        QNMeasureReport *data = self.reportDatas[indexPath.row];
        cell.textLabel.text = data.title;
        cell.detailTextLabel.text = data.value;
    } else {
        QNScaleData *data = self.dataArr[indexPath.row];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStr = [df stringFromDate:[NSDate dateWithTimeIntervalSince1970:[data.timeStamp longLongValue]]];
        cell.textLabel.text = [NSString stringWithFormat:@"存储数据<%ld> %@", indexPath.row + 1, dateStr];
        
        NSString *weightStr = [NSString stringWithFormat:@"%@%@", [self adjustWeightValue:data.weight], [self curWeightUnit]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@、%@/%@", weightStr, data.resistance50, data.resistance500];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - QNScaleDeviceListener
- (void)onDiscoverScaleDevice:(QNScaleDevice *)device {
    if (_connectedDevice) return;
    
    self.statusLbl.text = QNBLEStatusStr_Scaning;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    
    QNScaleOperate *operate = [[QNScaleOperate alloc] init];
    operate.unit = [self unitFromSetting];
    [QNScalePlugin connectDevice:device operate:operate];
        
    [self showMeasureResult:@"--" unit:@""];
    [self.reportDatas removeAllObjects];
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];
}

- (void)onSetUnitResult:(int)code device:(QNScaleDevice *)device {
    NSLog(@"HouseholdScaleLog= Set Unit Result %d", code);
}

#pragma mark - QNScaleStatusListener
- (void)onConnectedSuccess:(QNScaleDevice *)device {
    _connectedDevice = device;
    self.statusLbl.text = QNBLEStatusStr_Connected;
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", device.mac];
    [self.plugin stopScan];
}

- (void)onConnectFail:(int)code device:(QNScaleDevice *)device {
    _connectedDevice = nil;
    self.macLbl.text = @"";
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onReadyInteractResult:(int)code device:(QNScaleDevice *)device {
    if (code != 0) return;
    self.statusLbl.text = QNBLEStatusStr_Interactive;
    [QNScalePlugin setScaleDeviceUnit:device unit:[self unitFromSetting]];
}

- (void)onDisconnected:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
    _connectedDevice = nil;
}

#pragma mark - QNScaleDataListener
- (void)onRealTimeWeight:(NSString *)weight device:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Measuring;
    [self showMeasureResult:weight unit:[self curWeightUnit]];
}

- (void)onReceiveMeasureResult:(QNScaleData *)scaleData device:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_MeasureDone;
    [self loadMeasureReportData:scaleData];
}

- (void)onReceiveStoredData:(NSArray<QNScaleData *> *)scaleData device:(QNScaleDevice *)device {
    self.dataArr = [scaleData mutableCopy];
    [self.tableView reloadData];
}

#pragma mark -
- (NSString *)curWeightUnit {
    NSInteger unit = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    
    NSString *result = @"kg";
    switch (unit) {
        case 1: result = @"lb";break;
        case 2: result = @"jin";break;
        case 3: result = @"st:lb";break;
        case 4: result = @"st";break;
        default:break;
    }
    return result;
}

- (QNUnit)unitFromSetting {
    NSInteger unit = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    
    QNUnit result = QNUnitKg;
    switch (unit) {
        case 1: result = QNUnitLb;break;
        case 2: result = QNUnitJin;break;
        case 3: result = QNUnitStLb;break;
        case 4: result = QNUnitSt;break;
        default:break;
    }
    return result;
}

- (NSString *)adjustWeightValue:(NSString *)weight {
    NSInteger unitInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"] + 1;
    QNUnit unit = (QNUnit)unitInteger;
    
    if (unit == QNUnitJin) {
        return [QNScalePlugin getWeightJin:weight];
    } else if (unit == QNUnitSt) {
        return [QNScalePlugin getWeightSt:weight];
    } else if (unit == QNUnitLb) {
        return [QNScalePlugin getWeightLb:weight];
    } else if (unit == QNUnitStLb) {
        NSArray *stlb = [QNScalePlugin getWeightStLb:weight];
        return [NSString stringWithFormat:@"%@ : %@", stlb.firstObject, stlb.lastObject];
    }
    return weight;
}

- (void)loadMeasureReportData:(QNScaleData *)scaleData {
    
    [self.reportDatas removeAllObjects];
    
    [self addWeightDataIndexDisplay:@"Weight" value:scaleData.weight];
    [self addDataIndexDisplay:@"Resistance 50KHZ" value:scaleData.resistance50];
    [self addDataIndexDisplay:@"Resistance 500KHZ" value:scaleData.resistance500];
    [self.tableView reloadData];
}

- (void)addWeightDataIndexDisplay:(NSString *)title value:(NSString *)value {
    if (value == nil || value.length <= 0) return;
    NSString *valueStr = [NSString stringWithFormat:@"%@%@", [self adjustWeightValue:value], [self curWeightUnit]];
    [self addDataIndexDisplay:title value:valueStr];
}

- (void)addDataIndexDisplay:(NSString *)title value:(NSString *)value {
    if (value == nil || value.length <= 0) return;
    QNMeasureReport *report = [QNMeasureReport reportWithTitle:title value:value];
    [self.reportDatas addObject:report];
}

#pragma mark - lazy load
- (NSMutableArray *)reportDatas {
    if (!_reportDatas) {
        _reportDatas = [NSMutableArray array];
    }
    return _reportDatas;
}

@end
