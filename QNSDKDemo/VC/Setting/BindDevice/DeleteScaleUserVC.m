//
//  DeleteScaleUserVC.m
//  QNSDKDemo
//
//  Created by qushaohua on 2022/10/27.
//

#import "DeleteScaleUserVC.h"
#import "HeightWeightScaleVC.h"
#import "AlertTool.h"
#import "QNDBManager.h"

@implementation DeleteScaleUserModel

@end


@interface DeleteScaleUserCell ()
@property (weak, nonatomic) IBOutlet UILabel *txtLbl;
@end


@implementation DeleteScaleUserCell

- (void)setModel:(DeleteScaleUserModel *)model {
    self.txtLbl.text = model.text;
    self.txtLbl.backgroundColor = model.isSelected? [UIColor.greenColor colorWithAlphaComponent:0.3] : [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
}

@end



@interface DeleteScaleUserVC ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, QNScaleDataListener, QNScaleDeviceListener, QNScaleStatusListener, QNScaleUserEventListener, QNLogListener, QNSysBleStatusListener, QNScanListener>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (nonatomic, strong) NSMutableArray<DeleteScaleUserModel *> *indexList;
@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (nonatomic, strong) QNPlugin *plugin;
@property (nonatomic, strong) QNScaleDevice *connectedDevice;

@end

@implementation DeleteScaleUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", _mac];
    self.statusLbl.text = @"Delete Scale User";
    self.viewHeight.constant = (UIScreen.mainScreen.bounds.size.width - 100)/2;
    [self initBlePlugin];
    [self getIndexListData];
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
}

- (void)getIndexListData {
    
    if (self.indexList.count > 0) [self.indexList removeAllObjects];
    
    for (int i = 1; i <= 8; i++) {
        DeleteScaleUserModel *model = [[DeleteScaleUserModel alloc] init];
        model.text = [NSString stringWithFormat:@"%d", i];
        model.isSelected = NO;
        [self.indexList addObject:model];
    }
    
    [self.collectionView reloadData];
}

- (IBAction)clickDeleteScaleUser:(id)sender {
    [self.plugin startScan];
    self.statusLbl.text = QNBLEStatusStr_Scaning;
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

#pragma mark - QNScaleDeviceListener
- (void)onDiscoverScaleDevice:(QNScaleDevice *)device {
    if (_connectedDevice || ![device.mac isEqualToString:_mac]) return;
        
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
    _connectedDevice = nil;
    self.statusLbl.text = QNBLEStatusStr_ConnectedFailed;
}

- (void)onReadyInteractResult:(int)code device:(QNScaleDevice *)device {
    if (code != 0) return;
    
    self.statusLbl.text = @"Ready To Delete Scale User";
    _connectedDevice = device;
    
    if (self.switchBtn.on) {
        [QNUserScaleMp deleteUserList:[self getNeedDeleteAllScaleUserList] device:device];
    } else {
        [QNUserScaleMp deleteUserList:[self getNeedDeleteScaleUserList] device:device];
    }
}

- (NSArray <NSNumber *> *)getNeedDeleteScaleUserList {
    NSMutableArray *result = [NSMutableArray array];
    
    for (DeleteScaleUserModel *item in self.indexList) {
        if (item.isSelected) {
            [result addObject:[NSNumber numberWithInteger:item.text.integerValue]];
        }
    }
    return result.copy;
}

- (NSArray <NSNumber *> *)getNeedDeleteAllScaleUserList {
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i = 1; i <= 8; i++) {
        [result addObject:@(i)];
    }
    return result.copy;
}

- (void)onDisconnected:(QNScaleDevice *)device {
    _connectedDevice = nil;
    self.statusLbl.text = QNBLEStatusStr_Disconnected;
}

#pragma mark - QNScaleUserEventListener
- (void)onRegisterUserResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device {
}

- (void)onSyncUserInfoResult:(int)code user:(QNScaleUser *)user device:(QNScaleDevice *)device {
    
}

- (void)onDeleteUsersResult:(int)code device:(QNScaleDevice *)device {
    if (code == 0) {
        self.statusLbl.text = @"Delete Scale User Success";
        QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
        [[QNDBManager sharedQNDBManager] deleteScaleUserWithUserId:curUser.userId mac:device.mac];
    } else {
        self.statusLbl.text = @"Delete Scale User Failed";
    }
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.indexList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DeleteScaleUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeleteScaleUserCell" forIndexPath:indexPath];
    cell.model = self.indexList[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 100;
    return CGSizeMake(width / 4, width / 4);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.switchBtn.on) {
        [AlertTool showAlertMsg:@"You have chosen to delete all users, you do not need to select a specific location to delete users"];
        return;
    }
    
    DeleteScaleUserModel *model = self.indexList[indexPath.item];
    model.isSelected = !model.isSelected;
    [self.indexList replaceObjectAtIndex:indexPath.item withObject:model];
    
    [self.collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark -
- (NSMutableArray<DeleteScaleUserModel *> *)indexList {
    if (!_indexList) {
        _indexList = [NSMutableArray array];
    }
    return _indexList;
}

@end
