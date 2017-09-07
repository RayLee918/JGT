//
//  RemarkViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/25.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "RemarkViewController.h"

@interface RemarkViewController ()

@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"服务协议";
}

- (void)initView {
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreentWidth, kScreentHeight - kBatteryHeight - kTabbarHeight - kNavgationBarHeight)];
    [self.view addSubview:webView];
    webView.backgroundColor = kWhiteColor;
    webView.opaque = NO;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/views/html/userAgreement.html", kJGT];
    NSLog(@"urlStr - %@", urlStr);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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
