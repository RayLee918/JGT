//
//  AccountViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "AccountViewController.h"
#import "RecommendFriendViewController.h"
#import "VersionViewController.h"
#import "MsgViewController.h"
#import "BillViewController.h"
#import "CardViewController.h"
#import "CourseViewController.h"
#import "SettingsViewController.h"
#import "PersonViewController.h"
#import "SubscribeViewController.h"
#import "ChangePasswordViewController.h"
#import "RegisterViewController.h"
#import "WithDrawViewController.h"
#import "TeamViewController.h"

@interface AccountViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    NSArray * _dataSource;
    NSString * _isTeacher;
    UIView * _loginView;
    
    UITextField * _nameTF;
    UITextField * _pwdTF;
    
    UIButton * _settingBtn;
    
    UIImageView * _headImageView;
    UILabel * _nickNameLabel;
    UILabel * _fansLabel;
    UILabel * _takeLabel;
    UILabel * _tagLabel1;
    UILabel * _tagLabel2;
    
    NSDictionary * _userInfo;
}

@end

@implementation AccountViewController

#pragma mark - textfieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length >= 1) {
        NSDictionary * params = @{@"nickName":_nameTF.text};
        [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/validateName", kJGT] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:kMsg] isEqualToString:@"已被占用"]) {
                NSLog(@"%@, %@, %@", [responseObject objectForKey:kStatus], [responseObject objectForKey:kData], [responseObject objectForKey:kMsg]);
            }
            else {
                [self showAlert:@"帐号不存在"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"endEdit --- %@", error);
        }];
    } else {
        [self showAlert:@"昵称不能为空"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _isTeacher = [[NSUserDefaults standardUserDefaults] objectForKey:kUser][kIsLecturer];
    _isTeacher = @"1";
    NSLog(@"isTeacher - %@", _isTeacher);
    if ([_isTeacher isEqualToString:@"1"]) {
        _dataSource = @[@"我的订单", @"帐单明细", @"银行卡管理", @"我的讨论组"];
    } else {
        _dataSource = @[@"我的订单", @"帐单明细", @"银行卡管理", @"我的讨论组"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"account - viewWillAppear");
    _pwdTF.text = @"";
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = kWhiteColor;
    
    // 初始视图
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initView];
    });

    // 获取个人信息
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUser][kToken]) {
        
        // ------------------- 打开程序, 传给服务器端Token -------------------
        NSDictionary * params = @{@"token":[[NSUserDefaults standardUserDefaults] valueForKey:kUser][kToken], @"mac":[[NSUserDefaults standardUserDefaults] valueForKey:@"device"]};
        NSString * urlStr = [NSString stringWithFormat:@"%@/regOrLog/login", kJGT];
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"token - %@", [responseObject objectForKey:kData]);
            [self savePersonInfo:[responseObject objectForKey:kData]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUser][kToken]) {
        [self.view sendSubviewToBack:_loginView];
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] valueForKey:kUser];
        NSLog(@"viewdidappear - %@", dic);
        [self setPersonInfo:dic];
        _settingBtn.hidden = NO;
        
    } else {
        [self.view bringSubviewToFront:_loginView];
    }
}

#pragma mark - 初始视图
- (void)initView {
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 自定义导航栏
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenRect.size.width, kBatteryHeight + kNavgationBarHeight)];
    [CLTool gradualBackgroundColor:navView];
    [self.view addSubview:navView];
    
    // 个人中心
    UILabel * personLabel = [[UILabel alloc] init];
    personLabel.text = @"个人中心";
    personLabel.textColor = [UIColor whiteColor];
    personLabel.textAlignment = NSTextAlignmentCenter;
    personLabel.font = [UIFont systemFontOfSize:17];
    personLabel.frame = CGRectMake(0, kBatteryHeight, kScreentWidth, kNavgationBarHeight);
    [navView addSubview:personLabel];
    
    // 设置按钮
