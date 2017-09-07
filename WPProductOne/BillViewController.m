//
//  BillViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "BillViewController.h"
#import "BillCell.h"

@interface BillViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataSource;
}
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _dataSource = @[@{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"-5200", @"desc":@"购买萨达所VIP课程"},
                    @{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"+800", @"desc":@"提现交易-快速到帐"},
                    @{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"-688", @"desc":@"购买马芸讲师VIP课程"},
                    @{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"-26", @"desc":@"购买萨达所VIP课程"},
                    @{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"-68", @"desc":@"购买刘旺讲师VIP课程"},
                    @{@"date":@"今天", @"time":@"12:12", @"cardImage":@"card1.png", @"money":@"+266", @"desc":@"马化腾-转帐"}
                      ];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"帐单记录";
}

- (void)initView {
    
    // 本月
    UIButton * thisMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thisMonthBtn.frame = CGRectMake(20, 0, kScreentWidth / 2 - 20, 44);
    [self.view addSubview:thisMonthBtn];
    [thisMonthBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    thisMonthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    thisMonthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [thisMonthBtn setTitle:@"本月" forState:UIControlStateNormal];
    
    // 查看月帐单
    UIButton * historyMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyMonthBtn.frame = CGRectMake(kScreentWidth / 2, 0, kScreentWidth / 2 - 20, 44);
    [self.view addSubview:historyMonthBtn];
    [historyMonthBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    historyMonthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    historyMonthBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [historyMonthBtn setTitle:@"查看月帐单" forState:UIControlStateNormal];
    [historyMonthBtn addTarget:self action:@selector(historyMonthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 列表展示
    CGRect frame = CGRectMake(0, kNavgationBarHeight, kScreentWidth, kScreentHeight - kMargin64 - kNavgationBarHeight - kTabbarHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.backgroundColor = kGreenColor;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"bill";
    BillCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary * dic = _dataSource[indexPath.row];
    cell.dateLabel.text = dic[@"date"];
    cell.timeLabel.text = dic[@"time"];
    cell.moneyLabel.text = dic[@"money"];
    cell.descLabel.text = dic[@"desc"];
    
    return cell;
}
#pragma mark - 查看月帐单
- (void)historyMonthBtnClick:(UIButton *)sender {
    NSLog(@"historyMonthBtnClick");
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
