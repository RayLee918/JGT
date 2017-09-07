//
//  HomeDetailViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "HomeCell.h"
#import "CommentCell.h"
#import "CommentViewController.h"

@interface HomeDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"课程介绍";
}

- (void)initView {
    
    UIView * headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, kScreentWidth, 288);
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // tableView
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight - kBatteryHeight);
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kWhiteColor;
    
    // 100
    // 头像
    UIImageView * imageView = [UIImageView new];
    imageView.frame = CGRectMake(15, 20, 60, 60);
    [headerView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"mask.png"];
    
    // 课程名
    UILabel * courseNameLabel = [UILabel new];
    courseNameLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, 15, 200, 30);
    [headerView addSubview:courseNameLabel];
    courseNameLabel.font = [UIFont systemFontOfSize:13];
    courseNameLabel.textColor = kColor(0x1F1F1F);
    courseNameLabel.text = @"被立即数实战课";
    
    // 老师名
    UILabel * teacherNameLabel = [UILabel new];
    teacherNameLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMaxY(courseNameLabel.frame), 200, 15);
    [headerView addSubview:teacherNameLabel];
    teacherNameLabel.font = [UIFont systemFontOfSize:8];
    teacherNameLabel.textColor = kColor(0x1F1F1F);
    teacherNameLabel.text = @"马画藤老师";
    
    // 描述
    UILabel * descLabel = [UILabel new];
    descLabel.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 20, CGRectGetMaxY(teacherNameLabel.frame), 200, 15);
    [headerView addSubview:descLabel];
    descLabel.font = [UIFont systemFontOfSize:10];
    descLabel.textColor = kGlobalColor;
    descLabel.text = @"开通VIP, 免费阅读此章节";
    
    tableView.tableHeaderView = headerView;
    
    // 加入收藏
    UIButton * loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loveBtn.frame = CGRectMake(kScreentWidth - 20 - 60, (100 - 20) / 2, 60, 20);
    [headerView addSubview:loveBtn];
    [loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    loveBtn.backgroundColor = kRedColor;
    [loveBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    loveBtn.titleLabel.font = [UIFont systemFontOfSize:9.38];
    
    // 2
    // 分割线
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(0, 100, kScreentWidth, 2);
    [headerView addSubview:lineView];
    lineView.backgroundColor = kColor(0xEFEFEF);
    
    // 186
    // 分享按钮
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake((kScreentWidth - 285) / 2, 35 / 2 + 102, 285, 35);
    [headerView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.backgroundColor = kRedColor;
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    
    // 点赞
    UILabel * followLabel = [UILabel new];
    followLabel.frame = CGRectMake(0, 102 + 70, kScreentWidth / 3, 20);
    [headerView addSubview:followLabel];
    followLabel.font = [UIFont systemFontOfSize:14];
    followLabel.textColor = kColor(0x1F1F1F);
    followLabel.text = @"500";
    followLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * followLabel2 = [UILabel new];
    followLabel2.frame = CGRectMake(0, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [headerView addSubview:followLabel2];
    followLabel2.font = [UIFont systemFontOfSize:14];
    followLabel2.textColor = kColor(0xB0B0B0);
    followLabel2.text = @"点赞";
    followLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * shutiao1 = [UIView new];
    shutiao1.frame = CGRectMake(kScreentWidth / 3, CGRectGetMinY(followLabel.frame), 1, 40);
    [headerView addSubview:shutiao1];
    shutiao1.backgroundColor = kColor(0xEFEFEF);
    
    // 粉丝
    UILabel * fansLabel = [UILabel new];
    fansLabel.frame = CGRectMake(kScreentWidth / 3, CGRectGetMinY(followLabel.frame), kScreentWidth / 3, 20);
    [headerView addSubview:fansLabel];
    fansLabel.font = [UIFont systemFontOfSize:14];
    fansLabel.textColor = kColor(0x1F1F1F);
    fansLabel.text = @"12229";
    fansLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * fansLabel2 = [UILabel new];
    fansLabel2.frame = CGRectMake(kScreentWidth / 3, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [headerView addSubview:fansLabel2];
    fansLabel2.font = [UIFont systemFontOfSize:14];
    fansLabel2.textColor = kColor(0xB0B0B0);
    fansLabel2.text = @"粉丝";
    fansLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 分割线
    UIView * shutiao2 = [UIView new];
    shutiao2.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMinY(followLabel.frame), 1, 40);
    [headerView addSubview:shutiao2];
    shutiao2.backgroundColor = kColor(0xEFEFEF);
    
    // 动态
    UILabel * dynamicLabel = [UILabel new];
    dynamicLabel.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMinY(followLabel.frame), kScreentWidth / 3, 20);
    [headerView addSubview:dynamicLabel];
    dynamicLabel.font = [UIFont systemFontOfSize:14];
    dynamicLabel.textColor = kColor(0x1F1F1F);
    dynamicLabel.text = @"10";
    dynamicLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * dynamicLabel2 = [UILabel new];
    dynamicLabel2.frame = CGRectMake(kScreentWidth / 3 * 2, CGRectGetMaxY(followLabel.frame), kScreentWidth / 3, 20);
    [headerView addSubview:dynamicLabel2];
    dynamicLabel2.font = [UIFont systemFontOfSize:14];
    dynamicLabel2.textColor = kColor(0xB0B0B0);
    dynamicLabel2.text = @"动态";
    dynamicLabel2.textAlignment = NSTextAlignmentCenter;
    
    // 内容
    UILabel * contentLabel = [UILabel new];
    contentLabel.frame = CGRectMake(25, CGRectGetMaxY(followLabel2.frame) + 10, kScreentWidth - 25 * 2, 50);
    [headerView addSubview:contentLabel];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textColor = kColor(0x1F1F1F);
    contentLabel.numberOfLines = 0;
    contentLabel.text = @"内容简介：连续蝉联股票收益冠军，总收益达到900%，10年投资经验我们一直致力于为投资者提供最专业、便捷、安全的的投资理财服务。";
    
}



#pragma mark - 收藏 
- (void)loveBtnClick:(UIButton *)sender {
    NSLog(@"loveBtnClick");
}

#pragma mark - 分享
- (void)shareBtnClick:(UIButton *)sender {
    NSLog(@"shareBtnClick");
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 82;
    }
    else {
        return 150;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreentWidth, 35);
    
    UIView * shuLine = [UIView new];
    shuLine.frame = CGRectMake(18, 10, 1.5, 15);
    [view addSubview:shuLine];
    shuLine.backgroundColor = kGlobalColor;
    
    // 标题
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(25, 0, kScreentWidth - 25, 35);
    [view addSubview:label];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = kColor(0x1F1F1F);
    
    if (section == 0) {
        label.text  =@"股票";
        UIButton * commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commentBtn.frame = CGRectMake(kScreentWidth - 60, 0, 60, 35);
        [view addSubview:commentBtn];
        [commentBtn setTitleColor:kColor(0x4990E2) forState:UIControlStateNormal];
        commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [commentBtn setTitle:@"写评论" forState:UIControlStateNormal];
        [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        label.text  =@"喜欢该课程还喜欢";
    }
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView * view = [UIView new];
        view.frame = CGRectMake(0, 0, kScreentWidth, 35);
        view.backgroundColor = kWhiteColor;
        
        // 标题
        UIButton * circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        circleBtn.frame = CGRectMake(0, 0, kScreentWidth, 35);
        [view addSubview:circleBtn];
        circleBtn.backgroundColor = kWhiteColor;
        circleBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [circleBtn setTitleColor:kGlobalColor forState:UIControlStateNormal];
//        [circleBtn setTitle:@"点击进入圈子, 查看全部发言" forState:UIControlStateNormal];
        [circleBtn setTitle:@"点击进入圈子" forState:UIControlStateNormal];
        [circleBtn addTarget:self action:@selector(circleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView * hengLine = [UIView new];
        hengLine.frame = CGRectMake(0, 0, kScreentWidth, 1.5);
        [view addSubview:hengLine];
        hengLine.backgroundColor = kLineColor;
        
        return view;
    } else {
        UIView * view = [UIView new];
        view.frame = CGRectMake(0, 0, kScreentWidth, 35);
        
        UIView * hengLine = [UIView new];
        hengLine.frame = CGRectMake(18, 10, 1.5, 15);
        [view addSubview:hengLine];
        hengLine.backgroundColor = kLineColor;
        
        // 标题
        UIButton * openBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        openBtn.frame = CGRectMake(20, 7, (kScreentWidth - 70) / 2, 30);
        [view addSubview:openBtn];
        openBtn.backgroundColor = kColor(0xEEEEEE);
        openBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [openBtn setTitleColor:kColor(0x1F1F1F) forState:UIControlStateNormal];
        [openBtn setTitle:@"打开试读" forState:UIControlStateNormal];
        [openBtn addTarget:self action:@selector(openBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buyBtn.frame = CGRectMake(CGRectGetMaxX(openBtn.frame) + 30, 7, (kScreentWidth - 70) / 2, 30);
        [view addSubview:buyBtn];
        buyBtn.backgroundColor = kColor(0xFF615E);
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [buyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [buyBtn setTitle:@"优惠购买" forState:UIControlStateNormal];
        [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
    }
}

- (void)commentBtnClick:(UIButton *)sender {
    CommentViewController * commentVC = [CommentViewController new];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 进入圈子
- (void)circleBtnClick:(UIButton *)sender {
    NSLog(@"circleBtnClick");
}

#pragma mark - 打开试读
- (void)openBtnClick:(UIButton *)sender {
    NSLog(@"openBtnClick");
}

#pragma mark - 优惠购买
- (void)buyBtnClick:(UIButton *)sender {
    NSLog(@"buyBtnClick");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 35;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * identifier = @"cell";
        CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        // 设置cell的属性
        cell.icon.image = [UIImage imageNamed:@"mask.png"];
        cell.nickNameLbl.text = @"刘波波";
        cell.dateLbl.text = @"1天前";
        cell.contentLbl.text = @"感觉马老师的课程怼我，以后的股市很有帮助，非常值得买，你可以对你有帮助。";
        cell.levelLabel.text = @"LV12";
        
        return cell;
    } else {
        static NSString * identifier = @"cell1";
        HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