//    UIBarButtonItem * settingsItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingsItemClick:)];
//    self.navigationItem.rightBarButtonItem = settingsItem;
//    NSLog(@"settingsItem - %@", settingsItem);
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingBtn.frame = CGRectMake(kScreentWidth - 60, kBatteryHeight, 60, kNavgationBarHeight);
    [navView addSubview:_settingBtn];
    [_settingBtn addTarget:self action:@selector(settingsItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [_settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    _settingBtn.hidden = YES;
    
    // ------------------- <#part#> -------------------
    // tableView
    CGRect frame = CGRectMake(0, CGRectGetMaxY(navView.frame), kScreentWidth, kScreentHeight-kBatteryHeight-kNavgationBarHeight-kTabbarHeight);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    // headerView
    UIView * headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, kScreentWidth, 75 + 42 + 1 + kMargin10);
    self.tableView.tableHeaderView = headerView;
    
    // 个人中心
    UIButton * personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    personBtn.frame = CGRectMake(0, 0, kScreentWidth, 75);
    [headerView addSubview:personBtn];
    personBtn.backgroundColor = kClearColor;
    [personBtn addTarget:self action:@selector(personBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 头像
    UIImageView * iconImageView = [UIImageView new];
    iconImageView.frame = CGRectMake(18, (75-50)/2, 50, 50);
    [headerView addSubview:iconImageView];
    iconImageView.image = [UIImage imageNamed:@"default_head.png"];
    iconImageView.layer.cornerRadius = iconImageView.frame.size.width / 2;
    iconImageView.layer.masksToBounds = YES;
    _headImageView = iconImageView;
    
    // 昵称
    UILabel * nicknameLabel = [UILabel new];
    nicknameLabel.frame = CGRectMake(CGRectGetMaxX(iconImageView.frame)+10, iconImageView.center.y - 22.5, kScreentWidth-CGRectGetMaxX(iconImageView.frame)-10, 22.5);
    [headerView addSubview:nicknameLabel];
//    nicknameLabel.text = @"马化腾";
    _nickNameLabel = nicknameLabel;
    
    // 标签
    UILabel * tagLabel1 = [UILabel new];
    tagLabel1.frame = CGRectMake(CGRectGetMinX(nicknameLabel.frame), CGRectGetMaxY(nicknameLabel.frame)+5, 48, 15);
    [headerView addSubview:tagLabel1];
//    tagLabel1.backgroundColor = kColor(0xFF4F53);
    tagLabel1.textColor = kWhiteColor;
    tagLabel1.textAlignment = NSTextAlignmentCenter;
    tagLabel1.text = @"未实名";
    tagLabel1.font = [UIFont systemFontOfSize:10];
    tagLabel1.layer.cornerRadius = 5;
    _tagLabel1 = tagLabel1;
    
    UILabel * tagLabel2 = [UILabel new];
    tagLabel2.frame = CGRectMake(CGRectGetMaxX(tagLabel1.frame)+5, CGRectGetMaxY(nicknameLabel.frame)+5, 60, 15);
    [headerView addSubview:tagLabel2];
//    tagLabel2.backgroundColor = kColor(0xDCDCDC);
    tagLabel2.textColor = kWhiteColor;
    tagLabel2.textAlignment = NSTextAlignmentCenter;
    tagLabel2.text = @"未传身份证";
    tagLabel2.font = [UIFont systemFontOfSize:10];
    tagLabel2.layer.cornerRadius = 5;
    _tagLabel2 = tagLabel2;
    
    // 箭头
    UIImageView * arrowImageView = [UIImageView new];
    arrowImageView.frame = CGRectMake(kScreentWidth - 25 - 7, (75-7)/2, 7, 12);
    [headerView addSubview:arrowImageView];
    arrowImageView.image = kImageNamed(@"arrow");
    
    // 分割线
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(0, 75, kScreentWidth, 1);
    [headerView addSubview:lineView];
    lineView.backgroundColor = kColor(0xF7F7F7);
    
    // 粉丝
    UILabel * fansLabel = [UILabel new];
    fansLabel.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), kScreentWidth / 2, 48);
    [headerView addSubview:fansLabel];
    fansLabel.textColor = kColor(0x1F1F1F);
    fansLabel.font = [UIFont systemFontOfSize:15];
//    fansLabel.text = @"粉丝: 888";
    fansLabel.textAlignment = NSTextAlignmentCenter;
//    NSString * str = @"粉丝: 888";
//    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
//    [mStr addAttribute:NSForegroundColorAttributeName value:kRedColor range:NSMakeRange(4, str.length-4)];
//    fansLabel.attributedText = mStr;
    _fansLabel = fansLabel;
    
    // 订阅
    UILabel * takeLabel = [UILabel new];
    takeLabel.frame = CGRectMake(kScreentWidth/2, CGRectGetMaxY(lineView.frame), kScreentWidth / 2, 48);
    [headerView addSubview:takeLabel];
    takeLabel.textColor = kColor(0x1F1F1F);
    takeLabel.font = [UIFont systemFontOfSize:15];
    takeLabel.textAlignment = NSTextAlignmentCenter;
    _takeLabel = takeLabel;
    
//    NSString * str2 = @"订阅: 66";
//    NSMutableAttributedString * mStr2 = [[NSMutableAttributedString alloc] initWithString:str2];
//    [mStr2 addAttribute:NSForegroundColorAttributeName value:kRedColor range:NSMakeRange(4, str2.length-4)];
//    takeLabel.attributedText = mStr2;
    
    UIButton * takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    takeBtn.frame = CGRectMake(CGRectGetMinX(takeLabel.frame), CGRectGetMinY(takeLabel.frame), takeLabel.frame.size.width, takeLabel.frame.size.height);
    [headerView addSubview:takeBtn];
    takeBtn.backgroundColor = kClearColor;
    [takeBtn addTarget:self action:@selector(takeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 分割线2
    UIView * lineView2 = [UIView new];
    lineView2.frame = CGRectMake(0, headerView.frame.size.height - 5, kScreentWidth, 10);
    [headerView addSubview:lineView2];
    lineView2.backgroundColor = kColor(0xF7F7F7);
    
    // ------------------- footerView -------------------
    UIView * footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, kScreentWidth, 96 + 1 + kMargin10 + 60 + 42);
    self.tableView.tableFooterView = footerView;
//    footerView.backgroundColor = kRedColor;
    
    // 分割线3
    UIView * lineView3 = [UIView new];
    lineView3.frame = CGRectMake(0, 0, kScreentWidth, kMargin10);
    [footerView addSubview:lineView3];
    lineView3.backgroundColor = kColor(0xF7F7F7);
    
    // 推荐好友
//    UILabel * recommendLabel = [UILabel new];
//    recommendLabel.frame = CGRectMake(20, kMargin10, kScreentWidth - 20, 48);
//    [footerView addSubview:recommendLabel];
//    recommendLabel.text = @"推荐好友";
//    recommendLabel.font = [UIFont systemFontOfSize:17];
    
    UIButton * recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame = CGRectMake(20, kMargin10, kScreentWidth - 20 - 20, 48);
    [footerView addSubview:recommendBtn];
    [recommendBtn setTitle:@"推荐好友" forState:UIControlStateNormal];
    recommendBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [recommendBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    recommendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [recommendBtn addTarget:self action:@selector(recommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 分割线4
    UIView * lineView4 = [UIView new];
    lineView4.frame = CGRectMake(0, CGRectGetMaxY(recommendBtn.frame), kScreentWidth, 1);
    [footerView addSubview:lineView4];
    lineView4.backgroundColor = kColor(0xF7F7F7);
    
    // 检查版本更新
    UILabel * versionLabel = [UILabel new];
    versionLabel.frame = CGRectMake(20, CGRectGetMaxY(lineView4.frame), kScreentWidth - 20 - 20, 48);
    [footerView addSubview:versionLabel];
    versionLabel.text = @"";
    versionLabel.font = [UIFont systemFontOfSize:12];
    versionLabel.textColor = kColor(0xB0B0B0);
    versionLabel.textAlignment = NSTextAlignmentRight;
    
    UIButton * versionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    versionBtn.frame = versionLabel.frame;
    [footerView addSubview:versionBtn];
    [versionBtn setTitle:@"检查版本更新" forState:UIControlStateNormal];
    versionBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [versionBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    versionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [versionBtn addTarget:self action:@selector(versionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 安全退出
    UIButton * logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(30, CGRectGetMaxY(versionBtn.frame) + 30, kScreentWidth - 30 * 2, 43);
    [footerView addSubview:logoutBtn];
    [CLTool gradualBackgroundColor:logoutBtn];
    [logoutBtn setTitle:@"安全退出" forState:UIControlStateNormal];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 登录界面
    [self loginView];
}

#pragma mark - 登录界面
- (void)loginView {
    _loginView = [UIView new];
    _loginView.frame = CGRectMake(0, kMargin64, kScreentWidth, kScreentHeight - kMargin64 - kTabbarHeight);
    [self.view addSubview:_loginView];
    _loginView.backgroundColor = kWhiteColor;
    
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake((kScreentWidth - 75) / 2, 20, 75, 75);
    [_loginView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"default_head.png"];
    
    // 帐号
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(0, 75 + 20, 96, 48);
    [_loginView addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"帐号";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    _nameTF = [UITextField new];
    _nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreentWidth - 96 - 18, 48);
    [_loginView addSubview:_nameTF];
    _nameTF.delegate = self;
    _nameTF.placeholder = @"用户名/手机号/邮箱";
    
    UIView * line1 = [UIView new];
    line1.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreentWidth, 1);
    [_loginView addSubview:line1];
    line1.backgroundColor = kLineColor;
    
    // 密码
    UILabel * pwdLabel = [UILabel new];
    pwdLabel.frame = CGRectMake(0, CGRectGetMaxY(line1.frame) + 1, 96, 48);
    [_loginView addSubview:pwdLabel];
    pwdLabel.textColor = kColor(0x1F1F1F);
    pwdLabel.font = [UIFont systemFontOfSize:15];
    pwdLabel.text = @"密码";
    pwdLabel.textAlignment = NSTextAlignmentCenter;
    
    _pwdTF = [UITextField new];
    _pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdLabel.frame), CGRectGetMinY(pwdLabel.frame), kScreentWidth - 96 - 18, 48);
    [_loginView addSubview:_pwdTF];
    _pwdTF.placeholder = @"请输入的您的密码";
    _pwdTF.secureTextEntry = YES;
    
    UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame = CGRectMake(kScreentWidth - 44, CGRectGetMinY(_pwdTF.frame), 44, 44);
    [_loginView addSubview:pwdBtn];
    [pwdBtn setImage:kImageNamed(@"pwd.png") forState:UIControlStateNormal];;
    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * line2 = [UIView new];
    line2.frame = CGRectMake(0, CGRectGetMaxY(pwdLabel.frame), kScreentWidth, 1);
    [_loginView addSubview:line2];
    line2.backgroundColor = kLineColor;

    // 登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, CGRectGetMaxY(line2.frame) + 12, kScreentWidth - 60, 44);
    [_loginView addSubview:loginBtn];
    [CLTool gradualBackgroundColor:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    
    // 忘记密码
    UIButton * forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(30, CGRectGetMaxY(loginBtn.frame) + 12, (kScreentWidth - 60) / 2, 44);
    [_loginView addSubview:forgetPwdBtn];
    [forgetPwdBtn setTitleColor:kColor(0x59739B) forState:UIControlStateNormal];
    [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 快速注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(CGRectGetMaxX(forgetPwdBtn.frame), CGRectGetMaxY(loginBtn.frame) + 12, (kScreentWidth - 60) / 2, 44);
    [_loginView addSubview:registerBtn];
    [registerBtn setTitleColor:kColor(0x59739B) forState:UIControlStateNormal];
    [registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    // QQ快速登录
    UIButton * qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    qqLoginBtn.frame = CGRectMake(kScreentWidth / 2 - 10 - 44, kScreentHeight - kMargin64 - kTabbarHeight - 10 - 44, 44, 44);
    qqLoginBtn.frame = CGRectMake((kScreentWidth - 44) / 2, kScreentHeight - kMargin64 - kTabbarHeight - 10 - 44, 44, 44);
    [_loginView addSubview:qqLoginBtn];
    [qqLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [qqLoginBtn setBackgroundImage:kImageNamed(@"login_fast_qq.png") forState:UIControlStateNormal];
    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 微信快速登录
    UIButton * wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.frame = CGRectMake(kScreentWidth / 2 + 10, kScreentHeight - kMargin64 - kTabbarHeight - 10 - 44, 44, 44);
//    [_loginView addSubview:wxLoginBtn];
    [wxLoginBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    [wxLoginBtn setBackgroundImage:kImageNamed(@"login_fast_weixin.png") forState:UIControlStateNormal];
    [wxLoginBtn addTarget:self action:@selector(wxLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 密码显示隐藏
- (void)pwdBtnClick {
    _pwdTF.secureTextEntry = !_pwdTF.secureTextEntry;
}

#pragma mark - 登录操作
- (void)loginBtn:(UIButton *)sender {
    NSLog(@"longinBtn");
    if (_nameTF.text.length >= 1) {
        if (_pwdTF.text.length >= 6) {
            [self.view endEditing:YES];
//            NSString * token = @"";
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:kToken]) {
//                token = [[NSUserDefaults standardUserDefaults] valueForKey:kToken];
//            }

            NSDictionary * params = @{@"nickName":_nameTF.text, @"password":_pwdTF.text, @"token":@"", @"mac":[[NSUserDefaults standardUserDefaults] valueForKey:@"device"]};
            NSString * urlStr = [NSString stringWithFormat:@"%@/regOrLog/login", kJGT];
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if ([[responseObject objectForKey:@"status"] integerValue] == -1 || [[responseObject objectForKey:@"status"] integerValue] == 500) {
                    [self showAlert:[responseObject objectForKey:kMsg]];
                } else {
                    
                    if ([[responseObject objectForKey:@"status"] integerValue] == 10) {
                        
                        _isTeacher = @"0";
                    } else if ([[responseObject objectForKey:@"status"] integerValue] == 11) {
                        _isTeacher = @"1";
                    }
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        // 返回登录界面
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"登录成功 - -%@", [responseObject objectForKey:@"data"]);
                            _userInfo = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:kData]];
                            
                            NSDictionary * dic = [responseObject objectForKey:@"data"];
                            
                            // 个人信息持久化
                            [self savePersonInfo:dic];
                            
                            // 清空登录信息
                            _nameTF.text = @"";
                            _pwdTF.text = @"";
                            
                            [_tableView reloadData];
                            _settingBtn.hidden = NO;
                            [self.view sendSubviewToBack:_loginView];
                        });
                    }]];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error - %@", error);
            }];
        } else {
            [self showAlert:@"密码为6位"];
        }
    } else {
        [self showAlert:@"用户名不能为空"];
    }
}

#pragma mark - 个人信息持久化
- (void)savePersonInfo:(NSDictionary *)dic {
    
    // 手机号
    NSString * phone = @"";
    if ([dic[kUser][kPhone] respondsToSelector:@selector(isEqualToString:)]) {
        phone = dic[kUser][kPhone];
    }
    
    // 是否实名认证
    NSString * isIndentify = @"";
    if ([dic[kUser][kIsIndentify] respondsToSelector:@selector(isEqualToString:)]) {
        isIndentify = dic[kUser][kIsIndentify];
    }
    
    // 身份证号
    NSString * idNumber = @"";
    if ([dic[kUser][kIdNumber] respondsToSelector:@selector(isEqualToString:)]) {
        idNumber = dic[kUser][kIdNumber];
    }
    
    // 真实姓名
    NSString * userName = @"";
    if ([dic[kUser][kUserName] respondsToSelector:@selector(isEqualToString:)]) {
        userName = dic[kUser][kUserName];
    }
    
    // 云信帐户
    NSString * imaccid = @"";
    if ([dic[kUser][kIMAccId] respondsToSelector:@selector(isEqualToString:)]) {
        imaccid = dic[kUser][kIMAccId];
    }
    
    // 云信token
    NSString * imtoken = @"";
    if ([dic[kUser][kIMToken] respondsToSelector:@selector(isEqualToString:)]) {
        imtoken = dic[kUser][kIMToken];
    }

    _userInfo = @{kToken:dic[kToken],
                  kHeadPic:dic[kUser][kHeadPic],
                  kNickName:dic[kUser][kNickName],
                  kPhone:phone,
                  kSubscriptionNum:dic[kSubscriptionNum],
                  KAttentionNum:dic[KAttentionNum],
                  kUserID:dic[kUser][kId],
                  kIsLecturer:_isTeacher,
                  kIsIndentify:isIndentify,
                  kUserName:userName,
                  kIdNumber:idNumber,
                  kIMAccId:imaccid,
                  kIMToken:imtoken
                  };
    
    // 保存到本地
    [[NSUserDefaults standardUserDefaults] setValue:_userInfo forKey:kUser];
    NSLog(@"account - %@", _userInfo);

    // 更新个人信息
    [self setPersonInfo:_userInfo];
}

#pragma mark - 设置用户信息
- (void)setPersonInfo:(NSDictionary *)info  {
    NSString * imgStr = [NSString stringWithFormat:@"%@%@", kJGTGetImage, info[@"headPic"]];
    NSLog(@"setPersonInfo - %@", imgStr);
    [_headImageView setImageWithURL:[NSURL URLWithString:imgStr]];
    
    _nickNameLabel.text = info[@"nickName"];
    NSString * fansStr = [NSString stringWithFormat:@"粉丝: %@", info[KAttentionNum]];
    NSMutableAttributedString * mFansStr = [[NSMutableAttributedString alloc] initWithString:fansStr];
    [mFansStr addAttribute:NSForegroundColorAttributeName value:kRedColor range:NSMakeRange(4, fansStr.length-4)];
    _fansLabel.attributedText = mFansStr;

    NSString * takeStr = [NSString stringWithFormat:@"订阅: %@", info[kSubscriptionNum]];
    NSMutableAttributedString * mTakeStr = [[NSMutableAttributedString alloc] initWithString:takeStr];
    [mTakeStr addAttribute:NSForegroundColorAttributeName value:kRedColor range:NSMakeRange(4, takeStr.length-4)];
    _takeLabel.attributedText = mTakeStr;
    
}

- (void)showAlert:(NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 忘记密码操作
- (void)forgetPwdBtnClick:(UIButton *)sender {
    ChangePasswordViewController * changPasswordVC = [ChangePasswordViewController new];
    [self.navigationController pushViewController:changPasswordVC animated:YES];
}

#pragma mark - 快速注册操作
- (void)registerBtnClick:(UIButton *)sender {
    RegisterViewController * registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 快速登录操作
// QQ登录
- (void)qqLoginBtnClick:(UIButton *)sender {
    [self getUserInfoFromePlatform:UMSocialPlatformType_QQ];
}

// 微信登录
- (void)wxLoginBtnClick:(UIButton *)sender {
    [CLTool showAlert:@"暂不支持微信登录" target:self];
//    if([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
//        [self getUserInfoFromePlatform:UMSocialPlatformType_WechatSession];
//    } else {
//        [CLTool showAlert:@"请先安装微信" target:self];
//    }
}

- (void)getUserInfoFromePlatform:(UMSocialPlatformType)platform
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platform currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        if (error) {
            
        }
        else {
            
            // 授权成功, 向服务器发送数据
            NSDictionary * params = @{kNickName:resp.name, kPassword:@"", kToken:@"", kMac:[[NSUserDefaults standardUserDefaults] valueForKey:@"device"], kPhone:@"", kHeadPic:resp.iconurl, kIsLecturer:@"0", @"uid":resp.uid};
            NSString * urlStr = [NSString stringWithFormat:@"%@/regOrLog/thirdLogin", kJGT];
        
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([[responseObject objectForKey:@"status"] integerValue] == -1 || [[responseObject objectForKey:@"status"] integerValue] == 500) {
                    [self showAlert:[responseObject objectForKey:kMsg]];
                } else {
                    
                    // 向服务器发送数据成功, 将信息缓存到本地
                    if ([[responseObject objectForKey:@"status"] integerValue] == 10) {
                        _isTeacher = @"0";
                    } else if ([[responseObject objectForKey:@"status"] integerValue] == 11) {
                        _isTeacher = @"1";
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // 清空登录信息
                        _nameTF.text = @"";
                        _pwdTF.text = @"";
                        
                        NSDictionary * dic = [responseObject objectForKey:kData];
                        
                        // 个人信息持久化
                        [self savePersonInfo:dic];
                        
                        // 更新界面
                        [_tableView reloadData];
                        _settingBtn.hidden = NO;
                        
                        [self.view sendSubviewToBack:_loginView];
                    });
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }];
}

#pragma mark - 订阅
- (void)takeBtnClick:(UIButton *)sender {
    SubscribeViewController * subscribeVC = [SubscribeViewController new];
    subscribeVC.userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUser][kUserID];
    [self.navigationController pushViewController:subscribeVC animated:YES];
}

#pragma mark - 个人中心按钮
- (void)personBtnClick:(UIButton *)sender {
    PersonViewController * personVC = [PersonViewController new];
    [self.navigationController pushViewController:personVC animated:YES];
}

#pragma mark - 设置按钮
- (void)settingsItemClick:(UIBarButtonItem *)sender {
    NSLog(@"settingsItemClick");
    SettingsViewController * settingsVC = [SettingsViewController new];
    settingsVC.userInfo = _userInfo;
    [self.navigationController pushViewController:settingsVC animated:YES];
}

#pragma mark - 推荐好友
- (void)recommendBtnClick:(UIButton *)sender {
    NSLog(@"recommendBtnClick");
//    RecommendFriendViewController * recommendFriendVC = [RecommendFriendViewController new];
//    [self.navigationController pushViewController:recommendFriendVC animated:YES];
    UIAlertController * alert = [UIAlertController new];
    
    // 微信好友
    
    [alert addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
        } else {
            [CLTool showAlert:@"请先安装微信" target:self];
        }
    }]];
    
    
    // 微信朋友圈
    [alert addAction:[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
        } else {
            [CLTool showAlert:@"请先安装微信" target:self];
        }
    }]];
    
    // QQ好友
    [alert addAction:[UIAlertAction actionWithTitle:@"QQ好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        } else {
            [CLTool showAlert:@"请先安装QQ" target:self];
        }
    }]];
    
    // QQ空间
    [alert addAction:[UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
        } else {
            [CLTool showAlert:@"请先安装QQ" target:self];
        }
    
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【荐股厅】" descr:@"【荐股厅】- 专业的股票信息平台! " thumImage:nil];
    //设置网页地址
    shareObject.webpageUrl = @"https://www.apple.com/itunes/";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        UMSocialShareResponse *resp = data;
        NSLog(@"%@, %@", resp.message, resp.originalResponse);
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
//            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
            
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//            }else{
//                UMSocialLogInfo(@"response data is %@",data);
//            }
        }
    }];
}

