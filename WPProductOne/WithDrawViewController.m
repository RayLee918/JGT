//
//  WithDrawViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/25.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "WithDrawViewController.h"

@interface WithDrawViewController ()

@end

@implementation WithDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"资金提现";
}

- (void)initView {
    UIView * cardView = [UIView new];
    cardView.frame = CGRectMake(30, 10, kScreentWidth - 30 * 2, 120);
    [self.view addSubview:cardView];
    cardView.backgroundColor = kBlueColor;
    
    UIImageView * iv= [UIImageView new];
    iv.frame = CGRectMake(20, CGRectGetMaxY(cardView.frame) + 15 + 15, 14, 14);
    [self.view addSubview:iv];
    iv.backgroundColor = kBlueColor;
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(40, CGRectGetMaxY(cardView.frame) + 15, kScreentWidth - 40 * 2, 44);
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:11];
    label.text = @"该卡单次的提现上限为20,000.00元";
    
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(20, CGRectGetMaxY(label.frame), 60, 44);
    [self.view addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"金额";
    
    UITextField * tf = [UITextField new];
    tf.frame = CGRectMake(80, CGRectGetMinY(titleLabel.frame), kScreentWidth - 100, 44);
    [self.view addSubview:tf];
    tf.placeholder = @"最低金额300.00元";
    tf.textColor = kColor(0xC7C7C7);
    tf.font = [UIFont systemFontOfSize:13];
    
    // 费率
    UILabel * feilvLabel = [UILabel new];
    feilvLabel.frame = CGRectMake(20, CGRectGetMaxY(titleLabel.frame) + 10, 100, 30);
    [self.view addSubview:feilvLabel];
    feilvLabel.font = [UIFont systemFontOfSize:11];
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:@"费率:  0.1费率"];
    [mStr addAttribute:NSForegroundColorAttributeName value:kGlobalColor range:NSMakeRange(mStr.length - 5, 5)];
    feilvLabel.attributedText = mStr;
    
    UILabel * descLabel1 = [UILabel new];
    descLabel1.frame = CGRectMake(20, CGRectGetMaxY(feilvLabel.frame), kScreentWidth - 20 * 2, 44);
    [self.view addSubview:descLabel1];
    descLabel1.font = [UIFont systemFontOfSize:11];
    descLabel1.text = @"*提现金额大于2000需要输入本人信息";
    descLabel1.textColor = kColor(0x666666);
    
    UILabel * descLabel2 = [UILabel new];
    descLabel2.frame = CGRectMake(20, CGRectGetMaxY(descLabel1.frame), kScreentWidth - 20 * 2, 44);
    [self.view addSubview:descLabel2];
    descLabel2.font = [UIFont systemFontOfSize:11];
    descLabel2.text = @"*基金交易安全由平安银行全程监管";
    descLabel2.textColor = kColor(0x666666);
    
    UILabel * descLabel3 = [UILabel new];
    descLabel3.frame = CGRectMake(20, CGRectGetMaxY(descLabel2.frame), kScreentWidth - 20 * 2, 44);
    [self.view addSubview:descLabel3];
    descLabel3.font = [UIFont systemFontOfSize:11];
    descLabel3.text = @"*基金交易安全由平安银行全程监管";
    descLabel3.textColor = kColor(0x666666);
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
