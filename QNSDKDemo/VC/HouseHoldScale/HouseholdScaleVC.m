//
//  HouseholdScaleVC.m
//  QNSDKDemo
//
//  Created by qingniu on 2022/10/21.
//

#import "HouseholdScaleVC.h"
#import <QNPluginLibrary/QNPluginLibrary.h>
#import "QNScalePluginLibrary/QNScalePluginLibrary.h"
#import "QNUserInfo.h"
#import "QNDBManager.h"

@interface HouseholdScaleVC ()<UITableViewDelegate, UITableViewDataSource, QNScaleDataListener, QNScaleDeviceListener, QNScaleStatusListener, QNScaleUserEventListener, QNLogListener, QNSysBleStatusListener, QNScanListener>
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *valueLbl;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UILabel *appidLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) QNPlugin *plugin;

@property (nonatomic, strong) QNScaleDevice *connectedDevice;

@property (nonatomic, strong) NSMutableArray<QNMeasureReport *> *reportDatas;

@end

@implementation HouseholdScaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appidLbl.text = [NSString stringWithFormat:@"AppId: %@",QNAppId];
    
    [self showMeasureResult:@"--" unit:@""];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initBlePlugin];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.plugin stopScan];
    
    if (_connectedDevice) {
        [QNScalePlugin cancelConnectDevice:_connectedDevice];
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
    [QNScalePlugin setScalePlugin:self.plugin];
    
    // set device delegate
    [QNScalePlugin setDataListener:self];
    [QNScalePlugin setStatusListener:self];
    [QNScalePlugin setDeviceListener:self];
    [QNUserScaleMp setUserScaleEventListener:self];
    
    [self.plugin startScan];
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

- (void)onScanResult:(int)code {
    
}

- (void)onStopScan {
    
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

#pragma mark - QNScaleDeviceListener
- (void)onDiscoverScaleDevice:(QNScaleDevice *)device {
    if (_connectedDevice) return;
    
    self.statusLbl.text = QNBLEStatusStr_Scaning;
    self.statusLbl.text = QNBLEStatusStr_Connecting;
    
    QNScaleOperate *operate = [[QNScaleOperate alloc] init];
    operate.unit = [self unitFromSetting];
    int flag = [QNScalePlugin connectDevice:device operate:operate];
    
    if (flag == 0) {
        // save a new device
        BindDeviceModel *bindDevice = [BindDeviceModel bindDeviceWithQNScale:device];
        [[QNDBManager sharedQNDBManager] insertOrReplaceBindDevice:bindDevice];
    }
    
    [self showMeasureResult:@"--" unit:@""];
    [self.reportDatas removeAllObjects];
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
}

- (void)onConnectFail:(int)code device:(QNScaleDevice *)device {
    _connectedDevice = nil;
    self.macLbl.text = @"";
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onReadyInteractResult:(int)code device:(QNScaleDevice *)device {
    if (code != 0) return;
    
    _connectedDevice = device;
    
    [QNScalePlugin setScaleDeviceUnit:device unit:[self unitFromSetting]];
    
    QNUserInfo *curUser = [QNUserInfo currentUser];
    
    if (device.getSupportScaleUser) {
        
        ScaleUser *scaleUser = [[QNDBManager sharedQNDBManager] scaleUserWithUserId:curUser.userId mac:device.mac];
        
        QNScaleUser *user = [[QNScaleUser alloc] init];
        user.key = 1000;
        user.visitorMode = NO;
        user.height = curUser.height;
        user.age = curUser.age;
        user.userId = curUser.userId;
        user.gender = curUser.gender;
        
        if (scaleUser && scaleUser.secretIndex > 0) {
            user.index = scaleUser.secretIndex;
            user.key = scaleUser.secretKey;
        }
        
        [QNUserScaleMp setMeasureUserToUserDevice:user device:device];
    } else {
        QNUser *user = [[QNUser alloc] init];
        user.userId = curUser.userId;
        user.gender = curUser.gender;
        user.age = curUser.age;
        user.height = curUser.height;
        [QNScalePlugin setMeasureUser:device user:user];
    }
}

- (void)onDisconnected:(QNScaleDevice *)device {
    _connectedDevice = nil;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}

#pragma mark - QNScaleDataListener
- (void)onRealTimeWeight:(NSString *)weight device:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_Measuring;
    [self showMeasureResult:weight unit:[self curWeightUnit]];
}

- (void)onReceiveMeasureResult:(QNScaleData *)scaleData device:(QNScaleDevice *)device {
    self.statusLbl.text = QNBLEStatusStr_MeasureDone;
    [self loadMeasureReportData:scaleData];
    
    
    NSString *aesData = [QNAESCrypt AES128Decrypt:scaleData.hmac];
    NSDictionary *dic = [self jsonTodictionary:aesData];
        
    NSString *resistance_50 = dic[@"resistance_50"];
    NSString *resistance_500 = dic[@"resistance_500"];
    NSString *origin_resistances = dic[@"origin_resistances"];
    
    
    NSString *res20_left_arm = dic[@"res20_left_arm"];
    NSString *res20_right_arm = dic[@"res20_right_arm"];
    NSString *res20_left_leg = dic[@"res20_left_leg"];
    NSString *res20_right_leg = dic[@"res20_right_leg"];
    NSString *res20_trunk = dic[@"res20_trunk"];
    
    NSString *res100_left_arm = dic[@"res100_left_arm"];
    NSString *res100_right_arm = dic[@"res100_right_arm"];
    NSString *res100_left_leg = dic[@"res100_left_leg"];
    NSString *res100_right_leg = dic[@"res100_right_leg"];
    NSString *res100_trunk = dic[@"res100_trunk"];
    
    NSString *info = @"";
    if (resistance_50.length > 0) info = [NSString stringWithFormat:@"%@\n 50K: %@", info, resistance_50];
    if (resistance_500.length > 0) info = [NSString stringWithFormat:@"%@\n 500K: %@", info, resistance_500];
    if (origin_resistances.length > 0) info = [NSString stringWithFormat:@"%@\n 原始: %@", info, origin_resistances];

    if (res20_left_arm.length > 0) info = [NSString stringWithFormat:@"%@\n res20_left_arm: %@", info, res20_left_arm];
    if (res20_right_arm.length > 0) info = [NSString stringWithFormat:@"%@\n res20_right_arm: %@", info, res20_right_arm];
    if (res20_left_leg.length > 0) info = [NSString stringWithFormat:@"%@\n res20_left_leg: %@", info, res20_left_leg];
    if (res20_right_leg.length > 0) info = [NSString stringWithFormat:@"%@\n res20_right_leg: %@", info, res20_right_leg];
    if (res20_trunk.length > 0) info = [NSString stringWithFormat:@"%@\n res20_trunk: %@", info, res20_trunk];
    
    if (res100_left_arm.length > 0) info = [NSString stringWithFormat:@"%@\n res100_left_arm: %@", info, res100_left_arm];
    if (res100_right_arm.length > 0) info = [NSString stringWithFormat:@"%@\n res100_right_arm: %@", info, res100_right_arm];
    if (res100_left_leg.length > 0) info = [NSString stringWithFormat:@"%@\n res100_left_leg: %@", info, res100_left_leg];
    if (res100_right_leg.length > 0) info = [NSString stringWithFormat:@"%@\n res100_right_leg: %@", info, res100_right_leg];
    if (res100_trunk.length > 0) info = [NSString stringWithFormat:@"%@\n res100_trunk: %@", info, res100_trunk];
    
    [AlertTool showAlertMsg:info];
}

- (void)onReceiveStoredData:(NSArray<QNScaleData *> *)scaleData device:(QNScaleDevice *)device {
    
}

- (NSString *)onGetLastDataHmac:(QNScaleUser *)user device:(QNScaleDevice *)device {
    return @"";
}

#pragma mark - QNScaleUserEventListener
- (void)onRegisterUserResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device {
    
    ScaleUser *scaleUser = [[QNDBManager sharedQNDBManager] scaleUserWithUserId:user.userId mac:device.mac];
    
    if (scaleUser == nil) {
        // save a new scaleUser
        ScaleUser *newScaleUser = [[ScaleUser alloc] init];
        newScaleUser.scaleUserId = user.userId;
        newScaleUser.secretIndex = user.index;
        newScaleUser.secretKey = user.key;
        newScaleUser.mac = device.mac;
        [[QNDBManager sharedQNDBManager] insertOrReplaceScaleUser:newScaleUser] ;
    } else {
        // update a scaleUser's index and key
        scaleUser.secretIndex = user.index;
        scaleUser.secretKey = user.key;
        [[QNDBManager sharedQNDBManager] updateScaleUserInfo:scaleUser mac:device.mac];
    }
}

- (void)onSyncUserInfoResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device {
    
}

- (void)onDeleteUsersResult:(int)code device:(QNScaleDevice *)device {
    
}

#pragma mark -

- (NSDictionary *)jsonTodictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) {
        return nil;
    }
    return dic;
}

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
    [self addDataIndexDisplay:@"BMI" value:scaleData.BMI];
    [self addDataIndexDisplay:@"Body fat rate" value:scaleData.bodyFatRate];
    [self addDataIndexDisplay:@"Subcutaneous fat rate" value:scaleData.subcutaneousFatRate];
    [self addDataIndexDisplay:@"Visceral fat level" value:scaleData.visceralFatLevel];
    [self addDataIndexDisplay:@"Body water rate" value:scaleData.bodyWaterRate];
    [self addDataIndexDisplay:@"Skeletal muscle rate" value:scaleData.skeletalMuscleRate];
    [self addWeightDataIndexDisplay:@"Bone mass" value:scaleData.boneMass];
    [self addDataIndexDisplay:@"BMR" value:scaleData.BMR];
    [self addDataIndexDisplay:@"Body type" value:scaleData.bodyType];
    [self addDataIndexDisplay:@"Protein rate" value:scaleData.proteinRate];
    [self addWeightDataIndexDisplay:@"Lean body mass" value:scaleData.leanBodyMass];
    [self addWeightDataIndexDisplay:@"Muscle mass" value:scaleData.muscleMass];
    [self addDataIndexDisplay:@"Body age" value:scaleData.bodyAge];
    [self addDataIndexDisplay:@"Health score" value:scaleData.healthScore];
    [self addDataIndexDisplay:@"Heart Rate" value:scaleData.heartRate];
    [self addDataIndexDisplay:@"Heart Index" value:scaleData.heartIndex];
    [self addDataIndexDisplay:@"Fatty liver risk level" value:scaleData.fattyLiverRiskLevel];
    [self addDataIndexDisplay:@"Resistance 50KHZ" value:scaleData.res50KHZ];
    [self addDataIndexDisplay:@"Resistance 500KHZ" value:scaleData.res500KHZ];
    [self addWeightDataIndexDisplay:@"Body fat mass" value:scaleData.bodyFatMass];
    [self addDataIndexDisplay:@"Obesity" value:scaleData.obesity];
    [self addWeightDataIndexDisplay:@"Body Water mass" value:scaleData.bodyWaterMass];
    [self addWeightDataIndexDisplay:@"Protein mass" value:scaleData.proteinMass];
    [self addDataIndexDisplay:@"Mineral level" value:scaleData.mineralLevel];
    [self addWeightDataIndexDisplay:@"Dream weight str" value:scaleData.dreamWeight];
    [self addWeightDataIndexDisplay:@"Stand weight" value:scaleData.standWeight];
    [self addWeightDataIndexDisplay:@"Weight control" value:scaleData.weightControl];
    [self addWeightDataIndexDisplay:@"Body fat control" value:scaleData.bodyFatControl];
    [self addWeightDataIndexDisplay:@"Muscle mass control" value:scaleData.muscleMassControl];
    [self addDataIndexDisplay:@"Muscle rate" value:scaleData.muscleRate];
    
    // Eight-electrode data
    [self addDataIndexDisplay:@"leftArmBodyfatRate" value:scaleData.leftArmBodyfatRate];
    [self addDataIndexDisplay:@"leftLegBodyfatRate" value:scaleData.leftLegBodyfatRate];
    [self addDataIndexDisplay:@"rightArmBodyfatRate" value:scaleData.rightArmBodyfatRate];
    [self addDataIndexDisplay:@"rightLegBodyfatRate" value:scaleData.rightLegBodyfatRate];
    [self addDataIndexDisplay:@"trunkBodyfatRate" value:scaleData.trunkBodyfatRate];
    
    [self addDataIndexDisplay:@"leftArmFatMass" value:scaleData.leftArmFatMass];
    [self addDataIndexDisplay:@"leftLegFatMass" value:scaleData.leftLegFatMass];
    [self addDataIndexDisplay:@"rightArmFatMass" value:scaleData.rightArmFatMass];
    [self addDataIndexDisplay:@"rightLegFatMass" value:scaleData.rightLegFatMass];
    [self addDataIndexDisplay:@"trunkFatMass" value:scaleData.trunkFatMass];
    
    [self addDataIndexDisplay:@"leftArmMuscleMass" value:scaleData.leftArmMuscleMass];
    [self addDataIndexDisplay:@"leftLegMuscleMass" value:scaleData.leftLegMuscleMass];
    [self addDataIndexDisplay:@"rightArmMuscleMass" value:scaleData.rightArmMuscleMass];
    [self addDataIndexDisplay:@"rightLegMuscleMass" value:scaleData.rightLegMuscleMass];
    [self addDataIndexDisplay:@"trunkMuscleMass" value:scaleData.trunkMuscleMass];
    
    [self addDataIndexDisplay:@"skeletalMuscleMass" value:scaleData.skeletalMuscleMass];
    [self addDataIndexDisplay:@"mineralSaltRate" value:scaleData.mineralSaltRate];
    
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
