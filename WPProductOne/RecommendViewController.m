//
//  RecommendViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "RecommendViewController.h"
#import "HomeCell.h"
#import "TeacherCell.h"
#import "CalendarViewController.h"
#import "SearchViewController.h"
#import "CCCycleScrollView.h"
#import "CalendarController.h"

// 模块引入
#import "StockViewController.h"
#import "FundViewController.h"
#import "MetalViewController.h"
#import "ForeignViewController.h"
#import "AnalyzeViewController.h"
#import "BondViewController.h"
#import "CounselorViewController.h"
#import "MoreViewController.h"

// 详情界面
#import "HomeDetailViewController.h"
#import "TeacherDetailViewController.h"

#import "BuyViewController.h"

@interface RecommendViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CCCycleScrollViewClickActionDeleage>
{
    // 列表展示
    UITableView * _tableView;
    UITableView * _teacherTableView;
    NSArray * _homeDataSource;
    NSArray * _teacherDataSource;
    NSMutableArray * _sortBtnArr;
    
    UIPageControl * _pageControl;
    UIPageControl * _secondPageControl;
    
    // 白条
    UIImageView * _baitiao;
    
    CGPoint _baitiaoCenten1;
    CGPoint _baitiaoCenten2;
    
    //
    UIScrollView * _scrollView;
    
    // 排序
    BOOL _upSortAll;
    BOOL _upSortPrice;
    
    NSTimer * _timer;
    
    // 模块开发
    NSMutableArray * _moduleBtnArr;
    NSMutableArray * _moduleBtnTitleArr;
    NSMutableArray * _moduleBtnLabelArr;

    // 标题
    UILabel * _titleLabel;
    NSArray * _titleArray;
    
    NSIndexPath * _indexPaht;
}
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.//    self.view.backgroundColor = [UIColor colorWithRed:(((0xFF4F53 & 0xFF0000) >> 16))/255.0 green:(((0xFF4F53 &0xFF00) >>8))/255.0 blue:((0xFF4F53 &0xFF))/255.0 alpha:1.0];
    _homeDataSource = [NSArray array];
    _teacherDataSource = [NSArray array];
    _moduleBtnArr = [NSMutableArray arrayWithCapacity:0];
    _moduleBtnTitleArr = [NSMutableArray arrayWithCapacity:0];
    _moduleBtnLabelArr = [NSMutableArray arrayWithCapacity:0];
    _sortBtnArr = [NSMutableArray arrayWithCapacity:0];
    [self getHomeNewsData];
    [self getTeacherData];
    
    // 初始视图
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initView];
    });
    [self getModuleData];
    NSLog(@"home - viewDidLoad");
}

#pragma mark - 模块按钮动态数据
- (void)getModuleData {
    
    // 最新消息滚动
    _titleArray = @[@"李**同学购买了课程", @"张**同学购买了课程", @"赵**同学购买了课程"];
    NSString * urlStr = [NSString stringWithFormat:@"%@/home/getCategoryList", kJGT];
    [[AFHTTPSessionManager manager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            _moduleBtnTitleArr = [NSMutableArray arrayWithArray:[responseObject objectForKey:kData]];
            
            self.customVC.moduleBtnTitleArr = _moduleBtnTitleArr;
            NSInteger value = 0;
            if (_moduleBtnLabelArr.count >=8) {
                value = 8;
            } else {
                value = _moduleBtnLabelArr.count;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新列表
                for (NSInteger i = 0; i < value; i++) {
                    UILabel * label = _moduleBtnLabelArr[i];
                    NSDictionary * dic = _moduleBtnTitleArr[i];
                    label.text = dic[@"cateName"];
                }
                
                // 更新标题
                if (_titleArray.count >= 1) {
                    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
                    [timer fire];
                }
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [CLTool showAlert:@"获取数据失败" target:self];
    }];
}

- (void)updateTitle {
    unsigned int index = arc4random() % _titleArray.count;
    _titleLabel.text = _titleArray[index];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 资讯刷新频率
    NSInteger value = [[[NSUserDefaults standardUserDefaults] valueForKey:@"refreshRate"] integerValue];
    if (value == 0) {
        value = 300;
    }
//    _timer = [NSTimer scheduledTimerWithTimeInterval:value target:self selector:@selector(getHomeNewsData) userInfo:nil repeats:YES];
}

- (void)hello {
    NSLog(@"home - pinlv - ");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"home - viewWillAppear");
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    if (_baitiao.frame.origin.x < (kScreentWidth / 2)) {
        [self homeBtnClick:nil];
    } else {
        [self teacherBtnClick:nil];
    }
}

