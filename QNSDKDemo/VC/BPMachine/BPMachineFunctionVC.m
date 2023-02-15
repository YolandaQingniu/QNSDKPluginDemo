//
//  BPMachineFunctionVC.m
//  QNSDKDemo
//
//  Created by sumeng on 2022/12/14.
//

#import "BPMachineFunctionVC.h"
#import "QNDBManager.h"

@interface BPMachineFunctionVC ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) FunctionModel *model;

@end

@implementation BPMachineFunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[QNDBManager sharedQNDBManager] functionModelWithDataId:@"123456"];
    if (_model == nil) _model = [FunctionModel defaultFunctionModel];
    self.dataSource = @[@[@"mmHg", @"kPa"],@[@"Mute", @"Lv1", @"Lv2", @"Lv3", @"Lv4", @"Lv5"],@[@"China", @"USA", @"Europe"],@[@"Chinese", @"English"]];
}

- (IBAction)clickSaveUnit:(id)sender {
    if (_model) {
        [[QNDBManager sharedQNDBManager] insertOrReplaceFunctionMode:_model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitChooseCell"];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (_model.unitType - 1 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (indexPath.section == 1) {
        if (_model.volumeType - 1 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if (indexPath.section == 2) {
        if (_model.standardType - 1 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        if (_model.languageType - 1 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Unit";
    }else if (section == 1) {
        return @"Volume";
    }else if (section == 2) {
        return @"Standard";
    }else {
        return @"Language";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        _model.unitType = (QNBPMachineUnit)indexPath.row + 1;
    }else if (indexPath.section == 1) {
        _model.volumeType = (QNBPMachineVolume)indexPath.row + 1;
    }else if (indexPath.section == 2) {
        _model.standardType = (QNBPMachineStandard)indexPath.row + 1;
    }else {
        _model.languageType = (QNBPMachineLanguage)indexPath.row + 1;
    }
    [self.tableView reloadData];
}
@end