#pragma mark - 检查更新
- (void)versionBtnClick:(UIButton *)sender {
    NSLog(@"versionBtnClick");
//    VersionViewController * versionVC = [VersionViewController new];
//    [self.navigationController pushViewController:versionVC animated:YES];
    
    [CLTool showAlert:@"已经是最新版本了" target:self];
}

#pragma mark - 退出按钮
- (void)logoutBtnClick:(UIButton *)sender {
    NSLog(@"logoutBtnClick");
    [self.view bringSubviewToFront:_loginView];
    _settingBtn.hidden = YES;
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] valueForKey:kUser];
    [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/logout", kJGT] parameters:@{@"token":dic[kToken]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"logout - %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"endEdit --- %@", error);
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUser];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"account";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"account - didSelect - %ld", indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MsgViewController * msgVC = [[MsgViewController alloc] init];
        [self.navigationController pushViewController:msgVC animated:YES];
    } else if (indexPath.row == 1) {
        BillViewController * billVC = [BillViewController new];
        [self.navigationController pushViewController:billVC animated:YES];
    } else if (indexPath.row == 2) {
        CardViewController * cardVC = [CardViewController new];
        [self.navigationController pushViewController:cardVC animated:YES];
    } else if (indexPath.row == 3) {
        TeamViewController * teamVC = [TeamViewController new];
        [self.navigationController pushViewController:teamVC animated:YES];
    } else {
        WithDrawViewController * withDrawVC = [WithDrawViewController new];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
