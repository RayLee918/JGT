//
//  SettingsViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "ChangePhoneViewController.h"
#import "LoginHistoryViewController.h"

@interface SettingsViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataSource1;
    NSMutableArray * _dataSource2;
    
    NSArray * _frequency;
    UIButton * _refreshBtn;
    
    // 缓存
    NSString * _cacheSizeStr;
}
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 得到缓存大小
    NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    _cacheSizeStr = [ClearCacheTool getCacheSizeWithFilePath:libraryPath];
    
    _dataSource1 = [NSMutableArray arrayWithArray:@[@"修改手机号", @"登录记录", @"清除缓存", @"资讯刷新频率"]];
    _dataSource2 = [NSMutableArray arrayWithArray:@[@"", @"", _cacheSizeStr, @"5分钟"]];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"设置";
}

- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight);
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _refreshBtn.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kBatteryHeight - kNavgationBarHeight - kTabbarHeight);
    [self.view addSubview:_refreshBtn];
    _refreshBtn.backgroundColor = [UIColor blackColor];
    _refreshBtn.alpha = 0.1;
    _refreshBtn.hidden = YES;
    [_refreshBtn addTarget:self action:@selector(norefreshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [UIView new];
    view.frame = CGRectMake(0, (kScreentHeight - 44 * 5 - 64) / 2, kScreentWidth, 44 * 5);
    [_refreshBtn addSubview:view];
    
    _frequency = @[@"60", @"300", @"600", @"1800", @"3600"];
//    _frequency = @[@"5", @"10", @"20", @"30", @"40"];
    
    for (int i = 0; i < 5; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*44, kScreentWidth, 44);
        [view addSubview:btn];
        [btn setTitle:[NSString stringWithFormat:@"%ld分钟", [_frequency[i] integerValue] / 60] forState:UIControlStateNormal];
        btn.titleLabel.textColor = kBlueColor;
        [btn addTarget:self action:@selector(refreshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 60 + i;
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"settings";
    SettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _dataSource1[indexPath.row];
    cell.contentLabel.text = _dataSource2[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"settings - didSelect - %ld", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ChangePhoneViewController * changePhoneVC = [ChangePhoneViewController new];
        [self.navigationController pushViewController:changePhoneVC animated:YES];
    } else if (indexPath.row == 1) {
        LoginHistoryViewController * loginHistoryVC = [LoginHistoryViewController new];
        loginHistoryVC.userId = self.userInfo[kUserID];
        [self.navigationController pushViewController:loginHistoryVC animated:YES];
    } else if (indexPath.row == 2) {
        NSLog(@"清除缓存");
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];

        [ClearCacheTool clearCacheWithFilePath:libraryPath];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"清除成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        _dataSource2[indexPath.row] = @"0.00M";
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    } else {
        NSLog(@"更改刷新频率");
        _refreshBtn.hidden = NO;
    }
}

- (void)norefreshBtnClick:(UIButton *)sender {
    _refreshBtn.hidden = YES;
}
- (void)refreshBtnClick:(UIButton *)sender {
    
    NSInteger count = sender.tag - 60;
    _dataSource2[3] = [NSString stringWithFormat:@"%ld分钟", [_frequency[count] integerValue] / 60];
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [[NSUserDefaults standardUserDefaults] setValue:_frequency[count] forKey:@"refreshRate"];
    NSLog(@"pinlv - %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"refreshRate"]);
    
    _refreshBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
