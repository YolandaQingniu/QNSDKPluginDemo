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
@property (weak, nonatomic) IBOutlet UILabel *curUserTagLbl;
@end

@implementation UserInfoCell

- (void)setUserInfo:(QNUserInfo *)userInfo {
    _userInfo = userInfo;
    self.idLbl.text = [NSString stringWithFormat:@"UserID:%@,\t Gender:%@, \nAge:%d,\t Height:%d", userInfo.userId, userInfo.gender, userInfo.age, userInfo.height];
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
@property (weak, nonatomic) IBOutlet UITextField *heightTF;

@property (nonatomic, strong) NSMutableArray<QNUserInfo *> *userlist;
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    QNUserInfo *curUser = [QNUserInfo currentUser];
    NSLog(@"curUser.gender=%@", curUser.gender);
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)clickSaveUserInfo:(id)sender {
    if (self.ageTF.text.length == 0 || self.heightTF.text.length == 0) return;
    
    [self.view endEditing:YES];
    
    QNUserInfo *newUser = [[QNUserInfo alloc] init];
    newUser.userId = [NSString stringWithFormat:@"%ld",(long)[NSDate date].timeIntervalSince1970];
    newUser.age = [self.ageTF.text intValue];
    newUser.gender = self.genderChoose.selectedSegmentIndex ? @"male" : @"female";
    newUser.selected = NO;
    newUser.height = [self.heightTF.text intValue];
    [[QNDBManager sharedQNDBManager] insertOrReplaceUser:newUser];
    
    [self refreshData];
    
    self.ageTF.text = self.heightTF.text = @"";
}

- (void)refreshData {
    [self.userlist removeAllObjects];
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
            [self refreshData];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete User";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    QNUserInfo *user = self.userlist[indexPath.row];
    if (user.selected) return;
    
    QNUserInfo *curUser = [QNUserInfo currentUser];
    curUser.selected = NO;
    [[QNDBManager sharedQNDBManager] updateUserInfo:curUser];
    
    user.selected = YES;
    [[QNDBManager sharedQNDBManager] updateUserInfo:user];
    
    [self refreshData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (NSMutableArray<QNUserInfo *> *)userlist {
    if (!_userlist) {
        _userlist = [NSMutableArray array];
    }
    return _userlist;
}
@end
