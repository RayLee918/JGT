//
//  TeacherDetailViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "TeacherDetailViewController.h"
#import "DealCell.h"
#import "HomeCell.h"
#import "BuyViewController.h"
#import "FollowViewController.h"

@interface TeacherDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _dealView;
    UITableView * _overView;
    UIView * _descView;
    UIView * _hengtiao;
    UIButton * _selectedBtn;
    
    // 用户信息
    UIImageView * _headImageView;
    UILabel * _nameLabel;
    UIButton * _tagBtn;
    UIButton * _followBtn;
    UILabel * _descLabel;
    
    // 关注 粉丝 动态
    UILabel * _dynamicLabel;
    UILabel * _fansLabel;
    UILabel * _followLabel;
    
    UITextView * _descTextView;
    NSArray * _overViewDataSource;
}
@end

@implementation TeacherDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _overViewDataSource = [[NSArray alloc] init];
    
    // 初始页面
    [self initView];
    
    NSLog(@"userid - %@", self.userId);
    
    // 获取数据
    [self getTeacherData];
}

#pragma mark - 获取已完结课程
- (void)getOverViewDataSource {
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/overCourse", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"id":self.userId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"获取已完结课程 - %@", responseObject);
        
        _overViewDataSource = [responseObject objectForKey:kData];
        NSLog(@"%@", _overViewDataSource);
        
        // 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [_overView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取已完结课程 - error - %@", error);
    }];
}

#pragma mark - 获取数据
- (void)getTeacherData {
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/lectIndex", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"id":self.userId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", responseObject);
            NSDictionary * dic = [responseObject objectForKey:@"data"];
            
            [self setUserInfo:dic];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

