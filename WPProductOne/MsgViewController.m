//
//  MsgViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/14.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgCell.h"

@interface MsgViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataSource;
}
@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = @[@{@"title":@"aaaa", @"desc":@"内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。"}, @{@"title":@"bbb", @"desc":@"内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。"}];
    [self initView];
    [self getMsgData];
}

#pragma mark - 获取数据
- (void)getMsgData {
    NSString * msgUrlStr = [NSString stringWithFormat:@"%@", kJGT];
    [[AFHTTPSessionManager manager] GET:msgUrlStr parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dataSource = [responseObject objectForKey:kData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"最新消息";
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    CGRect frame = CGRectMake(0, 20, kScreentWidth, kScreentHeight - kNavgationBarHeight - kTabbarHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kClearColor;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.userInteractionEnabled = NO;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel * label = [UILabel new];
    label.numberOfLines = 0;
    label.frame = CGRectMake(5, 20, kScreentWidth - 30 - 20, 90);
    label.font = [UIFont systemFontOfSize:15];
    label.text = _dataSource[indexPath.row][@"desc"];
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    NSLog(@"%@", NSStringFromCGSize(size));
    return 70 + 10 + size.height + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifer = @"msg";
    MsgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[MsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor = kClearColor;
    NSDictionary * dic = _dataSource[indexPath.row];
    cell.datetimeLabel.text = @"2017-09-17 08:12:00";
    cell.nameLabel.text = dic[@"title"];
    cell.descLabel.text = dic[@"desc"];
    
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