// 在需要进行获取登录信息的UIViewController中加入如下代码
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

#pragma mark 请求首页数据, 刷新数据
- (void)getHomeNewsData {
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/home/newestState", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            NSLog(@"homedata - %@", responseObject);
            _homeDataSource = [responseObject objectForKey:kData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

#pragma mark - 请求首页讲师数据, 刷新界面
- (void)getTeacherData {
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/findAll", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"type":@"all", @"state":@"down"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            
            _teacherDataSource = [responseObject objectForKey:kData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_teacherTableView reloadData];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

#pragma mark - 初始视图
- (void)initView {
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;

    // 自动调整
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.navigationController.navigationBar.translucent = NO;
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 自定义导航栏
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenRect.size.width, kBatteryHeight + kNavgationBarHeight)];
    [self.view addSubview:navView];
    [CLTool gradualBackgroundColor:navView];
    
    // 首页
    UILabel * homeLabel = [[UILabel alloc] init];
    homeLabel.text = @"首页";
    homeLabel.textColor = [UIColor whiteColor];
    homeLabel.textAlignment = NSTextAlignmentCenter;
    homeLabel.font = [UIFont fontWithName:@".PingFang-SC-Regular" size:17];
    CGFloat x = kScreenRect.size.width / 2 - kMargin10 - kHomeBtnWidth;
    homeLabel.frame = CGRectMake(x, kBatteryHeight + kMargin5, kHomeBtnWidth, kHomeBtnHeight);
    [navView addSubview:homeLabel];
//    homeLabel.backgroundColor = kRedColor;
    
    UIButton * homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeBtn setFrame:homeLabel.frame];
    [homeBtn setBackgroundColor:[UIColor clearColor]];
    [homeBtn addTarget:self action:@selector(homeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:homeBtn];
    
    _baitiao = [[UIImageView alloc] init];
    _baitiao.image = [UIImage imageNamed:@"baitiao.png"];
    CGFloat baitiaoY = CGRectGetMaxY(homeBtn.frame);
    _baitiao.frame = CGRectMake(0, 0, 30, 2);
    _baitiao.center = CGPointMake(homeBtn.center.x, baitiaoY);
    [navView addSubview:_baitiao];
    _baitiaoCenten1 = _baitiao.center;

    // 讲师
    UILabel * teacherLabel = [[UILabel alloc] init];
    teacherLabel.text = @"讲师";
    teacherLabel.textColor = [UIColor whiteColor];
    teacherLabel.textAlignment = NSTextAlignmentCenter;
    teacherLabel.font = [UIFont fontWithName:@".PingFang-SC-Regular" size:17];
    CGFloat teacherX = kScreenRect.size.width / 2 + kMargin10;
    teacherLabel.frame = CGRectMake(teacherX, kBatteryHeight + kMargin5, kHomeBtnWidth, kHomeBtnHeight);
    [navView addSubview:teacherLabel];
//    teacherLabel.backgroundColor = kGreenColor;
    
    UIButton * teacherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teacherBtn setFrame:teacherLabel.frame];
    [teacherBtn setBackgroundColor:[UIColor clearColor]];
    [teacherBtn addTarget:self action:@selector(teacherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:teacherBtn];
    
    _baitiaoCenten2 = CGPointMake(teacherBtn.center.x, CGRectGetMaxY(homeBtn.frame));
    
    // 日历
    UIButton * calendarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat calendarBtnY = navView.frame.size.height - 44;
    calendarBtn.frame = CGRectMake(0, calendarBtnY, 44, 44);
    [calendarBtn setImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
    [calendarBtn addTarget:self action:@selector(calendarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [navView addSubview:calendarBtn];
    
    // 搜索
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(kScreenRect.size.width - 44, 20, 44, 44);
    [searchBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:searchBtn];
    
    // ------------------- 首页, 讲师两个页面 -------------------
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, kNavgationBarHeight + kBatteryHeight, kScreentWidth, kScreentHeight - kNavgationBarHeight - kTabbarHeight - kBatteryHeight);
    _scrollView.contentSize = CGSizeMake(kScreentWidth, _scrollView.frame.size.height);
//    _scrollView.backgroundColor = kBlueColor;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    // ------------------- 2. 首页展示  -------------------
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kBatteryHeight + kNavgationBarHeight, kScreenRect.size.width, kScreenRect.size.height - kTabbarHeight - kBatteryHeight - kNavgationBarHeight)  style:UITableViewStylePlain];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, kScreentWidth, _scrollView.frame.size.height);
    [_scrollView addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tag = 31;
    
    // ------------------- 3. 讲师展示 -------------------
    // 排序按钮
    /*
     25B2=▲
     25B3=△
     25BA=►
     25BC=▼
     25C4=◄
     */
    
    /*
    UIButton * sortAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortAllBtn.frame = CGRectMake(kScreentWidth, 0, kScreentWidth/2, 32);
    [_scrollView addSubview:sortAllBtn];
    sortAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortAllBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    [sortAllBtn setTitle:@"综合排序\u25bc" forState:UIControlStateNormal];
    [sortAllBtn addTarget:self action:@selector(sortAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _upSortAll = YES;
    
    UIButton * sortPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortPriceBtn.frame = CGRectMake(kScreentWidth/2*3, 0, kScreentWidth/2, 32);
    [_scrollView addSubview:sortPriceBtn];
    sortPriceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortPriceBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
    [sortPriceBtn setTitle:@"价格排序\u25bc" forState:UIControlStateNormal];
    [sortPriceBtn addTarget:self action:@selector(sortPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _upSortPrice = YES;
    */
    
    // ------------------- 四种排序 -------------------
    // 1. 最新加入 2. 关注人数 3. 交易指数 4. 下载指数
    NSArray * titles = @[@"最新加入\u25bc", @"关注人数\u25bc", @"交易指数\u25bc", @"下载指数\u25bc"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton * sortAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sortAllBtn.frame = CGRectMake(kScreentWidth + i * (kScreentWidth / 4), 0, kScreentWidth/4, 32);
        [_scrollView addSubview:sortAllBtn];
        sortAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sortAllBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
        [sortAllBtn setTitle:titles[i] forState:UIControlStateNormal];
        [sortAllBtn addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        sortAllBtn.tag = 100 + i;
        [_sortBtnArr addObject:sortAllBtn];
    }
    
    // 讲师展示列表
    self.teacherTableView = [[UITableView alloc] init];
    self.teacherTableView.frame = CGRectMake(kScreentWidth, 32, kScreentWidth, _scrollView.frame.size.height-32);
    [_scrollView addSubview:self.teacherTableView];
    self.teacherTableView.dataSource = self;
    self.teacherTableView.delegate = self;
    self.teacherTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.teacherTableView.tag = 32;

    // 列表头
    UIView * headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, kScreenRect.size.width, 550);
//    headerView.backgroundColor = kBlueColor;
    self.tableView.tableHeaderView = headerView;
    
    // (1)第一个转播图
//    UIScrollView * scrollView = [[UIScrollView alloc] init];
//    scrollView.frame = CGRectMake(0, 0, kScreentWidth, 180);
//    scrollView.contentSize = CGSizeMake(kScreentWidth * 4, 180);
//    scrollView.bounces = NO;
//    scrollView.pagingEnabled = YES;
//    scrollView.delegate = self;
//    scrollView.tag = 21;
    
    
    // 隐藏左右滑动进度显示
//    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.backgroundColor = kRedColor;
//    [headerView addSubview:scrollView];
    
//    _pageControl = [[UIPageControl alloc] init];
//    _pageControl.frame = CGRectMake(kScreentWidth - 10 - 60, scrollView.frame.size.height - 5 - 10, 60, 10);
//    _pageControl.numberOfPages = 4;
//    _pageControl.currentPage = 0;
    
    // 添加内容
//    for (int i = 0; i < 4; i++) {
//        UIImageView * imageView = [[UIImageView alloc] init];
//        CGFloat x = i * kScreentWidth;
//        imageView.frame = CGRectMake(x, 0, kScreentWidth, 180);
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"scroll%d.png", i]];
//        [scrollView addSubview:imageView];
//    }
    
