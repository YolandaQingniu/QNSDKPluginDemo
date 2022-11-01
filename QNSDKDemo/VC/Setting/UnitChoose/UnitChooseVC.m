//
//  UnitChooseVC.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "UnitChooseVC.h"

@interface UnitChooseVC ()

@property (nonatomic, strong) NSArray *unitDatas;
@property (nonatomic, assign) NSInteger curWeightUnitIdx;
@property (nonatomic, assign) NSInteger curHeightUnitIdx;

@end

@implementation UnitChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curWeightUnitIdx = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    self.curHeightUnitIdx = [[NSUserDefaults standardUserDefaults] integerForKey:@"HeightUnit"];
    self.unitDatas = @[@[@"KG", @"LB", @"Jin", @"ST-LB", @"ST"],@[@"Cm", @"Ft"]];
}

- (IBAction)clickSaveUnit:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:self.curWeightUnitIdx forKey:@"WeightUnit"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.curHeightUnitIdx forKey:@"HeightUnit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.unitDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.unitDatas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitChooseCell"];
    cell.textLabel.text = self.unitDatas[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (self.curWeightUnitIdx == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else {
        if (self.curHeightUnitIdx == indexPath.row) {
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
        return @"Weight Unit";
    }else {
        return @"Height Unit";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.curWeightUnitIdx = indexPath.row;
    }else {
        self.curHeightUnitIdx= indexPath.row;
    }
    [self.tableView reloadData];
}
@end
