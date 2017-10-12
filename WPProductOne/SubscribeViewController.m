//
//  SubscribeViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "SubscribeViewController.h"
#import "SubscribeCell.h"
#import "BuyViewController.h"
#import "ReadViewController.h"

@interface SubscribeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataSource;
}
@end

@implementation SubscribeViewController

#pragma mark - 获取已订阅课程
- (void)getSubscribeData {
    NSString * urlStr = [NSString stringWithFormat:@"%@/center/user/getSubscriptionList", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"subscribe - %@", responseObject);
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            
            _dataSource = [responseObject objectForKey:kData];

            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        } else {
            [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取已订阅课程 - error - %@", error);
    }];
}

- (void)viewDidLoad {
    NSLog(@"sub - userid - %@", self.userId);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = @[];
    [self initView];
    [self getSubscribeData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"订阅";
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
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
    return _dataSource.count;
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
//    cell.icon.image = [UIImage imageNamed:@"icon.png"];
//    cell.nickNameLbl.text = @"股票的刘老师";
//    cell.dateLbl.text = @"30分钟前";
//    cell.contentLbl.text = @"我正在进行VIP直播，主题为【被立即数实战课】";
//    cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
//    cell.firstLabel.text = @"订购即刻观看直播";
//    
//    NSString * str = @"并享受全部VIP课程";
//    UIColor * color = kColor(0xFF615E);
//    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
//    [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - 5, 5)];
//    [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
//    cell.secondLabel.attributedText = mStr;
    
    // 设置cell的属性
    NSDictionary * dic = _dataSource[indexPath.row];
    NSString * imgStr = [NSString stringWithFormat:@"%@%@", kJGTGetImage, dic[@"headPic"]];
    [cell.icon setImageWithURL:[NSURL URLWithString:imgStr]];

    cell.nickNameLbl.text = dic[@"lectName"];
    NSString * overStr = [NSString stringWithFormat:@"%@ - 已完结", _dataSource[indexPath.row][@"courseName"]];
    cell.contentLbl.text = overStr;
    NSInteger dateI= [_dataSource[indexPath.row][@"cts"] integerValue] / 1000;
    cell.dateLbl.text = [CLTool dateConvert:[NSString stringWithFormat:@"%ld", dateI]];
    
    cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
    cell.firstLabel.text = @"订购即刻观看直播";
    
    NSString * str = @"并享受全部VIP课程";
    UIColor * color = kColor(0xFF615E);
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - 5, 5)];
    [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
    cell.secondLabel.attributedText = mStr;
    
    cell.orderLabel.text = @"阅读文档";
    
    // 立即订购
//    [cell.orderBtn setTitle:@"观看文档" forState:UIControlStateNormal];
//    [cell.orderBtn addTarget:self action:@selector(loadDocument:) forControlEvents:UIControlEventTouchUpInside];
//    cell.orderBtn.tag = 100 + indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ReadViewController * readVC = [ReadViewController new];
    NSDictionary * dic = _dataSource[indexPath.row];
    if (![dic[@"courseDoc"] isEqual:[NSNull null]]) {
        readVC.courseName = dic[@"courseName"];
        readVC.courseDoc = [NSString stringWithFormat:@"%@/downLoad/download?fileid=%@", kJGT, dic[@"courseDoc"]];
        [self.navigationController pushViewController:readVC animated:YES];
    } else {
        [CLTool showAlert:@"还没有上传该课程" target:self];
    }}

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
