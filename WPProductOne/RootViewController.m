//
//  RootViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/21.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "RootViewController.h"
#import "RecommendViewController.h"
#import "CustomViewController.h"
#import "AccountViewController.h"


@interface RootViewController ()
{
    // 选中的标签视图控制器索引
    NSInteger _lastSelectedIndex;
    
    // 列表展示
    UITableView * _tableView;
    
    NSMutableArray * _tabbarBtns;
    
}
@end

@implementation RootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 自定义视图
//    [self initView];
    
    // 自定义标签视图按钮
//    self.tabBar.hidden = YES;
//    [self customTabbar];

    _tabbarBtns = [NSMutableArray array];
    
    // 初始视图
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initView];
        self.tabBar.hidden = YES;
        [self customTabbar];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义标签按钮
- (void)customTabbar {
    
    unsigned long count = 3;
    
    // 标签按钮的宽高
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat width = rect.size.width / count;
    CGFloat height = self.tabBar.frame.size.height;
//    NSLog(@"tabbarFrame - %@", NSStringFromCGRect(self.tabBar.frame));
    
    // 自定义标签视图
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height - height, rect.size.width, height)];
    _tabbarView.backgroundColor = kWhiteColor;
    
    // 添加一条分割线
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenRect.size.width, 1)];
    line.backgroundColor = kLineColor;
    [_tabbarView addSubview:line];
    
    // ------------------- 添加标签按钮 -------------------
    // 推荐标签按钮
    UIButton * recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendBtn setFrame:CGRectMake(0, 0, width, height)];
    recommendBtn.tag = 10;
    [recommendBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    recommendBtn.selected = YES;
    [recommendBtn setImage:[UIImage imageNamed:@"recommend_hl.png"] forState:UIControlStateSelected];
    [recommendBtn setImage:[UIImage imageNamed:@"recommend.png"] forState:UIControlStateNormal];
    [_tabbarView addSubview:recommendBtn];
    _lastSelectedIndex = recommendBtn.tag;
    [_tabbarBtns addObject:recommendBtn];
    
    // 定制标签按钮
    UIButton * customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.tag = 11;
    [customBtn setFrame:CGRectMake(CGRectGetMaxX(recommendBtn.frame), 0, width, height)];
    [customBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:@"custom_hl.png"] forState:UIControlStateSelected];
    [customBtn setImage:[UIImage imageNamed:@"custom.png"] forState:UIControlStateNormal];
    [_tabbarView addSubview:customBtn];
    [_tabbarBtns addObject:customBtn];
    
    // 帐户标签按钮
    UIButton * accountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    accountBtn.tag = 12;
    [accountBtn setFrame:CGRectMake(CGRectGetMaxX(customBtn.frame), 0, width, height)];
    [accountBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [accountBtn setImage:[UIImage imageNamed:@"account.png"] forState:UIControlStateNormal];
    [accountBtn setImage:[UIImage imageNamed:@"account_hl.png"] forState:UIControlStateSelected];;
    [_tabbarView addSubview:accountBtn];
    [_tabbarBtns addObject:accountBtn];
    self.tabbarBtns = _tabbarBtns;
    
    
    // 添加自定义视图
    [self.view addSubview:_tabbarView];
}

#pragma mark - 标签按钮响应
- (void)tagBtnClick:(UIButton *)sender {
    
//    if (_lastSelectedIndex != sender.tag) {
//        self.selectedIndex = sender.tag - 10;
//        sender.selected = YES;
//        
//        UIButton * btn = (UIButton *)[self.view viewWithTag:_lastSelectedIndex];
//        btn.selected = NO;
//        
//        _lastSelectedIndex = sender.tag;
//    }
    
    for (int i = 0; i < _tabbarBtns.count; i++) {
        if (i + 10 == sender.tag) {
            sender.selected = YES;
            self.selectedIndex = sender.tag - 10;
        }
        else {
            [_tabbarBtns[i] setSelected:NO];
        }
    }
}

- (void)recommendBtnClick:(UIButton *)sender {
    NSLog(@"recommendBtnClick");
}

- (void)customBtnClick:(UIButton *)sender {
    NSLog(@"customBtnClick");
}

- (void)accountBtnClick:(UIButton *)sender {
    NSLog(@"accountBtnClick");
}

#pragma mark - 自定义视图
- (void)initView {
    
    // ------------------- 1. 创建视图控制器 -------------------
    RecommendViewController * recommendVC = [[RecommendViewController alloc] init];
    UINavigationController * recommendNC = [[UINavigationController alloc] initWithRootViewController:recommendVC];
    
    CustomViewController * customVC = [[CustomViewController alloc] init];
    UINavigationController * customNC = [[UINavigationController alloc] initWithRootViewController:customVC];
    
    AccountViewController * accountVC = [[AccountViewController alloc] init];
    UINavigationController * accountNC = [[UINavigationController alloc] initWithRootViewController:accountVC];

    NSArray * viewControllers = @[recommendNC, customNC, accountNC];
    self.viewControllers = viewControllers;
    
    recommendVC.rootVC = self;
    recommendVC.customVC = customVC;
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
