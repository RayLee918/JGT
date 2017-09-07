//
//  BuyViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()
{
    UIButton * _backgroundBtn;
    UIView * _buyView1;
    UIView * _buyView2;
}
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"课程购买";
}

- (void)initView {
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreentWidth, kScreentHeight - kBatteryHeight - kTabbarHeight - kNavgationBarHeight - 100)];
    [self.view addSubview:webView];
    webView.backgroundColor = kWhiteColor;
    webView.opaque = NO;
    
//    NSString * urlStr = [NSString stringWithFormat:@"%@/views/html/userAgreement.html", kJGT];
//    NSLog(@"urlStr - %@", urlStr);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(0, kScreentHeight - kMargin64 - kTabbarHeight - 44, kScreentWidth, 44);
    [self.view addSubview:buyBtn];
//    buyBtn.backgroundColor = kGlobalColor;
    [buyBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 特别提示
    UILabel * label1 = [UILabel new];
    label1.frame = CGRectMake(0, CGRectGetMinY(buyBtn.frame) - 10 - 44, kScreentWidth, 22);
    [self.view addSubview:label1];
    label1.textColor = kColor(0x9B9B9B);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:10];
    NSString * str1 = @"点击确认支付代表同意《VIP课程购买》并已阅读《风险提示》";
    
    NSRange range1 = [str1 rangeOfString:@"《VIP课程购买》"];
    NSRange range2 = [str1 rangeOfString:@"《风险提示》"];
    NSMutableAttributedString * mStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [mStr1 addAttribute:NSForegroundColorAttributeName value:kColor(0x4990E2) range:range1];
    [mStr1 addAttribute:NSForegroundColorAttributeName value:kColor(0x4990E2) range:range2];
    label1.attributedText = mStr1;
    
    UILabel * label2 = [UILabel new];
    label2.frame = CGRectMake(0, CGRectGetMinY(buyBtn.frame) - 10 - 22, kScreentWidth, 22);
    [self.view addSubview:label2];
    label2.textColor = kColor(0x9B9B9B);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:10];
    label2.text = @"VIP课程均为荐股厅有限公司提供";
    
    [self initBuyView1];
    [self initBuyViwe2];
    
}

