//
//  AddCardViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/19.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "AddCardViewController.h"

@interface AddCardViewController () <UITextFieldDelegate>
{
    UITextField * _nameTF;
    UITextField * _cardNumberTF;
    UITextField * _bankTF;
    
    NSMutableArray * _dataSource;
}
@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];

}


#pragma mark - 创建视图
- (void)initView {
    
    // 昵称
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(20, 44, 96, 48);
    [self.view addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"姓名";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * nameTF = [UITextField new];
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
    [self.view addSubview:nameTF];
    nameTF.placeholder = @"例如\"王东方\"";
    nameTF.delegate = self;
    _nameTF = nameTF;
    
    UIView * line1 = [UIView new];
    line1.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreentWidth, 1);
    [self.view addSubview:line1];
    line1.backgroundColor = kColor(0xF7F7F7);
    
    // 手机号
    UILabel * numberLabel = [UILabel new];
    numberLabel.frame = CGRectMake(20, CGRectGetMaxY(line1.frame) + 1, 96, 48);
    [self.view addSubview:numberLabel];
    numberLabel.textColor = kColor(0x1F1F1F);
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"银行卡号";
    numberLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * numberTF = [UITextField new];
    numberTF.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame), CGRectGetMinY(numberLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
    [self.view addSubview:numberTF];
    numberTF.placeholder = @"请填写银行卡号";
    numberTF.keyboardType = UIKeyboardTypeNumberPad;
    numberTF.delegate = self;
    _cardNumberTF = numberTF;
    
    UIView * line2 = [UIView new];
    line2.frame = CGRectMake(0, CGRectGetMaxY(numberLabel.frame) - 1, kScreentWidth, 1);
    [self.view addSubview:line2];
    line2.backgroundColor = kColor(0xF7F7F7);
    
    // 开户行
    UILabel * bankLabel = [UILabel new];
    bankLabel.frame = CGRectMake(20, CGRectGetMaxY(numberLabel.frame), 96, 48);
//    [self.view addSubview:bankLabel];
    bankLabel.textColor = kColor(0x1F1F1F);
    bankLabel.font = [UIFont systemFontOfSize:15];
    bankLabel.text = @"开户行";
    bankLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * bankTF = [UITextField new];
    bankTF.frame = CGRectMake(CGRectGetMaxX(bankLabel.frame), CGRectGetMinY(bankLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
//    [self.view addSubview:bankTF];
    bankTF.placeholder = @"请填写开户行";
    bankTF.keyboardType = UIKeyboardTypeNumberPad;
    bankTF.delegate = self;
    _bankTF = bankTF;
    
    UIView * line3 = [UIView new];
    line3.frame = CGRectMake(0, CGRectGetMaxY(bankLabel.frame) - 1, kScreentWidth, 1);
//    [self.view addSubview:line3];
    line3.backgroundColor = kColor(0xF7F7F7);
    
    UIButton * cardSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cardSubmitBtn.frame = CGRectMake((kScreentWidth - 150) / 2, CGRectGetMaxY(numberLabel.frame) + 44, 150, 48);
    [CLTool gradualBackgroundColor:cardSubmitBtn];
    [self.view addSubview:cardSubmitBtn];
    [cardSubmitBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    [cardSubmitBtn setTitle:@"提交信息" forState:UIControlStateNormal];
    [cardSubmitBtn addTarget:self action:@selector(cardSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cardSubmitBtnClick {
    NSString * url = [NSString stringWithFormat:@"%@/user/manageCard/addCard", kJGT];
    if (_nameTF.text.length >= 1) {
        if (_cardNumberTF.text.length >= 1) {
            if ([_cardNumberTF.text hasPrefix:@"6"] || [_cardNumberTF.text hasPrefix:@"5"] || [_cardNumberTF.text hasPrefix:@"4"]) {
                NSDictionary * dic = @{@"name":_nameTF.text, @"cardNum":_cardNumberTF.text};
                [[AFHTTPSessionManager manager] GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                        [CLTool showAlert:@"添加银行卡成功" target:self];
                    } else {
                        [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            } else {
                [CLTool showAlert:@"不支持该银行卡" target:self];
            }
        } else {
            [CLTool showAlert:@"银行卡号不能为空" target:self];
        }
    } else {
        [CLTool showAlert:@"姓名不能为空" target:self];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"添加银行卡";
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
