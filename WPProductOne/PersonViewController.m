//
//  PersonViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "PersonViewController.h"
#import "UploadViewController.h"


@interface PersonViewController ()
{
    UITextField * _nameTF;
    UITextField * _numberTF;
    NSDictionary * _userInfo;
    UIButton * _cardBtn;
}
@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"个人中心";
    
}

- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // ------------------- 1 -------------------
    UIView * headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreentWidth, 200);
    [CLTool gradualBackgroundColor:headerView];
    [self.view addSubview:headerView];
//    headerView.backgroundColor = kGlobalColor;
    
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake((kScreentWidth - 80) / 2, 10, 80, 90);
    imageView.image = [UIImage imageNamed:@"renzheng.png"];
    [headerView addSubview:imageView];
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake((kScreentWidth-150)/2, CGRectGetMaxY(imageView.frame)+10, 150, 22.5);
    [headerView addSubview:label];
    label.textColor = kWhiteColor;
    label.font = [UIFont systemFontOfSize:16];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreentWidth - 150) / 2, CGRectGetMaxY(label.frame) + 10, 150, 31);
    [headerView addSubview:btn];
    [btn setTitle:@"查看实名权益" forState:UIControlStateNormal];
    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    btn.layer.cornerRadius = 31/2;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = kWhiteColor.CGColor;
    
    // ------------------- 2. 输入信息 -------------------
    // 真实姓名
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), 100, 48);
    [self.view addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"真实姓名";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    UITextField * nameTF = [UITextField new];
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreentWidth - CGRectGetMaxX(nameLabel.frame) - 18, 48);
    [self.view addSubview:nameTF];
    nameTF.textColor = kColor(0xB0B0B0);
    nameTF.font = [UIFont systemFontOfSize:15];
    nameTF.textAlignment = NSTextAlignmentRight;
    nameTF.placeholder = @"请输入真实姓名";
    _nameTF = nameTF;
    
    // 身份证号
    UILabel * numberLabel = [UILabel new];
    numberLabel.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), 100, 48);
    [self.view addSubview:numberLabel];
    numberLabel.textColor = kColor(0x1F1F1F);
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"身份证号";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    
    UITextField * numberTF = [UITextField new];
    numberTF.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame), CGRectGetMinY(numberLabel.frame), kScreentWidth - CGRectGetMaxX(numberLabel.frame) - 18, 48);
    [self.view addSubview:numberTF];
    numberTF.textColor = kColor(0xB0B0B0);
    numberTF.font = [UIFont systemFontOfSize:15];
    numberTF.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    numberTF.text = @"1**************19";
    numberTF.placeholder = @"请输入身份证号";
    numberTF.textAlignment = NSTextAlignmentRight;
    _numberTF = numberTF;
    
    // 证件信息
    UILabel * cardLabel = [UILabel new];
    cardLabel.frame = CGRectMake(0, CGRectGetMaxY(numberLabel.frame), 100, 48);
    [self.view addSubview:cardLabel];
    cardLabel.textColor = kColor(0x1F1F1F);
    cardLabel.font = [UIFont systemFontOfSize:15];
    cardLabel.text = @"证件信息";
    cardLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton * cardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cardBtn.frame = CGRectMake(CGRectGetMaxX(cardLabel.frame), CGRectGetMinY(cardLabel.frame), kScreentWidth - CGRectGetMaxX(cardLabel.frame) - 18, 48);
    [self.view addSubview:cardBtn];
    [cardBtn setTitle:@"点击上传" forState:UIControlStateNormal];
    [cardBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    cardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cardBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _cardBtn = cardBtn;
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(30, CGRectGetMaxY(cardBtn.frame) + 30, kScreentWidth - 30 * 2, 43);
    [self.view addSubview:submitBtn];
    [CLTool gradualBackgroundColor:submitBtn];
    [submitBtn setTitle:@"提交信息" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"userInfo - %@", _userInfo);
    if ([_userInfo[kIsIndentify] isEqualToString:@"1"]) {
        label.text = @"您已通过实名认证";
        nameTF.text = _userInfo[kUserName];
        nameTF.userInteractionEnabled = NO;
        numberTF.text = _userInfo[kIdNumber];
        numberTF.userInteractionEnabled = NO;
        [_cardBtn setTitle:@"已上传" forState:UIControlStateNormal];
        _cardBtn.userInteractionEnabled = NO;
        submitBtn.userInteractionEnabled = NO;
    } else {
        label.text = @"您没有通过实名认证";
    }
}

- (void)submitBtnClick {
    NSString * urlStr = [NSString stringWithFormat:@"%@/center/user/realName", kJGT];
    NSString * z = [[NSUserDefaults standardUserDefaults] objectForKey:@"zPic"];
    NSString * b = [[NSUserDefaults standardUserDefaults] objectForKey:@"bPic"];
    NSDictionary * param = @{@"realName":_nameTF, @"idNum":_numberTF.text, @"zPic":z, @"bPic":b};
    NSLog(@"person - %@", param);
    [[AFHTTPSessionManager manager] GET:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"person - %@", responseObject);
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            [CLTool showAlert:@"认证通过" target:self];
        } else {
            [CLTool showAlert:@"认证未通过" target:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)cardBtnClick:(UIButton *)sender {
    NSLog(@"cardBtnClick");
    UploadViewController * uploadVC = [UploadViewController new];
    [self.navigationController pushViewController:uploadVC animated:YES];
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
