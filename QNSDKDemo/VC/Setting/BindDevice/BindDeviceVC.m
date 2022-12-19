//
//  BindDeviceVC.m
//  QNSDKDemo
//
//  Created by qushaohua on 2022/10/27.
//

#import "BindDeviceVC.h"
#import "WiFiPairVC.h"
#import "DeleteScaleUserVC.h"
#import "AlertTool.h"

@interface BindDeviceCell ()

@property (weak, nonatomic) IBOutlet UILabel *macLbl;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UIButton *wifiBtn;
@property (weak, nonatomic) IBOutlet UIButton *unBindBtn;

@end

@implementation BindDeviceCell

- (void)setBindDevice:(BindDeviceModel *)bindDevice {
    _bindDevice = bindDevice;
    self.macLbl.text = [NSString stringWithFormat:@"MAC: %@", bindDevice.mac];
    self.userBtn.hidden = !bindDevice.supportScaleUserFlag;
    self.wifiBtn.hidden = !bindDevice.supportWiFiFlag;
}

- (IBAction)clickUnbindDevice:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickUnbindDevice:)]) {
        [self.delegate didClickUnbindDevice:_bindDevice];
    }
}

- (IBAction)clickDeleteScale:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDeleteScaleUser:)]) {
        [self.delegate didClickDeleteScaleUser:_bindDevice];
    }
}

- (IBAction)clickPairWiFi:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickPairWiFiDevice:)]) {
        [self.delegate didClickPairWiFiDevice:_bindDevice];
    }
}

@end


@interface BindDeviceVC ()<BindDeviceDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BindDeviceModel *> *bindDeviceList;
@property (nonatomic, strong) BindDeviceModel *selectedModel;
@end

@implementation BindDeviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)refreshData {
    [self.bindDeviceList removeAllObjects];
    
    QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
    self.bindDeviceList = [[QNDBManager sharedQNDBManager] getAllBindDeviceWithUserId:curUser.userId].mutableCopy;
    [self.tableView reloadData];
}


#pragma mark - click
- (void)didClickUnbindDevice:(BindDeviceModel *)device {
    [AlertTool showAlertMsg:@"Are you sure you want to delete the binded device?" cancelHandle:nil sureHandle:^{
        QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
        [[QNDBManager sharedQNDBManager] deleteDeviceWithUserId:curUser.userId mac:device.mac];
        
        [[QNDBManager sharedQNDBManager] deleteScaleUserWithUserId:curUser.userId mac:device.mac];
        
        [self refreshData];
    }];
}

- (void)didClickDeleteScaleUser:(BindDeviceModel *)device {
    _selectedModel = device;
}

- (void)didClickPairWiFiDevice:(BindDeviceModel *)device {
    _selectedModel = device;
}

#pragma mark -
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"WiFiPairVC"]) {
        WiFiPairVC *vc = [segue destinationViewController];
        vc.mac = _selectedModel.mac;
    }
    
    if ([[segue identifier] isEqualToString:@"DeleteScaleUserVC"]) {
        DeleteScaleUserVC *vc = [segue destinationViewController];
        vc.mac = _selectedModel.mac;
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bindDeviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BindDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BindDeviceCell"];
    cell.delegate = self;
    cell.bindDevice = self.bindDeviceList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.2];
    } else {
        cell.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.4];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSMutableArray<BindDeviceModel *> *)bindDeviceList {
    if (!_bindDeviceList) {
        _bindDeviceList = [NSMutableArray array];
    }
    return _bindDeviceList;
}

@end
