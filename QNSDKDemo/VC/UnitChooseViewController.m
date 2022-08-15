//
//  UnitChooseViewController.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "UnitChooseViewController.h"

@interface UnitChooseViewController ()

@property (nonatomic, strong) NSArray *unitDatas;

@property (nonatomic, assign) NSInteger curIdx;

@end

@implementation UnitChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.unitType == QNUnitTypeWeight) {
        self.unitDatas = @[@"KG", @"LB", @"Jin", @"ST"];
    } else if (self.unitType == QNUnitTypeHeight) {
        self.unitDatas = @[@"Cm", @"Ft"];
    }
 
}

- (IBAction)clickSaveUnit:(id)sender {
    NSDictionary *data = @{
        @"type":@(self.unitType),
        @"value":@(self.curIdx),
    };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UnitChoose" object:nil userInfo:data];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.unitDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitChooseCell"];
    cell.textLabel.text = self.unitDatas[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.curIdx == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.curIdx = indexPath.row;
    NSLog(@"select unit___%@", self.unitDatas[self.curIdx]);
    [self.tableView reloadData];
}

@end