- (void)initBuyView1 {
    // 背景
    _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backgroundBtn.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight);
    [self.view addSubview:_backgroundBtn];
    _backgroundBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [_backgroundBtn addTarget:self action:@selector(backgroundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _backgroundBtn.hidden = YES;
//    _backgroundBtn.backgroundColor = kRedColor;
    
    _buyView1 = [UIView new];
    CGFloat height = 44 * 4 + (64 + 15) * 2;
    _buyView1.frame = CGRectMake(0, CGRectGetMaxY(_backgroundBtn.frame) - height - 49 - 64, kScreentWidth, height);
    [_backgroundBtn addSubview:_buyView1];
    _buyView1.backgroundColor = kWhiteColor;
    
    UIButton * buyBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn2.frame = CGRectMake(0, _buyView1.frame.size.height - 44, kScreentWidth, 44);
    [_buyView1 addSubview:buyBtn2];
    buyBtn2.backgroundColor = kGlobalColor;
    buyBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn2 setTitle:@"立即购买2" forState:UIControlStateNormal];
    [buyBtn2 addTarget:self action:@selector(buyBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    // 标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(44, 0, kScreentWidth - 88, 44);
    [_buyView1 addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"分析趋势VIP课程";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) - 1, kScreentWidth, 1);
    [_buyView1 addSubview:lineView];
    lineView.backgroundColor = kLineColor;
    
    // 选择课程
    UILabel * selectLabel = [UILabel new];
    selectLabel.frame = CGRectMake(44, 44, kScreentWidth - 88, 44);
    [_buyView1 addSubview:selectLabel];
    selectLabel.font = [UIFont systemFontOfSize:15];
    selectLabel.textColor = kColor(0xB0B0B0);
    selectLabel.text = @"请选择让你购买的课程";
    
    // 价钱
    for (int i = 0; i < 4; i++) {
        
        CGFloat width = (kScreentWidth - 45) / 2;
        CGFloat x = 15 + (width + 15) * (i % 2);
        CGFloat y = 88 + (64 + 15) * (i / 2);
        
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(x, y + 12, width, 20);
        [_buyView1 addSubview:label];
        label.text = @"1198";
        label.textColor = kColor(0x1F1F1F);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel * label2 = [UILabel new];
        label2.frame = CGRectMake(x, y + 12 + 20, width, 20);
        [_buyView1 addSubview:label2];
        label2.text = @"1个月";
        label2.textColor = kColor(0xB0B0B0);
        label2.font = [UIFont systemFontOfSize:10];
        label2.textAlignment = NSTextAlignmentCenter;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, 64);
        [_buyView1 addSubview:btn];
        btn.layer.borderColor = kColor(0xFF4F53).CGColor;
        btn.layer.borderWidth = 0.5;
        [btn addTarget:self action:@selector(selectMealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    // 实付金额
    UILabel * moneyLabel = [UILabel new];
    moneyLabel.frame = CGRectMake(20, CGRectGetMaxY(selectLabel.frame) + 2 * (64 + 15), kScreentWidth - 20, 44);
    [_buyView1 addSubview:moneyLabel];
    moneyLabel.font = [UIFont systemFontOfSize:13];
    moneyLabel.text = @"实付金额";
    moneyLabel.textColor = kColor(0xB0B0B0);
    
    UILabel * moneyLabel2 = [UILabel new];
    moneyLabel2.frame = CGRectMake(kScreentWidth - 150, CGRectGetMinY(moneyLabel.frame), kScreentWidth - 20, 44);
    [_buyView1 addSubview:moneyLabel2];
    moneyLabel2.font = [UIFont systemFontOfSize:15];
    moneyLabel2.text = @"8888元";
    moneyLabel2.textColor = kGlobalColor;
}

- (void)initBuyViwe2 {
    // 第二个购买页面
    _buyView2 = [UIView new];
    CGFloat height2 = 44 * 5 + 20;
    _buyView2.frame = CGRectMake(0, CGRectGetMaxY(_backgroundBtn.frame) - height2 - kMargin64 - kTabbarHeight, kScreentWidth, height2);
//    [_backgroundBtn addSubview:_buyView2];
    _buyView2.backgroundColor = kWhiteColor;
    
    UIButton * buyBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn3.frame = CGRectMake(0, _buyView2.frame.size.height - 44, kScreentWidth, 44);
    [_buyView2 addSubview:buyBtn3];
    buyBtn3.backgroundColor = kGlobalColor;
    buyBtn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn3 setTitle:@"立即购买3" forState:UIControlStateNormal];
    [buyBtn3 addTarget:self action:@selector(buyBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
    
    // 标题
    UILabel * titleLabel2 = [UILabel new];
    titleLabel2.frame = CGRectMake(44, 0, kScreentWidth - 88, 44);
    [_buyView2 addSubview:titleLabel2];
    titleLabel2.font = [UIFont systemFontOfSize:15];
    titleLabel2.text = @"选择支付方式";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * lineView2 = [UIView new];
    lineView2.frame = CGRectMake(0, CGRectGetMaxY(titleLabel2.frame) - 1, kScreentWidth, 1);
    [_buyView2 addSubview:lineView2];
    lineView2.backgroundColor = kLineColor;
    
    // 微信支付
    UIImageView * weixinImageV = [UIImageView new];
    weixinImageV.frame = CGRectMake(0, CGRectGetMaxY(titleLabel2.frame), 44, 44);
    [_buyView2 addSubview:weixinImageV];
    weixinImageV.backgroundColor = kGlobalColor;
    
    UILabel * weixinLabel = [UILabel new];
    weixinLabel.frame = CGRectMake(44, CGRectGetMaxY(titleLabel2.frame), kScreentWidth - 88, 44);
    [_buyView2 addSubview:weixinLabel];
    weixinLabel.font = [UIFont systemFontOfSize:12];
    weixinLabel.text = @"微信支付";
    
    // 分割线
    UIView * lineView3 = [UIView new];
    lineView3.frame = CGRectMake(0, CGRectGetMaxY(weixinImageV.frame) - 1, kScreentWidth, 1);
    [_buyView2 addSubview:lineView3];
    lineView3.backgroundColor = kLineColor;
    
    // 支付宝支付
    UIImageView * zhifubaoImageV = [UIImageView new];
    zhifubaoImageV.frame = CGRectMake(0, CGRectGetMaxY(weixinImageV.frame), 44, 44);
    [_buyView2 addSubview:zhifubaoImageV];
    zhifubaoImageV.backgroundColor = kGlobalColor;
    
    UILabel * zhifubaoLabel = [UILabel new];
    zhifubaoLabel.frame = CGRectMake(44, CGRectGetMaxY(weixinImageV.frame), kScreentWidth - 88, 44);
    [_buyView2 addSubview:zhifubaoLabel];
    zhifubaoLabel.font = [UIFont systemFontOfSize:12];
    zhifubaoLabel.text = @"支付宝支付";
    
    UILabel * moneyLabel3 = [UILabel new];
    moneyLabel3.frame = CGRectMake(20, CGRectGetMaxY(zhifubaoImageV.frame), kScreentWidth - 20, 64);
    [_buyView2 addSubview:moneyLabel3];
    moneyLabel3.font = [UIFont systemFontOfSize:13];
    moneyLabel3.text = @"实付金额";
    moneyLabel3.textColor = kColor(0xB0B0B0);
    
    UILabel * moneyLabel4 = [UILabel new];
    moneyLabel4.frame = CGRectMake(kScreentWidth - 150, CGRectGetMinY(moneyLabel3.frame), kScreentWidth - 20, 64);
    [_buyView2 addSubview:moneyLabel4];
    moneyLabel4.font = [UIFont systemFontOfSize:15];
    moneyLabel4.text = @"8888元";
    moneyLabel4.textColor = kGlobalColor;
    
    // 分割线
    UIView * lineView4 = [UIView new];
    lineView4.frame = CGRectMake(0, CGRectGetMaxY(zhifubaoImageV.frame) - 1, kScreentWidth, 1);
    [_buyView2 addSubview:lineView4];
    lineView4.backgroundColor = kLineColor;

}

#pragma mark - 选择套餐
- (void)selectMealBtnClick:(UIButton *)sender {
    NSLog(@"selectMealBtnClick");
}

#pragma mark - 取消支付
- (void)backgroundBtnClick:(UIButton *)sender {
    _backgroundBtn.hidden = !_backgroundBtn.hidden;
    NSLog(@"backgroundBtnClick");
}

#pragma mark - 立即购买
- (void)buyBtnClick:(UIButton *)sender {
    NSLog(@"buyBtnClick");
    _backgroundBtn.hidden = NO;
}

- (void)buyBtnClick2:(UIButton *)sender {
    NSLog(@"buyBtnClick2");
    [_buyView1 removeFromSuperview];
    [_backgroundBtn addSubview:_buyView2];
}

- (void)buyBtnClick3:(UIButton *)sender {
    NSLog(@"buyBtnClick3");
    _backgroundBtn.hidden = !_backgroundBtn.hidden;
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
