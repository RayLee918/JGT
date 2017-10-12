//
//  MsgViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/14.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgCell.h"
#import "HomeCell.h"
#import "FollowCell.h"
#import "ReadViewController.h"
#import "TeacherDetailViewController.h"

@interface MsgViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _orderTableView;
    UITableView * _msgTableView;
    UITableView * _attentionTableView;
    
    NSArray * _orderDataSource;
    NSArray * _msgDataSource;
    NSArray * _attentionDataSource;
    
    UIButton * _orderBtn;
    UIButton * _msgBtn;
    UIButton * _attentionBtn;
}
@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"msg - viewDidLoad -- ");
    // 初始三个视图
    [self initMsgView];
    [self initAttentionView];
    [self initOrderView];
    [self initView];
    
    // 初始三个数据源
    [self getOrderData];
//    [self getMsgData];
//    [self getAttentionData];
}

#pragma mark - 请求我的订单数据
- (void)getOrderData {
    
//    NSString * urlStr = [NSString stringWithFormat:@"%@/center/user/getSubscriptionList", kJGT];

    NSString * urlStr = [NSString stringWithFormat:@"%@/center/user/orderList", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"orderData - %@", responseObject);
        if ([CLTool isHaveData:responseObject]) {
            
            _orderDataSource = [responseObject objectForKey:kData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_orderTableView reloadData];
            });
        } else {
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

#pragma mark - 获取数据
- (void)getMsgData {
//    _msgDataSource = @[@{@"title":@"aaaa", @"desc":@"内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。"}, @{@"title":@"bbb", @"desc":@"内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。"}];
    NSString * msgUrlStr = [NSString stringWithFormat:@"%@/center/user/msgList", kJGT];
    [[AFHTTPSessionManager manager] GET:msgUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"msgdata - %@", responseObject);
        if ([CLTool isHaveData:responseObject]) {
            
            _msgDataSource = [responseObject objectForKey:kData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_msgTableView reloadData];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)getAttentionData {
    NSString * msgUrlStr = [NSString stringWithFormat:@"%@/center/user/getLectList", kJGT];
    [[AFHTTPSessionManager manager] GET:msgUrlStr parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([CLTool isHaveData:responseObject]) {
            NSLog(@"attentionData - %@", responseObject);
            
            _attentionDataSource = [responseObject objectForKey:kData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_attentionTableView reloadData];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"attention - %@", error);
    }];
}

- (void)initView {
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIButton * orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(0, 0, kScreentWidth / 3, 44);
    [self.view addSubview:orderBtn];
    [orderBtn setTitle:@"我的订单" forState:UIControlStateNormal];
    [orderBtn setTitleColor:kColor(0x4A4A4A) forState:UIControlStateNormal];
    [orderBtn setTitleColor:kColor(0xB9020D) forState:UIControlStateSelected];
    [orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.selected = YES;
    _orderBtn = orderBtn;
    
    UIButton * msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(kScreentWidth / 3, 0, kScreentWidth / 3, 44);
    [self.view addSubview:msgBtn];
    [msgBtn setTitle:@"消息中心" forState:UIControlStateNormal];
    [msgBtn setTitleColor:kColor(0x4A4A4A) forState:UIControlStateNormal];
    [msgBtn setTitleColor:kColor(0xB9020D) forState:UIControlStateSelected];
    [msgBtn addTarget:self action:@selector(msgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _msgBtn = msgBtn;
    
    UIButton * attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn.frame = CGRectMake(kScreentWidth / 3 * 2, 0, kScreentWidth / 3, 44);
    [self.view addSubview:attentionBtn];
    [attentionBtn setTitle:@"关注导师" forState:UIControlStateNormal];
    [attentionBtn setTitleColor:kColor(0x4A4A4A) forState:UIControlStateNormal];
    [attentionBtn setTitleColor:kColor(0xB9020D) forState:UIControlStateSelected];
    [attentionBtn addTarget:self action:@selector(attentionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _attentionBtn = attentionBtn;
}

- (void)orderBtnClick:(UIButton *)sender {
    _msgBtn.selected = NO;
    _attentionBtn.selected = NO;
    _orderBtn.selected = YES;
    [self.view bringSubviewToFront:_orderTableView];
}

- (void)msgBtnClick:(UIButton *)sender {
    _msgBtn.selected = YES;
    _attentionBtn.selected = NO;
    _orderBtn.selected = NO;
    [self.view bringSubviewToFront:_msgTableView];
}

- (void)attentionBtnClick:(UIButton *)sender {
    _msgBtn.selected = NO;
    _attentionBtn.selected = YES;
    _orderBtn.selected = NO;
    [self.view bringSubviewToFront:_attentionTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"我的订单";
}

- (void)initOrderView {
    
    CGRect frame = CGRectMake(0, 44, kScreentWidth, kScreentHeight - kBatteryHeight - kNavgationBarHeight - kTabbarHeight - 44);
    _orderTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _orderTableView.dataSource = self;
    _orderTableView.delegate = self;
    _orderTableView.backgroundColor = kWhiteColor;
    _orderTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_orderTableView];
}

- (void)initMsgView {
    CGRect frame = CGRectMake(0, 44, kScreentWidth, kScreentHeight - kBatteryHeight - kNavgationBarHeight - kTabbarHeight - 44);
    _msgTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _msgTableView.dataSource = self;
    _msgTableView.delegate = self;
    _msgTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _msgTableView.userInteractionEnabled = NO;
    _msgTableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.view addSubview:_msgTableView];
}

- (void)initAttentionView {
    CGRect frame = CGRectMake(0, 44, kScreentWidth, kScreentHeight - kBatteryHeight - kNavgationBarHeight - kTabbarHeight - 44);
    _attentionTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _attentionTableView.dataSource = self;
    _attentionTableView.delegate = self;
    _attentionTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _attentionTableView.backgroundColor = kWhiteColor;
    [self.view addSubview:_attentionTableView];

}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _orderTableView) {
        return _orderDataSource.count;
    } else if (tableView == _msgTableView) {
        return _msgDataSource.count;
    } else if (tableView == _attentionTableView) {
        return _attentionDataSource.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _orderTableView) {
        return 150.5;
    } else if (tableView == _msgTableView) {
        UILabel * label = [UILabel new];
        label.numberOfLines = 0;
        label.frame = CGRectMake(5, 20, kScreentWidth - 30 - 20, 90);
        label.font = [UIFont systemFontOfSize:15];
        label.text = _msgDataSource[indexPath.row][@"desc"];
        CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
        return 70 + 10 + size.height + 15;
    } else if (tableView == _attentionTableView) {
        return 60;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _orderTableView) {
        static NSString * identifer = @"order";
        HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        
        NSDictionary * dic = _orderDataSource[indexPath.row];
        NSString * imgStr = [NSString stringWithFormat:@"%@%@", kJGTGetImage, dic[@"headPic"]];
        [cell.icon setImageWithURL:[NSURL URLWithString:imgStr]];
        
        if (![dic[@"lectName"] isEqual:[NSNull null]]) {
            
            cell.nickNameLbl.text = dic[@"lectName"];
        }
        NSInteger dateInt = [dic[@"cts"] integerValue] / 1000;
        cell.dateLbl.text = [CLTool dateConvert:[NSString stringWithFormat:@"%ld", dateInt]];
        
        cell.contentLbl.text = dic[@"courseName"];
        
        cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
        cell.firstLabel.text = @"订购即刻观看直播";
        
        NSString * str = @"并享受全部VIP课程";
        UIColor * color = kColor(0xFF615E);
        NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
        [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(mStr.length - 5, 5)];
        [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
        cell.secondLabel.attributedText = mStr;
    
        cell.orderLabel.text = @"阅读文档";
        
        return cell;
    } else if (tableView == _msgTableView) {
        static NSString * identifer = @"msg";
        MsgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[MsgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.backgroundColor = kClearColor;
        NSDictionary * dic = _msgDataSource[indexPath.row];
        cell.datetimeLabel.text = dic[@"ctsStr"];
        cell.nameLabel.text = dic[@"atitle"];
        cell.descLabel.text = dic[@"content"];
        return cell;
    } else if (tableView == _attentionTableView) {
        static NSString * identifer = @"attention";
        FollowCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell = [[FollowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        NSDictionary * dic = _attentionDataSource[indexPath.row];
        [cell.icon setImageWithURL:[NSURL URLWithString:dic[@"lectPic"]]];
        cell.nickNameLbl.text = dic[@"lectName"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _orderTableView) {
        ReadViewController * readVC = [ReadViewController new];
        NSDictionary * dic = _orderDataSource[indexPath.row];
        if (![dic[@"courseDoc"] isEqual:[NSNull null]]) {
            readVC.courseName = dic[@"courseName"];
            readVC.courseDoc = [NSString stringWithFormat:@"%@/downLoad/download?fileid=%@", kJGT, dic[@"courseDoc"]];
            [self.navigationController pushViewController:readVC animated:YES];
        } else {
            [CLTool showAlert:@"还没有上传该课程" target:self];
        }
    } else if (tableView == _attentionTableView) {
        TeacherDetailViewController * teacherDetailVC = [[TeacherDetailViewController alloc] init];
        teacherDetailVC.userId = _attentionDataSource[indexPath.row][@"lecturerId"];
        [self.navigationController pushViewController:teacherDetailVC animated:YES];
    }
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