//    [headerView addSubview:_pageControl];
    
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 4; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"scroll%ld.png",(long)(i-1)]];
        [images addObject:image];
    }
    
    CCCycleScrollView * scrollView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, kScreentWidth, 180)];
    scrollView.pageLocation = CCCycleScrollPageViewPositionBottomRight;
    scrollView.delegate = self;
    [headerView addSubview:scrollView];
    
    // (2) 九宫格模块展示
    NSArray * moduleImages = @[@"stock.png", @"fund.png", @"metal.png", @"foreign.png", @"analyze.png", @"bond.png", @"counselor.png", @"more.png"];
//    NSArray * moduleTitles = @[@"股票", @"基金", @"贵金属", @"外汇", @"分析", @"债券", @"顾问", @"更多"];
    for (int i = 0; i < 8; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 40 + i;
        CGFloat margin = (kScreentWidth - kMargin30 * 2 - 40 * 4) / 3;
        CGFloat x = 30 + (i % 4) * (40 + margin);
        CGFloat y = 20 + (i / 4) * (40 + kMargin40) + CGRectGetMaxY(scrollView.frame);
        btn.frame = CGRectMake(x, y, 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:moduleImages[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moduleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btn];
        [_moduleBtnArr addObject:btn];
        
        UILabel * label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kTextColor;
        CGFloat labelX = (i % 4) * (kScreentWidth / 4);
        CGFloat labelY = CGRectGetMaxY(btn.frame);
        label.frame = CGRectMake(labelX, labelY, kScreentWidth / 4, 40);
//        label.text = moduleTitles[i];
        [headerView addSubview:label];
        [_moduleBtnLabelArr addObject:label];
    }
    
    // (3) 横幅
    UIView * streamerView = [[UIView alloc] init];
    streamerView.frame = CGRectMake(0, CGRectGetMaxY(scrollView.frame) + 190, kScreentWidth, 35);
//    streamerView.backgroundColor = kBlueColor;
    [headerView addSubview:streamerView];
    
    /*
    // 7*24h
    UILabel * firstlabel = [[UILabel alloc] init];
    firstlabel.frame = CGRectMake(15, 0, 40, 35);
    firstlabel.font = [UIFont systemFontOfSize:12.5];
    firstlabel.textColor = [UIColor colorWithRed:(((0x0 & 0xFF0000) >> 16))/255.0 green:(((0x0 &0xFF00) >>8))/255.0 blue:((0x0 &0xFF))/255.0 alpha:1.0];
    firstlabel.text = @"7x24h";
    [streamerView addSubview:firstlabel];
    
    // 资讯
    UILabel * secondLabel = [[UILabel alloc] init];
    secondLabel.frame = CGRectMake(CGRectGetMaxX(firstlabel.frame), 0, 40, 35);
    secondLabel.font = [UIFont systemFontOfSize:12.5];
    secondLabel.textColor = [UIColor colorWithRed:(((0xFF4F53 & 0xFF0000) >> 16))/255.0 green:(((0xFF4F53 &0xFF00) >>8))/255.0 blue:((0xFF4F53 &0xFF))/255.0 alpha:1.0];
    secondLabel.text = @"资讯";
    [streamerView addSubview:secondLabel];
    
    // 图片
    UILabel * lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(CGRectGetMaxX(secondLabel.frame), (35 - 27) / 2, 1, 27);
    lineLabel.backgroundColor = [UIColor colorWithRed:(((0xD8D8D8 & 0xFF0000) >> 16))/255.0 green:(((0xD8D8D8 &0xFF00) >>8))/255.0 blue:((0xD8D8D8 &0xFF))/255.0 alpha:1.0];
    [streamerView addSubview:lineLabel];
    */
    
    // 标题
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(15, 0, kScreentWidth - 30, 35);
//    titleLabel.text = @"刘强栋分析师昨日分析腾讯控股(00700)";
    titleLabel.textColor = kColor(0x4A4A4A);
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [streamerView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    // (4)第二个轮播图
//    UIScrollView * secondScrollView = [[UIScrollView alloc] init];
//    secondScrollView.frame = CGRectMake(0, 225 + CGRectGetMaxY(scrollView.frame), kScreentWidth, 100);
//    secondScrollView.contentSize = CGSizeMake(kScreentWidth * 3, 100);
//    secondScrollView.bounces = NO;
//    secondScrollView.pagingEnabled = YES;
//    secondScrollView.delegate = self;
//    secondScrollView.tag = 22;
    
    // 隐藏左右滑动进度显示
    //    scrollView.showsHorizontalScrollIndicator = NO;
//    secondScrollView.backgroundColor = kRedColor;
//    [headerView addSubview:secondScrollView];
    
//    _secondPageControl = [[UIPageControl alloc] init];
//    _secondPageControl.frame = CGRectMake(kScreentWidth - 10 - 40, CGRectGetMaxY(secondScrollView.frame) - 5 - 10, 40, 10);
//    _secondPageControl.numberOfPages = 3;
//    _secondPageControl.currentPage = 0;
    
    // 添加内容
//    for (int i = 0; i < 3; i++) {
//        UIImageView * imageView = [[UIImageView alloc] init];
//        CGFloat x = i * kScreentWidth;
//        imageView.frame = CGRectMake(x, 0, kScreentWidth, 100);
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"scroll%d.png", i]];
//        [secondScrollView addSubview:imageView];
//    }
//    
//    [headerView addSubview:_secondPageControl];
    
    NSMutableArray *images2 = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 3; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"scroll%ld.png",(long)(i-1)]];
        [images2 addObject:image];
    }
    
    CCCycleScrollView * secondScrollView = [[CCCycleScrollView alloc]initWithImages:images2 withFrame:CGRectMake(0, 225 + CGRectGetMaxY(scrollView.frame), kScreentWidth, 100)];
    secondScrollView.pageLocation = CCCycleScrollPageViewPositionBottomRight;
    secondScrollView.delegate = self;
    [headerView addSubview:secondScrollView];
    
    // (5)最新动态
    UILabel * dynamicLabel = [[UILabel alloc] init];
    dynamicLabel.frame = CGRectMake(32, CGRectGetMaxY(secondScrollView.frame), kScreentWidth, 40);
    dynamicLabel.text = @"最新动态";
    [headerView addSubview:dynamicLabel];
    
    UIImageView * dynamicImageView = [[UIImageView alloc] init];
    dynamicImageView.frame = CGRectMake(15, CGRectGetMinY(dynamicLabel.frame) + 10, 2, 20);
    dynamicImageView.image = [UIImage imageNamed:@"shutiao.png"];
    [headerView addSubview:dynamicImageView];
    
    //    self.tableView.tableHeaderView = navView;
    //    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.tableView.backgroundColor = [UIColor whiteColor];
    
    headerView.frame = CGRectMake(headerView.frame.origin.x, headerView.frame.origin.y, headerView.frame.size.width, CGRectGetMaxY(dynamicLabel.frame));
