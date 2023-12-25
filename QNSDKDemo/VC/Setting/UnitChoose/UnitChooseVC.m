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

@end

@implementation UnitChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curWeightUnitIdx = [[NSUserDefaults standardUserDefaults] integerForKey:@"WeightUnit"];
    self.unitDatas = @[@"KG", @"LB", @"Jin", @"ST-LB", @"ST"];
}

- (IBAction)clickSaveUnit:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:self.curWeightUnitIdx forKey:@"WeightUnit"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitChooseCell"];
    cell.textLabel.text = self.unitDatas[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.curWeightUnitIdx == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
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
    return @"Weight Unit";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.curWeightUnitIdx = indexPath.row;
    [self.tableView reloadData];
}
@end
