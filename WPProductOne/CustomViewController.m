//
//  CustomViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CustomViewController.h"
#import "CustomCell.h"
#import "TeacherDetailViewController.h"


@interface CustomViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _stockTableView;
    UITableView * _fundTableView;
    UITableView * _metalTableView;
    UITableView * _foreignTableView;
    UITableView * _analyzeTableView;
    UITableView * _bondTableView;
    UITableView * _counselorTableView;
    UITableView * _moreTableView;
    UIImageView * _shutiaoImageView;

    NSMutableArray * _tableViewArray;
    NSMutableArray * _moduleBtns;
    NSMutableArray * _dataSources;
}
@end

@implementation CustomViewController

#pragma mark - 数据准备
- (void)getDataSource:(NSString *)categoryId {
    NSString * urlStr = [NSString stringWithFormat:@"%@/custom/loadPage", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:@{@"categoryId":categoryId} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray * arr = (NSArray *)responseObject[kData];
            
            if ([arr respondsToSelector:@selector(count)]) {
                
                if (arr.count >= 1) {
                    // 更新数据源
                    _dataSources[self.selectedIndex] = arr;
                    
                    // 更新界面
                    NSLog(@"reloadData");
                    [_tableViewArray[self.selectedIndex] reloadData];
                    [self.view bringSubviewToFront:_tableViewArray[self.selectedIndex]];
                }
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view.
    
    _moduleBtns = [NSMutableArray arrayWithCapacity:0];
    _tableViewArray = [NSMutableArray arrayWithCapacity:0];
    
    NSLog(@"selectedBtnIndex  - %ld", self.selectedIndex);
    
    // 初始视图
    [self initView];
    
    // 初始数据源
    _dataSources = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < self.moduleBtnTitleArr.count; i++) {
        NSMutableArray * mArr = [[NSMutableArray alloc] init];
        [_dataSources addObject:mArr];
    }
    
    [self updateDataSource:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始视图
- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 自定义导航栏
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenRect.size.width, kBatteryHeight + kNavgationBarHeight)];
    [CLTool gradualBackgroundColor:navView];
    [self.view addSubview:navView];
    
    // 定制
    UILabel * personLabel = [[UILabel alloc] init];
    personLabel.text = @"定制";
    personLabel.textColor = [UIColor whiteColor];
    personLabel.textAlignment = NSTextAlignmentCenter;
    personLabel.font = [UIFont fontWithName:@".PingFang-SC-Regular" size:17];
    personLabel.frame = CGRectMake(0, kBatteryHeight, kScreentWidth, kNavgationBarHeight);
    [navView addSubview:personLabel];
    
    // ------------------- 1. 左侧选项 -------------------
//    NSArray * titles = @[@"股票", @"外汇", @"基金", @"债券", @"贵金属", @"股指期货", @"商品期货"];
//    NSArray * moduleImages = @[@"stock.png", @"fund.png", @"metal.png", @"foreign.png", @"analyze.png", @"bond.png", @"counselor.png", @"more.png"];
//    NSArray * titles = @[@"股票", @"基金", @"贵金属", @"外汇", @"分析", @"债券", @"顾问", @"更多"];
    NSInteger count = self.moduleBtnTitleArr.count;
    for (int i = 0; i < count; i++) {
        
        NSDictionary * dic = self.moduleBtnTitleArr[i];
        
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(15, i * 44 + 64, 98 - 30, 44);
        label.backgroundColor = kClearColor;
        label.text = dic[@"cateName"];
        [self.view addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        [CLTool labelAlightLeftAndRight:label];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = label.frame;
        [self.view addSubview:btn];
        [btn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
//        [btn setTitle:dic[@"cateName"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10 + i;
        [_moduleBtns addObject:btn];
        self.moduleBtns = _moduleBtns;
    }
    
    _shutiaoImageView = [UIImageView new];
    _shutiaoImageView.frame = CGRectMake(0, 44 * self.selectedIndex + (44-20)/2 + 64, 3, 20);
    [self.view addSubview:_shutiaoImageView];
    _shutiaoImageView.image = [UIImage imageNamed:@"shutiao.png"];
    
    // ------------------- 2. 右侧列表 -------------------
    /*
    _stockTableView = [self createTableView];
    _stockTableView.tag = 20;
    
    _fundTableView = [self createTableView];
    _fundTableView.tag = 21;
    
    _metalTableView = [self createTableView];
    _metalTableView.tag = 22;
    
    _foreignTableView = [self createTableView];
    _foreignTableView.tag = 23;

    _analyzeTableView = [self createTableView];
    _analyzeTableView.tag = 24;

    _bondTableView = [self createTableView];
    _bondTableView.tag = 25;

    _counselorTableView = [self createTableView];
    _counselorTableView.tag = 26;
    
    _moreTableView = [self createTableView];
    _moreTableView.tag = 27;
    */
    
    for (NSInteger i = 0; i < self.moduleBtnTitleArr.count; i++) {
        UITableView * tableView = [self createTableView];
        tableView.tag = 20 + i;
        [_tableViewArray addObject:tableView];
    }
    
//    _tableViewArray = @[_stockTableView, _fundTableView, _metalTableView, _foreignTableView, _analyzeTableView, _bondTableView, _counselorTableView, _moreTableView];
}

- (void)btnClick:(UIButton *)sender {
    
    NSInteger value = sender.tag - 10;
    
    // 更新数据
    [self updateDataSource:value];
}

- (void)updateDataSource:(NSInteger)selectedIndex {
    
    NSLog(@"updateDataSource - %ld", selectedIndex);
    
    // 更新竖条位置
    _shutiaoImageView.frame = CGRectMake(0, 44 * selectedIndex + (44-20)/2 + 64, 3, 20);
    
    // 更新界面
    if (_tableViewArray.count > 0) {
        
        [self.view bringSubviewToFront:_tableViewArray[selectedIndex]];
        [self getDataSource:_moduleBtnTitleArr[selectedIndex][@"id"]];
    }
    
    // 更新数据
}


- (UITableView *)createTableView {
    CGRect frame = CGRectMake(98, kMargin64, kScreentWidth - 98, kScreentHeight - kMargin64 - kTabbarHeight);
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    UIView * headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreentWidth - 93, 91);
    tableView.tableHeaderView = headerView;
    
    UIImageView * newImageView = [UIImageView new];
    newImageView.frame = CGRectMake((kScreentWidth - 93 - 250) / 2, 10, 250, 71);
    [headerView addSubview:newImageView];
    newImageView.image = kImageNamed(@"carousel.png");
    
    return  tableView;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataSources[self.selectedIndex] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"custom";
    CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    NSMutableArray * arr = _dataSources[self.selectedIndex];
    
    if (arr.count >= 1) {
        NSDictionary * dic = arr[indexPath.row];
    
    // 设置cell的属性
    [cell.icon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kJGTGetImage, dic[@"lectPic"]]]];
        
        // 设置头像圆角
        CALayer * iconLayer = cell.icon.layer;
        iconLayer.cornerRadius = 25;
        iconLayer.masksToBounds = YES;
    
//    cell.nickNameLbl.text = @"马化腾";
//    cell.nickNameLbl = dic[@"lectName"];
//    [cell.tagBtn1 setTitle:@"基金分析" forState:UIControlStateNormal];
//    [cell.tagBtn2 setTitle:@"私人理财" forState:UIControlStateNormal];
//    cell.descLbl.text = @"理财专家，毕业于加拿大Ascenda商学院，国际金融学院，案例营利高达100之多。";
//    cell.followLabel.text = @"关注人数: 1886人";
//    cell.downloadLabel.text = @"交易指数: 98%";
//    cell.dealLabel.text = @"下载指数: 5.0分";
//    cell.stateLabel.text = @"忙碌";
        
        cell.nickNameLbl.text = dic[@"lectName"];
        [cell.tagBtn1 setTitle:dic[@"tag1"] forState:UIControlStateNormal];
        [cell.tagBtn2 setTitle:dic[@"tag2"] forState:UIControlStateNormal];
        cell.descLbl.text = dic[@"introduction"];
        cell.followLabel.text = [NSString stringWithFormat:@"关注人数: %@人", dic[@"attentionNum"]];
        cell.dealLabel.text = [NSString stringWithFormat:@"交易指数: %@%%", dic[@"trin"]];
        NSString * downStr = dic[@"downPoint"];
        CGFloat downStr2 = [downStr floatValue];
        cell.downloadLabel.text = [NSString stringWithFormat:@"下载指数: %.1f分", downStr2];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"custom - didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeacherDetailViewController * teacherDetailVC = [TeacherDetailViewController new];
    
    NSMutableArray * arr = _dataSources[self.selectedIndex];
    if (arr.count >= 1) {
        NSDictionary * dic = arr[indexPath.row];
        teacherDetailVC.userId = dic[@"lecturerId"];
        NSLog(@"did - %@", dic);
    }
    
    [self.navigationController pushViewController:teacherDetailVC animated:YES];
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
