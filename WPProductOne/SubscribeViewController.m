//
//  SubscribeViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeCell.h"

@interface SubscribeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
}
@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"订阅";
}

- (void)initView {
    
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kMargin64);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145.5 + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"subscribe";
    SubscribeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SubscribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // 设置cell的属性
    cell.icon.image = [UIImage imageNamed:@"icon.png"];
    cell.nickNameLbl.text = @"股票的刘老师";
    cell.dateLbl.text = @"30分钟前";
    cell.contentLbl.text = @"我正在进行VIP直播，主题为【被立即数实战课】";
    cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
    cell.firstLabel.text = @"订购即刻观看直播";
    
    NSString * str = @"并享受全部VIP课程";
    UIColor * color = kColor(0xFF615E);
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - 5, 5)];
    [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
    cell.secondLabel.attributedText = mStr;
    
    return cell;
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
