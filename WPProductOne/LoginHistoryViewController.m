//
//  LoginHistoryViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "LoginHistoryViewController.h"
#import "LoginHistoryCell.h"

@interface LoginHistoryViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataSource1;
    NSArray * _dataSource2;
}
@end

@implementation LoginHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource1 = @[@"FRD-AL10", @"SAMSUNG 0921", @"iPhone 7", @"华为 H2981"];
    _dataSource2 = @[@"5月21日 12:12 FRD", @"5月21日 12:12 SAMSUNG", @"5月21日 12:12 iPhone", @"5月21日 12:12 华为"];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"登录记录";
}

#pragma mark - 自定义视图
- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"login";
    LoginHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LoginHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    
    cell.firstLabel.text = _dataSource1[indexPath.row];
    cell.secondLabel.text = _dataSource2[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
