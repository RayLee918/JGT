//
//  TeamViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "TeamViewController.h"
#import "FollowCell.h"
#import "ChatViewController.h"
#import "AppDelegate.h"

@interface TeamViewController () <UITableViewDelegate, UITableViewDataSource, NIMLoginManagerDelegate>
{
    NSArray * _teamDataSource;
    UITableView * _teamTableView;
}
@end

@implementation TeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _teamDataSource = [NSArray new];
    
    // 初始视图
    [self initView];
    
    // 启动云信
    [self setupIM];
    
    // 获取该页显示的数据
    [self getTeamData];
}

#pragma mark - 启动云信
- (void)setupIM {
    // ------------------- 启动云信 -------------------
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    NSString *appKey        = @"a1f4e45f28b38f1b9fc8ceb23cbc82d7";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"apsKaifa";
    option.pkCername        = nil;
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    // ------------------- 自动登录登录 -------------------
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    NSString * account = userInfo[kIMAccId];
    NSString * token = userInfo[kIMToken];
//    NSString * account = @"18233989613tDIG";
//    NSString * token = @"6JQtJHDo8cdml06GOor9jaLfJhsiHBnhGsbmk7zB0bKptIOmQ2QlQjpcgl6p2H8LQlOHdLEosdee8Eym02jeH9mIgiHrfLcrEEKCEt1cCdmCjvdA5gsekAEEFOClis4I";
    
    // 自动登录
    NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
    loginData.account = account;
    loginData.token = token;
    loginData.forcedMode = YES;
    [[NIMSDK sharedSDK].loginManager autoLogin:loginData];
}

#pragma mark - 登录成功回调
- (void)onLogin:(NIMLoginStep)step {
    NSLog(@"success - login - %ld", step);
}

#pragma mark - 登录失败回调
- (void)onAutoLoginFailed:(NSError *)error {
    NSDictionary * dic = error.userInfo;
    NSLog(@"failed - login - %@", dic[NSLocalizedDescriptionKey]);
}

- (void)getTeamData {
    // ------------------- 获取所有群组 -------------------
    NSArray * myTeams = [[NIMSDK sharedSDK].teamManager allMyTeams];
    _teamDataSource = myTeams;
    for (NIMTeam * team in myTeams) {
        NSLog(@"获取群组 - %@, %@", team.teamName, team.teamId);
    }
}

- (void)initView {
    
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight);
    UITableView * tablView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tablView];
    tablView.delegate = self;
    tablView.dataSource = self;
    _teamTableView = tablView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _teamDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifer = @"team cell";
    FollowCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[FollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    // 配置cell
    NIMTeam * team = _teamDataSource[indexPath.row];
    [cell.icon setImageWithURL:[NSURL URLWithString:team.avatarUrl] placeholderImage:kImageNamed(@"default_head.png")];
    
    cell.nickNameLbl.text = team.teamName;
    
//    cell.nickNameLbl.text = @"股票讨论组";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChatViewController * chatVC = [ChatViewController new];
    chatVC.team = _teamDataSource[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 基本设置
    [CLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[UIColor whiteColor] title:@"我的讨论组"];
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tabbarView.hidden = NO;

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
