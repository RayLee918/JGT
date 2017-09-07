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

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.view addSubview:headerView];
    headerView.backgroundColor = kGlobalColor;
    
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake((kScreentWidth - 80) / 2, 10, 80, 90);
    imageView.image = [UIImage imageNamed:@"renzheng.png"];
    [headerView addSubview:imageView];
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake((kScreentWidth-135)/2, CGRectGetMaxY(imageView.frame)+10, 135, 22.5);
    [headerView addSubview:label];
    label.textColor = kWhiteColor;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"您已通过实名认证";
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreentWidth - 120) / 2, CGRectGetMaxY(label.frame) + 10, 120, 31);
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
    nameTF.text = @"马画藤";
    
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
    numberTF.text = @"1**************19";
    numberTF.textAlignment = NSTextAlignmentRight;
    
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
