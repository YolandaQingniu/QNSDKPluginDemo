//
//  SettingTableViewController.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "SettingTableViewController.h"
#import "UnitChooseViewController.h"

@interface SettingTableViewController ()
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.datas = [NSMutableArray arrayWithArray:@[@"Set Weight Unit", @"Set Height Unit"]];
    
    [self.tableView reloadData];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLbl = [cell viewWithTag:101];
    titleLbl.text = [NSString stringWithFormat:@"%@", self.datas[indexPath.row]];
    return cell;
}

#pragma mark - click
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UnitChooseViewController *dstVC = segue.destinationViewController;
    
    NSString *title = (NSString *)sender;
    
    NSInteger idx = [self.datas indexOfObject:title];
    
    if (idx >= self.datas.count || idx < 0) return;

    if (idx == 0) {
        dstVC.unitType = QNUnitTypeWeight;
    } else {
        dstVC.unitType = QNUnitTypeHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SetUnit" sender:self.datas[indexPath.row]];
}

#pragma mark - lazy load
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