//    headerView.backgroundColor = kRedColor;
}

#pragma mark - CCCycleScrollViewDelegate
- (void)cyclePageClickAction:(NSInteger)clickIndex {
    NSLog(@"cyclePageClickAction - %ld", clickIndex);
}

#pragma mark - 四种排序按钮响应事件
- (void)sortBtnClick:(UIButton *)sender {
    for (UIButton * btn in _sortBtnArr) {
        if (btn.tag == sender.tag) {
            [btn setTitleColor:kGlobalColor forState:UIControlStateNormal];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/findAll", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"type":[NSString stringWithFormat:@"%ld", sender.tag - 100]} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _teacherDataSource = [responseObject objectForKey:kData];
        NSLog(@"teacherDataSource - %ld", _teacherDataSource.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_teacherTableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

/*
#pragma mark- 排序按钮响应事件
- (void)sortAllBtnClick:(UIButton *)sender {
    _upSortAll = !_upSortAll;
    NSString * sortStr = @"";
    if (_upSortAll) {
        [sender setTitle:@"综合排序\u25BC" forState:UIControlStateNormal];
        sortStr = @"up";
    }
    else {
        [sender setTitle:@"综合排序\u25B2" forState:UIControlStateNormal];
        sortStr = @"down";
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/findAll", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"type":@"all", @"state":sortStr} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _teacherDataSource = [responseObject objectForKey:kData];
//        NSLog(@"teacherData - %@", _homeDataSource);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_teacherTableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
    
    NSLog(@"sortAllBtnClick - %d", _upSortAll);
}

- (void)sortPriceBtnClick:(UIButton *)sender {
    _upSortPrice = !_upSortPrice;
    NSString * sortStr = @"";
    if (_upSortPrice ) {
        [sender setTitle:@"价格排序\u25BC" forState:UIControlStateNormal];
        sortStr = @"all";
    }
    else {
        [sender setTitle:@"价格排序\u25B2" forState:UIControlStateNormal];
        sortStr = @"price";
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/lecturer/findAll", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"type":@"price", @"state":sortStr} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _teacherDataSource = [responseObject objectForKey:kData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_teacherTableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];

    
    NSLog(@"sortPriceBtnClick - %d", _upSortPrice);
}
*/

#pragma mark - 首页按钮响应事件
- (void)homeBtnClick:(UIButton *)sender {
    NSLog(@"homeBtnClick");
    _baitiao.center = _baitiaoCenten1;
    
    _scrollView.contentOffset = CGPointMake(0, 0);
    NSLog(@"%@", NSStringFromCGPoint(_scrollView.contentOffset));

}

#pragma mark - 讲师按钮响应事件
- (void)teacherBtnClick:(UIButton *)sender {
    NSLog(@"teacherBtnClick");
    _baitiao.center = _baitiaoCenten2;
    
    _scrollView.contentOffset = CGPointMake(kScreentWidth, 0);
    NSLog(@"%@", NSStringFromCGPoint(_scrollView.contentOffset));
}

#pragma mark - 模块按钮点击事件
- (void)moduleBtnClick:(UIButton *)sender {
    NSLog(@"moduleBtnClick");
        
    [self.rootVC tagBtnClick:self.rootVC.tabbarBtns[1]];
//    self.customVC.selectedIndex = sender.tag - 40;
//    [self.customVC updateDataSource:sender.tag - 40];

//    [self.customVC btnClick:self.customVC.moduleBtns[sender.tag - 40]];

//    if (sender.tag == 40) {
//        StockViewController * stockVC = [StockViewController new];
//        [self.navigationController pushViewController:stockVC animated:YES];
//    } else if (sender.tag == 41) {
//        FundViewController * fundVC = [FundViewController new];
//        [self.navigationController pushViewController:fundVC animated:YES];
//    } else if (sender.tag == 42) {
//        MetalViewController * metalVC = [MetalViewController new];
//        [self.navigationController pushViewController:metalVC animated:YES];
//    } else if (sender.tag == 43) {
//        ForeignViewController * foreignVC = [ForeignViewController new];
//        [self.navigationController pushViewController:foreignVC animated:YES];
//    } else if (sender.tag == 44) {
//        AnalyzeViewController * analyzeVC = [AnalyzeViewController new];
//        [self.navigationController pushViewController:analyzeVC animated:YES];
//    } else if (sender.tag == 45) {
//        BondViewController * bondVC = [BondViewController new];
//        [self.navigationController pushViewController:bondVC animated:YES];
//    } else if (sender.tag == 46) {
//        CounselorViewController * counselorVC = [CounselorViewController new];
//        [self.navigationController pushViewController:counselorVC animated:YES];
//    } else if (sender.tag == 47) {
//        MoreViewController * moreVC = [MoreViewController new];
//        [self.navigationController pushViewController:moreVC animated:YES];
//    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == 21) {
        NSInteger current = scrollView.contentOffset.x / kScreentWidth;
        _pageControl.currentPage = current;
    }else {
        NSInteger current = scrollView.contentOffset.x / kScreentWidth;
        _secondPageControl.currentPage = current;
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 31) {
        if ([_homeDataSource respondsToSelector:@selector(count)]) {
            
            return _homeDataSource.count;
        }
        return 0;
    }
    return _teacherDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 31) {
        
        static NSString * identifier = @"cell";
        
        HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        // 设置cell的属性
//        cell.icon.image = [UIImage imageNamed:@"icon.png"];
//        cell.nickNameLbl.text = @"股票的刘老师";
//        cell.dateLbl.text = @"30分钟前";
//        cell.contentLbl.text = @"我正在进行VIP直播，主题为【被立即数实战课】";
        NSDictionary * dic = _homeDataSource[indexPath.row];
        NSString * imgStr = [NSString stringWithFormat:@"%@%@", kJGTGetImage, dic[@"headPic"]];
        [cell.icon setImageWithURL:[NSURL URLWithString:imgStr]];
        cell.nickNameLbl.text = dic[@"lectName"];
        NSInteger dateInt = [dic[@"cts"] integerValue] / 1000;
        cell.dateLbl.text = [self dateConvert:[NSString stringWithFormat:@"%ld", dateInt]];
        
        cell.contentLbl.text = dic[@"courseName"];
        
        cell.vipImageView.image = [UIImage imageNamed:@"vip1.png"];
        cell.firstLabel.text = @"订购即刻观看直播";
        
        NSString * str = @"并享受全部VIP课程";
        UIColor * color = kColor(0xFF615E);
        NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
        [mStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(str.length - 5, 5)];
        [mStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.5] range:NSMakeRange(str.length - 5, 5)];
        cell.secondLabel.attributedText = mStr;
    
        cell.orderLabel.text = @"立即订购";
        
        return cell;
    }   else if (tableView.tag == 32) {
        
        static NSString * identifier2 = @"teacher";
        
        TeacherCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[TeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        // 设置cell的属性
        cell.icon.image = [UIImage imageNamed:@"mask.png"];
    
//        cell.nickNameLbl.text = @"马化腾";
//        [cell.tagBtn1 setTitle:@"基金分析" forState:UIControlStateNormal];
//        [cell.tagBtn2 setTitle:@"私人理财" forState:UIControlStateNormal];
//        cell.descLbl.text = @"理财专家，毕业于加拿大Ascenda商学院，国际金融学院，案例营利高达100之多。";
//        cell.followLabel.text = @"关注人数: 1886人";
//        cell.downloadLabel.text = @"交易指数: 98%";
//        cell.dealLabel.text = @"下载指数: 5.0分";
//        cell.stateLabel.text = @"在线";
        NSDictionary * dic = _teacherDataSource[indexPath.row];
        cell.nickNameLbl.text = dic[@"lectName"];
        [cell.tagBtn1 setTitle:dic[@"tag1"] forState:UIControlStateNormal];
        [cell.tagBtn2 setTitle:dic[@"tag2"] forState:UIControlStateNormal];
        cell.descLbl.text = dic[@"introduction"];
        cell.followLabel.text = [NSString stringWithFormat:@"关注人数: %@人", dic[@"attentionNum"]];
        cell.downloadLabel.text = [NSString stringWithFormat:@"下载指数: %@", dic[@"downPoint"]];
        cell.dealLabel.text = [NSString stringWithFormat:@"交易指数: %@分", dic[@"trin"]];
        
        // 在线忙碌
        cell.stateLabel.text = dic[@"lectState"];
        if ([dic[@"lectState"] isEqualToString:@"在线"]) {
            cell.stateLabel.textColor = kColor(0x4990E2);
        }
        else {
            cell.stateLabel.textColor = kGlobalColor;
        }
        
        return cell;
    }

    return nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 31) {
        return 145.5 + 5;
    }
    
    return kMargin5 * 2 + 127;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 31) {
        NSLog(@"homeCell - didSelect -  %ld", indexPath.row);
        BuyViewController * buyVC = [BuyViewController new];
        buyVC.courseId = _homeDataSource[indexPath.row][@"courseId"];
        buyVC.price = _homeDataSource[indexPath.row][@"price"];
        buyVC.courseName = _homeDataSource[indexPath.row][@"courseDoc"];
        [self.navigationController pushViewController:buyVC animated:YES];
    }
    else {
        NSLog(@"teacherCell - didSelect -  %ld", indexPath.row);
        TeacherDetailViewController * teacherDetailVC = [[TeacherDetailViewController alloc] init];
        teacherDetailVC.userId = _teacherDataSource[indexPath.row][@"lecturerId"];
        [self.navigationController pushViewController:teacherDetailVC animated:YES];
    }
}

- (void)orderBtnClick {
    
}

#pragma mark - 日历事件
- (void)calendarBtnClick:(UIButton *)sender {
    NSLog(@"calendarBtnClick");
//    CalendarViewController * calendarVC = [CalendarViewController new];
//    [self.navigationController pushViewController:calendarVC animated:YES];
//    CalendarController * calendarVC = [CalendarController new];
//    [self.navigationController pushViewController:calendarVC animated:YES];
    
    // 聊天管理类
//     [[NIMSDK sharedSDK] chatManager];
    
}

- (void)doWeixinPay {
    // 向微信开放平台注册应用
    [WXApi registerApp:kAppKeyWeiXin];
    
    //
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"10000100";
    request.prepayId = @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr = @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp = 1397527777;
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    NSLog(@"%@, %d", request, [WXApi isWXAppInstalled]);
    [WXApi sendReq:request];
}

-(void)onResp: (BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp * response=(PayResp *)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}


#pragma mark - 搜索事件
- (void)searchBtnClick:(UIButton *)sender {
    NSLog(@"searchBtnClick");
    SearchViewController * searchVC = [SearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
//    [self doAlipayPay];
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
        NSLog(@"orderString - %@", orderString);
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
