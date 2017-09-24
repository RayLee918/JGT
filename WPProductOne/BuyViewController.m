//
//  BuyViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController () <WXApiDelegate>
{
    UIButton * _backgroundBtn;
    UIView * _buyView1;
    UIView * _buyView2;
    NSMutableArray * _priceBtnArray;
    UILabel * _moneyLabel2;
    UILabel * _moneyLabel4;
    NSArray * _priceArray;
    UIButton * _weixinBtn;
    UIButton * _zhifubaoBtn;
    NSString * _payMethod;
}
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _payMethod = @"";
    [self initView];
    
//    _priceArray = @[@{@"month":@"1个月", @"price":@"1"}, @{@"month":@"2个月", @"price":@"2"}, @{@"month":@"3个月", @"price":@"3"}, @{@"month":@"4个月", @"price":@"4"}];
//    [self initBuyView1];
    [self initBuyViwe2];
    
    [self getCourseInfo];
}

- (void)getCourseInfo {
    
    _moneyLabel4.text = [NSString stringWithFormat:@"%@元", self.price];
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
    [CLTool gradualBackgroundColor:buyBtn];
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
    
    // 背景
    _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backgroundBtn.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight);
    [self.view addSubview:_backgroundBtn];
    _backgroundBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [_backgroundBtn addTarget:self action:@selector(backgroundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _backgroundBtn.hidden = YES;
    
}

- (void)initBuyView1 {
    
    _buyView1 = [UIView new];
    CGFloat height = 44 * 4 + (64 + 15) * 2;
    _buyView1.frame = CGRectMake(0, CGRectGetMaxY(_backgroundBtn.frame) - height - 49 - 64, kScreentWidth, height);
    _buyView1.backgroundColor = kWhiteColor;
    
    
    UIButton * buyBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn2.frame = CGRectMake(0, _buyView1.frame.size.height - 44, kScreentWidth, 44);
    [_buyView1 addSubview:buyBtn2];
    buyBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn2 setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn2 setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
//    [buyBtn2 addTarget:self action:@selector(buyBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    
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
    selectLabel.frame = CGRectMake(20, 44, kScreentWidth - 40, 44);
    [_buyView1 addSubview:selectLabel];
    selectLabel.font = [UIFont systemFontOfSize:15];
    selectLabel.textColor = kColor(0xB0B0B0);
    selectLabel.text = @"请选择让你购买的课程";
    
    // 价钱
    _priceBtnArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 4; i++) {
        
        CGFloat width = (kScreentWidth - 45) / 2;
        CGFloat x = 15 + (width + 15) * (i % 2);
        CGFloat y = 88 + (64 + 15) * (i / 2);
        
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(x, y + 12, width, 20);
        [_buyView1 addSubview:label];
        label.text = [NSString stringWithFormat:@"%@元", _priceArray[i][@"price"]];
        label.textColor = kColor(0x1F1F1F);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel * label2 = [UILabel new];
        label2.frame = CGRectMake(x, y + 12 + 20, width, 20);
        [_buyView1 addSubview:label2];
        label2.text = _priceArray[i][@"month"];
        label2.textColor = kColor(0xB0B0B0);
        label2.font = [UIFont systemFontOfSize:10];
        label2.textAlignment = NSTextAlignmentCenter;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, 64);
        [_buyView1 addSubview:btn];
        btn.layer.borderColor = kColor(0xFF4F53).CGColor;
        btn.layer.borderWidth = 1;
        [btn addTarget:self action:@selector(selectMealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10 + i;
        [_priceBtnArray addObject:btn];
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
    moneyLabel2.text = @"元";
    moneyLabel2.textColor = kGlobalColor;
    _moneyLabel2 = moneyLabel2;
}

- (void)initBuyViwe2 {
    // 第二个购买页面
    _buyView2 = [UIView new];
    CGFloat height2 = 44 * 5;
    _buyView2.frame = CGRectMake(0, CGRectGetMaxY(_backgroundBtn.frame) - height2 - kMargin64 - kTabbarHeight, kScreentWidth, height2);
    _buyView2.backgroundColor = kWhiteColor;
    [_backgroundBtn addSubview:_buyView2];
    
    UIButton * buyBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn3.frame = CGRectMake(0, _buyView2.frame.size.height - 44, kScreentWidth, 44);
    [CLTool gradualBackgroundColor:buyBtn3];
    [_buyView2 addSubview:buyBtn3];
    buyBtn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyBtn3 setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn3 addTarget:self action:@selector(buyBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(10, 10, 27, 27);
//    [_buyView2 addSubview:backBtn];
//    [backBtn setImage:kImageNamed(@"back.png") forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    weixinImageV.frame = CGRectMake(7, CGRectGetMaxY(titleLabel2.frame) + 7, 30, 30);
    [_buyView2 addSubview:weixinImageV];
//    weixinImageV.backgroundColor = kGlobalColor;
    weixinImageV.image = kImageNamed(@"weixin.png");
    
    UILabel * weixinLabel = [UILabel new];
    weixinLabel.frame = CGRectMake(54, CGRectGetMaxY(titleLabel2.frame), kScreentWidth - 88, 44);
    [_buyView2 addSubview:weixinLabel];
    weixinLabel.font = [UIFont systemFontOfSize:12];
    weixinLabel.text = @"微信支付";
    
    UIButton * weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weixinBtn.frame = CGRectMake(0, CGRectGetMinY(weixinLabel.frame), kScreentWidth, 44);
    [_buyView2 addSubview:weixinBtn];
    [weixinBtn addTarget:self action:@selector(weixinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    weixinBtn.layer.borderColor = kGlobalColor.CGColor;
    _weixinBtn = weixinBtn;
    
    // 分割线
    UIView * lineView3 = [UIView new];
    lineView3.frame = CGRectMake(0, CGRectGetMaxY(weixinLabel.frame) - 1, kScreentWidth, 1);
    [_buyView2 addSubview:lineView3];
    lineView3.backgroundColor = kLineColor;
    
    // 支付宝支付
    UIImageView * zhifubaoImageV = [UIImageView new];
    zhifubaoImageV.frame = CGRectMake(7, CGRectGetMaxY(weixinLabel.frame) + 7, 30, 30);
    [_buyView2 addSubview:zhifubaoImageV];
//    zhifubaoImageV.backgroundColor = kGlobalColor;
    zhifubaoImageV.image = kImageNamed(@"zhifubao.png");
    
    UILabel * zhifubaoLabel = [UILabel new];
    zhifubaoLabel.frame = CGRectMake(54, CGRectGetMaxY(weixinLabel.frame), kScreentWidth - 88, 44);
    [_buyView2 addSubview:zhifubaoLabel];
    zhifubaoLabel.font = [UIFont systemFontOfSize:12];
    zhifubaoLabel.text = @"支付宝支付";
    
    UIButton * zhifubaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zhifubaoBtn.frame = CGRectMake(0, CGRectGetMinY(zhifubaoLabel.frame), kScreentWidth, 44);
    [_buyView2 addSubview:zhifubaoBtn];
    [zhifubaoBtn addTarget:self action:@selector(zhifubaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    zhifubaoBtn.layer.borderColor = kGlobalColor.CGColor;
    _zhifubaoBtn = zhifubaoBtn;
    
    UILabel * moneyLabel3 = [UILabel new];
    moneyLabel3.frame = CGRectMake(20, CGRectGetMaxY(zhifubaoLabel.frame), kScreentWidth - 20, 44);
    [_buyView2 addSubview:moneyLabel3];
    moneyLabel3.font = [UIFont systemFontOfSize:13];
    moneyLabel3.text = @"实付金额";
    moneyLabel3.textColor = kColor(0xB0B0B0);
    
    UILabel * moneyLabel4 = [UILabel new];
    moneyLabel4.frame = CGRectMake(kScreentWidth - 150, CGRectGetMinY(moneyLabel3.frame), kScreentWidth - 20, 44);
    [_buyView2 addSubview:moneyLabel4];
    moneyLabel4.font = [UIFont systemFontOfSize:15];
    moneyLabel4.textColor = kGlobalColor;
    _moneyLabel4 = moneyLabel4;
    
    // 分割线
    UIView * lineView4 = [UIView new];
    lineView4.frame = CGRectMake(0, CGRectGetMaxY(zhifubaoLabel.frame) - 1, kScreentWidth, 1);
    [_buyView2 addSubview:lineView4];
    lineView4.backgroundColor = kLineColor;
}

/*
#pragma mark - 返回选择套餐
- (void)backBtnClick:(UIButton *)sender {
    NSLog(@"backBtn...");
    [self.view addSubview:_buyView1];
}
*/
 
#pragma mark - 选择支付方式
- (void)weixinBtnClick:(UIButton *)sender {
    NSLog(@"weixinBtnClick");
    _zhifubaoBtn.layer.borderWidth = 0;
    _weixinBtn.layer.borderWidth = 2;
    _payMethod = @"weixin";
}

- (void)zhifubaoBtnClick:(UIButton *)sender {
    NSLog(@"zhifubaoBtnClick");
    
    _weixinBtn.layer.borderWidth = 0;
    _zhifubaoBtn.layer.borderWidth = 2;
    _payMethod = @"zhifubao";
}

#pragma mark - 选择套餐
/*
- (void)selectMealBtnClick:(UIButton *)sender {
    NSLog(@"selectMealBtnClick");
    
    for (UIButton * btn in _priceBtnArray) {
        btn.layer.borderWidth = 1;
    }
    
    sender.layer.borderWidth = 2;
    _moneyLabel2.text = [NSString stringWithFormat:@"%@元", _priceArray[sender.tag-10][@"price"]];
}
*/

#pragma mark - 取消支付
- (void)backgroundBtnClick:(UIButton *)sender {
    _backgroundBtn.hidden = YES;
    NSLog(@"backgroundBtnClick");
}

#pragma mark - 立即购买1
- (void)buyBtnClick:(UIButton *)sender {
    _backgroundBtn.hidden = NO;
}

/*
- (void)buyBtnClick:(UIButton *)sender {
    if (![self.courseName isEqual:[NSNull null]]) {
        NSLog(@"null != nil");
        if ([self isFileExist:self.courseName]) {
            NSLog(@"buyBtnClick - 1");
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            NSString *filePath = [path stringByAppendingPathComponent:self.courseName];
            [self loadDocument:filePath];
        } else {
            NSLog(@"buyBtnClick - 2");
            _backgroundBtn.hidden = NO;
        }
    } else {
        NSLog(@"null = nil");
        [CLTool showAlert:@"还没有上传该文档" target:self];
    }
}
*/

#pragma mark - 立即购买3
- (void)buyBtnClick3:(UIButton *)sender {
    NSLog(@"buyBtnClick3");
    
    if ([_payMethod isEqualToString:@"weixin"]) {
        _backgroundBtn.hidden = YES;
        NSLog(@"weixin zhifu");
        [self payMethod:_payMethod];
        
    } else if ([_payMethod isEqualToString:@"zhifubao"]) {
        _backgroundBtn.hidden = YES;
        NSLog(@"zhifubao zhifu");
        [self payMethod:_payMethod];
        
    } else {
        [CLTool showAlert:@"请选择支付方式" target:self];
    }
}

#pragma mark - 发起支付请求
- (void)payMethod:(NSString *)payMethod {
    NSString * str = [NSString stringWithFormat:@"%@/order/creatOrder", kJGT];
    [[AFHTTPSessionManager manager] GET:str parameters:@{@"courseId":self.courseId, @"payType":@"weixin"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                if ([payMethod isEqualToString:@"weixin"]) {
                    NSDictionary * dic = [responseObject objectForKey:kData];
                    PayReq * request = [[PayReq alloc] init];
                    request.partnerId = dic[@"partnerId"];
                    request.prepayId = dic[@"prepayId"];
                    request.package = dic[@"package"];
                    request.nonceStr = dic[@"nonceStr"];
                    request.timeStamp = [dic[@"timeStamp"] intValue];
                    request.sign = dic[@"sign"];
                    
                    // 发起微信支付请求
                    BOOL isSuccessSendReq = [WXApi sendReq:request];
                    NSLog(@"isSuccessSendReq - %d", isSuccessSendReq);
                } else if ([payMethod isEqualToString:@"zhifubao"]) {
                    
                    [[AlipaySDK defaultService] payOrder:[responseObject objectForKey:kData] fromScheme:@"WPProductOneAlipay" callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        /*
                         // 调用支付宝返回的信息
                         reslut = {
                         memo = "";
                         result = "";
                         resultStatus = 6001;
                         }
                         */
                        
                        // 支付成功
                        if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                            NSLog(@"zhifubao - buy - 支付成功");
                            [CLTool showAlert:@"课程购买成功" target:self];
                        } else {
                            NSLog(@"zhifubao - buy - 支付失败");
                            [CLTool showAlert:@"支付失败" target:self];
                        }
                    }];
                    
                } else {
                    [CLTool showAlert:@"不支持的支付方式" target:self];
                }
        } else {
            [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 微信支付回调
-(void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp * response=(PayResp *)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"weixin - buy - 支付成功, %@", resp);
                [CLTool showAlert:@"课程购买成功" target:self];
                break;
            default:
                NSLog(@"weixin - buy - 支付失败, %@, retcode=%d", resp, resp.errCode);
                [CLTool showAlert:@"支付失败" target:self];
                break;
        }
    }
}

/*
#pragma mark - 支付宝支付
- (void)zhifubaoPay {
    NSString * str = [NSString stringWithFormat:@"%@/order/creatOrder", kJGT];
    [[AFHTTPSessionManager manager] GET:str parameters:@{@"courseId":self.courseId, @"payType":@"zhifubao"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"zhifubaopay - %@", responseObject);
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            [[AlipaySDK defaultService] payOrder:[responseObject objectForKey:kData] fromScheme:@"WPProductOneAlipay" callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
 
                 // 调用支付宝返回的信息
                 // reslut = {
                 //    memo = "";
                 //    result = "";
                 //    resultStatus = 6001;
                 // }
 
                // 支付成功
                if ((1)) {
                    // 下载文档
                    [self paySuccess];
                } else {
                    [CLTool showAlert:@"支付失败" target:self];
                }
            }];
        } else {
            [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
*/

#pragma mark - 下载文档, 打开文档
- (void)paySuccess {
    NSString * str = [NSString stringWithFormat:@"%@/order/payOrder", kJGT];
    NSDictionary * user = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    NSString * userId = user[kUserID];
    NSDictionary * params = @{@"courseId":self.courseId, @"payType":@"zhifubao", kUserID:userId, @"item":@""};
    NSLog(@"zhifubao - sucess - %@", params);
    [[AFHTTPSessionManager manager] GET:str parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    [self downloadFile:self.courseName];
}

/*
#pragma mark - 立即购买2
- (void)buyBtnClick2:(UIButton *)sender {
    NSLog(@"buyBtnClick2");
    [_buyView1 removeFromSuperview];
    [_backgroundBtn addSubview:_buyView2];
    _moneyLabel4.text = [NSString stringWithFormat:@"%@元", _priceArray[sender.tag-10][@"price"]];
}
*/

#pragma mark - 支付字符串拼接
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

#pragma mark - 下载的文档处理
//下载文件
- (void)downloadFile:(NSString *)downLoadUrl{
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.131:8080/jgt/downLoad/download?fileid=%@", self.courseName]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask * task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress - - %lld, %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:self.courseName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self loadDocument:filePath.relativePath];
    }];
    [task resume];
}

// 下载文件或者打开文件
- (void)downloadPDF:(NSString *)downloadUrl {
    NSArray * arr = [downloadUrl componentsSeparatedByString:@"="];
    NSString * fileName = [arr lastObject];
    if ([self isFileExist:fileName]) {
        NSLog(@"存在");
        //获取Documents 下的文件路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        [self loadDocument:filePath];
    } else {
        NSLog(@"不存在");
        [self downloadFile:downloadUrl];
    }
}


// 下载好的文件用UIWebView显示
-(void)loadDocument:(NSString *)documentName
{
    NSLog(@"loadDocument - %@", documentName);
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight)];
    webView.backgroundColor = kWhiteColor;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL fileURLWithPath:documentName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

// 判断沙盒中是还存在此文件
-(BOOL) isFileExist:(NSString *)fileName
{
    //获取Documents 下的文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL result = [fileManager fileExistsAtPath:filePath];
    
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    
    return result;
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
