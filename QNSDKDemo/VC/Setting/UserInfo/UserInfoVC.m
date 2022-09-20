//
//  UserInfoVC.m
//  SDKDemo
//
//  Created by qingniu on 2022/6/14.
//

#import "UserInfoVC.h"
#import "QNDBManager.h"

@interface UserInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *idLbl;
@property (weak, nonatomic) IBOutlet UILabel *genderLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *curUserTagLbl;
@end

@implementation UserInfoCell

- (void)setUserInfo:(QNUserInfo *)userInfo {
    _userInfo = userInfo;
    self.idLbl.text = [NSString stringWithFormat:@"UserID：%@", userInfo.userId];
    self.genderLbl.text = [NSString stringWithFormat:@"Gender：%@", userInfo.gender];
    self.ageLbl.text = [NSString stringWithFormat:@"age：%d", userInfo.age];
    if (_userInfo.selected) {
        self.curUserTagLbl.hidden = NO;
    } else {
        self.curUserTagLbl.hidden = YES;
    }
}
@end


@interface UserInfoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderChoose;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<QNUserInfo *> *userlist;
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadTableViewData];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)clickSaveUserInfo:(id)sender {
    [self.view endEditing:YES];
    if (self.ageTF.text.length == 0) return;
    QNUserInfo *user = [QNUserInfo defaultUser];
    user.age = [self.ageTF.text intValue];
    user.gender = self.genderChoose.selectedSegmentIndex ? @"male" : @"female";
    QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
    curUser.selected = NO;
    [[QNDBManager sharedQNDBManager] insertOrReplaceUser:curUser];
    [[QNDBManager sharedQNDBManager] insertOrReplaceUser:user];
    [self reloadTableViewData];
}

- (void)reloadTableViewData {
    self.userlist = [[QNDBManager sharedQNDBManager] getAllUserInfo].mutableCopy;
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
    cell.userInfo = self.userlist[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.2];
    } else {
        cell.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    QNUserInfo *user = self.userlist[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([[QNDBManager sharedQNDBManager] deleteUserWithUserId:user.userId]) {
            [self.tableView reloadData];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    QNUserInfo *user = self.userlist[indexPath.row];
    user.selected = YES;
    QNUserInfo *curUser = [[QNDBManager sharedQNDBManager] curUser];
    curUser.selected = NO;
    [[QNDBManager sharedQNDBManager] insertOrReplaceUser:curUser];
    [[QNDBManager sharedQNDBManager] insertOrReplaceUser:user];
    [self reloadTableViewData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end
