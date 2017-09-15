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

- (void)getBuyData {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"课程购买";
}

- (void)initView {
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreentWidth, kScreentHeight - kBatteryHeight - kTabbarHeight - kNavgationBarHeight)];
    [self.view addSubview:webView];
    webView.backgroundColor = kWhiteColor;
    webView.opaque = NO;
    NSString * urlStr = [NSString stringWithFormat:@"%@/views/html/CourseInfo.html?id=%@", kJGT, self.courseId];
    NSLog(@"urlStr - %@", urlStr);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    UILabel * label = [UILabel new];
    NSLog(@"font - %@", label.font);
    
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(0, kScreentHeight - kMargin64 - kTabbarHeight - 44, kScreentWidth, 44);
    [self.view addSubview:buyBtn];
//    buyBtn.backgroundColor = kGlobalColor;
    [buyBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 特别提示
//    UILabel * label1 = [UILabel new];
//    label1.frame = CGRectMake(0, CGRectGetMinY(buyBtn.frame) - 10 - 44, kScreentWidth, 22);
//    [self.view addSubview:label1];
//    label1.textColor = kColor(0x9B9B9B);
//    label1.textAlignment = NSTextAlignmentCenter;
//    label1.font = [UIFont systemFontOfSize:10];
//    NSString * str1 = @"点击确认支付代表同意《VIP课程购买》并已阅读《风险提示》";
//    
//    NSRange range1 = [str1 rangeOfString:@"《VIP课程购买》"];
//    NSRange range2 = [str1 rangeOfString:@"《风险提示》"];
//    NSMutableAttributedString * mStr1 = [[NSMutableAttributedString alloc] initWithString:str1];
//    [mStr1 addAttribute:NSForegroundColorAttributeName value:kColor(0x4990E2) range:range1];
//    [mStr1 addAttribute:NSForegroundColorAttributeName value:kColor(0x4990E2) range:range2];
//    label1.attributedText = mStr1;
    
//    UILabel * label2 = [UILabel new];
//    label2.frame = CGRectMake(0, CGRectGetMinY(buyBtn.frame) - 10 - 22, kScreentWidth, 22);
//    [self.view addSubview:label2];
//    label2.textColor = kColor(0x9B9B9B);
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.font = [UIFont systemFontOfSize:10];
//    label2.text = @"VIP课程均为荐股厅有限公司提供";
    
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

#pragma mark - 调走支付请求
- (void)buyBtnClick3:(UIButton *)sender {
    NSLog(@"buyBtnClick3");
    _backgroundBtn.hidden = !_backgroundBtn.hidden;
    [self doAlipayPay];
}
     
- (void)doAlipayPay
{
    //重要说明
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    /*=======================需要填写商户app申请的===================================*/
    NSString *appID = kAlipayAppID;
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = kAlipayPrivateKey;
    NSString *rsaPrivateKey = @"";
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
        //                                                        message:@"缺少appId或者私钥。"
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"确定"
        //                                              otherButtonTitles:nil];
        //        [alert show];
        
        // 更新代码
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"缺少appId或者私钥." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"WPProductOneAlipay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