- (void)setUserInfo:(NSDictionary *)dic {
    // 设置用户信息
    [_headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/downLoad/img?objKey=%@", kJGT, dic[@"lectPic"]]]];
    
    _nameLabel.text = dic[@"lectNickName"];
    _descLabel.text = dic[@"introduction"];
    
    // 标签
    [_tagBtn setTitle:dic[@"lecturerLevel"] forState:UIControlStateNormal];
    
    // 关注
    NSLog(@"isAttention - %@", dic[@"isAttention"]);
    if ([dic[@"isAttention"] isEqualToString:@"1"]) {
        
        [_followBtn setTitle:@"已关注" forState:UIControlStateNormal];
        //                _followBtn.userInteractionEnabled = NO;
    } else {
        [_followBtn setTitle:@"+关注" forState:UIControlStateNormal];
        //                _followBtn.userInteractionEnabled = YES;
    }
    
    // 关注, 粉丝, 动态
    _followLabel.text = dic[@"attentionNum"];
    _fansLabel.text = dic[@"subscriptionNum"];
    _dynamicLabel.text = dic[@"dynamicNum"];
    
    // 老师资料
    _descTextView.text = dic[@"introduction"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"导师主页";
}

- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 头像
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake(kMargin20, 15, 50, 50);
    [self.view addSubview:imageView];
    imageView.layer.cornerRadius = 25;
    imageView.layer.masksToBounds = YES;
    _headImageView = imageView;
    
    // 昵称
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMinX(imageView.frame), 100, 25);
    [self.view addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = kColor(0x1F1F1F);
//    nameLabel.text = @"马画藤";
    _nameLabel = nameLabel;
    
    // 标签
    UIButton * tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tagBtn.frame = CGRectMake(kScreentWidth - 20 - 40 - 5 - 40, CGRectGetMinX(imageView.frame) + (25 - 11.5) / 2, 40, 11.5);
    [self.view addSubview:tagBtn];
    [tagBtn setBackgroundColor:kGlobalColor];
//    [tagBtn setTitle:@"黄金老师" forState:UIControlStateNormal];
    [tagBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    tagBtn.layer.cornerRadius = 2.76;
    _tagBtn = tagBtn;
    
    // 关注
    UIButton * followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn.frame = CGRectMake(kScreentWidth - 20 - 40, CGRectGetMinY(tagBtn.frame), 40, 11.5);
    [self.view addSubview:followBtn];
    [followBtn setBackgroundColor:kGlobalColor];
//    [followBtn setTitle:@"+关注" forState:UIControlStateNormal];
    [followBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    followBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    followBtn.layer.cornerRadius = 2.76;
    [followBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _followBtn = followBtn;
    
    // 描述
    UILabel * descLabel = [UILabel new];
    descLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMaxY(nameLabel.frame), kScreentWidth - 20 * 3 - 50, 25);
    [self.view addSubview:descLabel];
    descLabel.font = [UIFont systemFontOfSize:11];
    descLabel.textColor = kColor(0x1F1F1F);
//    descLabel.text = @"连续蝉联股票收益冠军, 总收益达900%...";
    _descLabel = descLabel;
    
    // 分割线
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 15, kScreentWidth, 1);
    [self.view addSubview:lineView];
    lineView.backgroundColor = kColor(0xEFEFEF);
    
    // 关注
    UILabel * followLabel = [UILabel new];
    followLabel.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame) + 10, kScreentWidth / 3, 20);
    [self.view addSubview:followLabel];
    followLabel.font = [UIFont systemFontOfSize:14];
    followLabel.textColor = kColor(0x1F1F1F);
//    followLabel.text = @"500";
    followLabel.textAlignment = NSTextAlignmentCenter;
    _followLabel = followLabel;
    
    UILabel * followLabel2 = [UILabel new];
    followLabel2.frame = CGRectMake(0, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [self.view addSubview:followLabel2];
    followLabel2.font = [UIFont systemFontOfSize:14];
    followLabel2.textColor = kColor(0xB0B0B0);
    followLabel2.text = @"关注";
    followLabel2.textAlignment = NSTextAlignmentCenter;
    
    UIButton * followBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    followBtn2.frame = CGRectMake(CGRectGetMinX(followLabel.frame), CGRectGetMinY(followLabel.frame), followLabel.frame.size.width, followLabel.frame.size.height * 2);
    [self.view addSubview:followBtn2];
    [followBtn2 addTarget:self action:@selector(followBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
    
    // 分割线
    UIView * shutiao1 = [UIView new];
    shutiao1.frame = CGRectMake(kScreentWidth / 3, CGRectGetMinY(followLabel.frame), 1, 40);
    [self.view addSubview:shutiao1];
    shutiao1.backgroundColor = kColor(0xEFEFEF);
    
    // 粉丝
    UILabel * fansLabel = [UILabel new];
    fansLabel.frame = CGRectMake(kScreentWidth / 3, CGRectGetMaxY(lineView.frame) + 10, kScreentWidth / 3, 20);
    [self.view addSubview:fansLabel];
    fansLabel.font = [UIFont systemFontOfSize:14];
    fansLabel.textColor = kColor(0x1F1F1F);
//    fansLabel.text = @"12229";
    fansLabel.textAlignment = NSTextAlignmentCenter;
    _fansLabel = fansLabel;
    
    UILabel * fansLabel2 = [UILabel new];
    fansLabel2.frame = CGRectMake(kScreentWidth / 3, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [self.view addSubview:fansLabel2];
    fansLabel2.font = [UIFont systemFontOfSize:14];
    fansLabel2.textColor = kColor(0xB0B0B0);
    fansLabel2.text = @"粉丝";
    fansLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * shutiao2 = [UIView new];
    shutiao2.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMinY(followLabel.frame), 1, 40);
    [self.view addSubview:shutiao2];
    shutiao2.backgroundColor = kColor(0xEFEFEF);
    
    // 动态
    UILabel * dynamicLabel = [UILabel new];
    dynamicLabel.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMaxY(lineView.frame) + 10, kScreentWidth / 3, 20);
    [self.view addSubview:dynamicLabel];
    dynamicLabel.font = [UIFont systemFontOfSize:14];
    dynamicLabel.textColor = kColor(0x1F1F1F);
//    dynamicLabel.text = @"10";
    dynamicLabel.textAlignment = NSTextAlignmentCenter;
    _dynamicLabel = dynamicLabel;
    
    UILabel * dynamicLabel2 = [UILabel new];
    dynamicLabel2.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [self.view addSubview:dynamicLabel2];
    dynamicLabel2.font = [UIFont systemFontOfSize:14];
    dynamicLabel2.textColor = kColor(0xB0B0B0);
    dynamicLabel2.text = @"动态";
    dynamicLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * lineView2 = [UIView new];
    lineView2.frame = CGRectMake(0, CGRectGetMaxY(dynamicLabel2.frame) + 10, kScreentWidth, 2);
    [self.view addSubview:lineView2];
    lineView2.backgroundColor = kColor(0xEFEFEF);
    
    // 交易/分析
    UIButton * dealBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dealBtn.frame = CGRectMake(20, CGRectGetMaxY(lineView2.frame), 60, 30);
    [self.view addSubview:dealBtn];
    [dealBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
    dealBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [dealBtn setTitle:@"交易/分析" forState:UIControlStateNormal];
    [dealBtn addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    dealBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _selectedBtn = dealBtn;
    dealBtn.tag = 10;
    
    // 老师资料
    UIButton * descBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    descBtn.frame = CGRectMake(CGRectGetMaxX(dealBtn.frame), CGRectGetMaxY(lineView2.frame), 60, 30);
    [self.view addSubview:descBtn];
    [descBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    descBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [descBtn setTitle:@"老师资料" forState:UIControlStateNormal];
    [descBtn addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    descBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    descBtn.tag = 11;
    
    // 已完结
    UIButton * overBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    overBtn.frame = CGRectMake(CGRectGetMaxX(descBtn.frame), CGRectGetMaxY(lineView2.frame), 60, 30);
    [self.view addSubview:overBtn];
    [overBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    overBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [overBtn setTitle:@"已完结" forState:UIControlStateNormal];
    [overBtn addTarget:self action:@selector(dealBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    overBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    overBtn.tag = 12;
    
    // 分割线
//    UIView * lineView3 = [UIView new];
//    lineView3.frame = CGRectMake(0, CGRectGetMaxY(overBtn.frame), kScreentWidth, 2);
//    [self.view addSubview:lineView3];
//    lineView3.backgroundColor = kColor(0xEFEFEF);
    
    // 173
    _hengtiao = [UIView new];
    _hengtiao.frame = CGRectMake(CGRectGetMinX(dealBtn.frame), 173 - 2 - 1.5, 60, 1.5);
    [self.view addSubview:_hengtiao];
    _hengtiao.backgroundColor = kGlobalColor;
    
    [self overView];
    [self descView];
    [self dealView];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _overView) {
        
        return _overViewDataSource.count;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 20) {
        return 195;
    }
    return 145.5 + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 20) {
        static NSString * identifier = @"teacherDetail";
        DealCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[DealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.tittleDescLabel.text = @"产品交易A";
        cell.label1.text = @"A计划";
        cell.label2.text = @"产品介绍";
        cell.label3.text = @"100股币";
        cell.label4.text = @"近期建仓，预计收益金额在10%欢迎广大股民进行投顾。";
        
        cell.tittleDescLabel.text = @"产品交易B";
        cell.label5.text = @"B计划";
        cell.label6.text = @"产品介绍";
        cell.label7.text = @"100股币";
        cell.label8.text = @"近期建仓，预计收益金额在10%欢迎广大股民进行投顾。";
        
        return cell;
    }
    static NSString * identifier = @"cell";
    
    HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // 设置cell的属性
//    cell.icon.image = [UIImage imageNamed:@"icon.png"];
//    cell.nickNameLbl.text = @"股票的刘老师";
//    cell.dateLbl.text = @"30分钟前";
//    cell.contentLbl.text = @"我正在进行VIP直播，主题为【被立即数实战课】";
    
    NSLog(@"cell - %@", _overViewDataSource);
    cell.icon.image = _headImageView.image;
    cell.nickNameLbl.text = _nameLabel.text;
    NSString * overStr = [NSString stringWithFormat:@"%@ - 已完结", _overViewDataSource[indexPath.row][@"courseName"]];
    cell.contentLbl.text = overStr;
    NSInteger dateI= [_overViewDataSource[indexPath.row][@"cts"] integerValue] / 1000;
//    NSDate * date = [NSDate dateWithTimeIntervalSince1970:dateI];
//    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSString * dateStr = [formatter stringFromDate:date];
    cell.dateLbl.text = [self dateConvert:[NSString stringWithFormat:@"%ld", dateI]];

    
    cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
    cell.firstLabel.text = @"订购即刻观看直播";
    
    NSString * str = @"并享受全部VIP课程";
    UIColor * color = kColor(0xFF615E);
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - 5, 5)];
    [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
    cell.secondLabel.attributedText = mStr;
    
    // 立即订购
    [cell.orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.orderBtn.tag = 100 + indexPath.row;
    
    return cell;
}

- (void)orderBtnClick:(UIButton *)sender {
    BuyViewController * buyVC = [BuyViewController new];
    [self.navigationController pushViewController:buyVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BuyViewController * buyVC = [BuyViewController new];
    [self.navigationController pushViewController:buyVC animated:YES];
}

#pragma mark - 时间转换
- (NSString *)dateConvert:(NSString *)dateadd
{
    NSDate * date = [NSDate date];
    int timeInterval = [date timeIntervalSince1970];
    int dateAdd = [dateadd intValue];
    int differ = timeInterval - dateAdd;
    NSString * dateString = nil;
    
    if (differ > 0 && differ < 60)
    {
        dateString = @"刚刚";
    }
    else if (differ >= 60 && differ < 3600)
    {
        dateString = [NSString stringWithFormat:@"%d分钟前", differ/60];
    }
    else if (differ >= 3600 && differ < 3600*24)
    {
        dateString = [NSString stringWithFormat:@"%d小时前", differ/3600];
    }
    else if(differ >= 3600*24 && differ < 3600*48)
    {
        dateString = @"昨天";
    }
    else
    {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateadd doubleValue]];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        dateString = [formatter stringFromDate:date];
    }
    return dateString;
}

#pragma mark - 交易分析页
- (void)dealView {
    CGRect frame = CGRectMake(0, 175, kScreentWidth, kScreentHeight - 175 - kTabbarHeight - kMargin64);
    _dealView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_dealView];
    _dealView.dataSource = self;
    _dealView.delegate = self;
    _dealView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dealView.tag = 20;
}

#pragma mark - 老师资料页
- (void)descView {
    _descView = [UIView new];
    _descView.frame = CGRectMake(0, 175, kScreentWidth, kScreentHeight - 175 - kTabbarHeight - kMargin64);
    [self.view addSubview:_descView];
    _descView.backgroundColor = kWhiteColor;
    
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake(20 - 5, 175 + 15, 1.5, 15);
    [self.view addSubview:imageView];
    imageView.backgroundColor = kGlobalColor;
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(20, 15, kScreentWidth - 30, 15);
    [_descView addSubview:label];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"老师介绍";
    
    UITextView * tv = [UITextView new];
    tv.frame = CGRectMake(20, 35, kScreentWidth - 40, _descView.frame.size.height - 45 - 20);
    [_descView addSubview:tv];
    tv.font = [UIFont systemFontOfSize:12];
    tv.userInteractionEnabled = NO;
    _descTextView = tv;
//    tv.text = @"连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务，并用开放、透明、协作的互联网思维，不断改进传统的投资体验。";
}

#pragma mark - 已完结页
- (void)overView {
    CGRect frame = CGRectMake(0, 175, kScreentWidth, kScreentHeight - 175 - kTabbarHeight - kMargin64);
    _overView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:_overView];
    _overView.dataSource = self;
    _overView.delegate = self;
    _overView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _overView.tag = 21;
}

#pragma mark - 交易/分析, 老师资料, 已完结
- (void)dealBtnClick:(UIButton *)sender {
    NSLog(@"dealBtnClick");
    _hengtiao.frame = CGRectMake(CGRectGetMinX(sender.frame), 175 - 2 - 1.5, 60, 1.5);
    [_selectedBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    [sender setTitleColor:kGlobalColor forState:UIControlStateNormal];
    _selectedBtn = sender;
    
    if (sender.tag == 10) {
        [self.view bringSubviewToFront:_dealView];
    } else if (sender.tag == 11) {
        [self.view bringSubviewToFront:_descView];
    } else {
        [self getOverViewDataSource];
        [self.view bringSubviewToFront:_overView];
    }
}

#pragma mark - 关注按钮
- (void)followBtnClick:(UIButton *)sender {
    NSLog(@"followBtnClick");
    
    if ([sender.titleLabel.text isEqualToString:@"已关注"]) {
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"确定要取消关注吗?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
            NSString * urlStr = [NSString stringWithFormat:@"%@/user/attention/operAttention", kJGT];
            [manager GET:urlStr parameters:@{@"id":self.userId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@", responseObject);
                if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
                    [sender setTitle:@"+关注" forState:UIControlStateNormal];
                } else {
                    [self showAlert:[responseObject objectForKey:kMsg]];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error - %@", error);
            }];
        }]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"不" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        }]];
        [self presentViewController:alertC animated:YES completion:nil];
    
    } else {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        NSString * urlStr = [NSString stringWithFormat:@"%@/user/attention/operAttention", kJGT];
        [manager GET:urlStr parameters:@{@"id":self.userId} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            NSLog(@"%@", [responseObject objectForKey:@"status"]);
            if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
                [sender setTitle:@"已关注" forState:UIControlStateNormal];
            } else {
                [self showAlert:[responseObject objectForKey:kMsg]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error - %@", error);
        }];
    }
}

- (void)showAlert:(NSString *)msg {
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)followBtn2Click:(UIButton *)sender {
    FollowViewController * followVC = [FollowViewController new];
    [self.navigationController pushViewController:followVC animated:YES];
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
