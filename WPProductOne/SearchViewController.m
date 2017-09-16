//
//  SearchViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/22.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeCell.h"
#import "BuyViewController.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

{
    UITextField * _searchTF;
    NSArray * _dataSource;
    UITableView * _tableView;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    _dataSource = [NSArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)initView {
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    UIView * searchView = [UIView new];
    searchView.frame = CGRectMake(0, 0, kScreentWidth, 64);
    searchView.backgroundColor = kGlobalColor;
    [self.view addSubview:searchView];
    
    UIView * backgroudView = [UIView new];
    backgroudView.frame = CGRectMake(20, 20 + 5, kScreentWidth - 20 - 60, 30);
    backgroudView.backgroundColor = kWhiteColor;
    [self.view addSubview:backgroudView];
    
    UIImageView * searchImageV = [UIImageView new];
    searchImageV.frame = CGRectMake(5, 5, 20, 20);
    searchImageV.image = kImageNamed(@"search_small2@2x.png");
    [backgroudView addSubview:searchImageV];
    
    // 搜索框
    UITextField * searchTF = [UITextField new];
    searchTF.frame = CGRectMake(30, 0, backgroudView.frame.size.width - 44, 34);
    searchTF.placeholder = @"请输入要搜索的课程或老师";
    [backgroudView addSubview:searchTF];
    searchTF.returnKeyType = UIReturnKeySearch;
    searchTF.delegate = self;
    [searchTF becomeFirstResponder];
    _searchTF = searchTF;
    
    // 取消
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(kScreentWidth - 60, 20, 60, 44);
    [self.view addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = CGRectMake(0, kMargin64, kScreentWidth, kScreentHeight - kMargin64 - kTabbarHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // 发送搜索请求
    NSLog(@".search.");
    if (_searchTF.text.length >= 1) {
        
        [self.view endEditing:YES];
        NSString * urlStr = [NSString stringWithFormat:@"%@/home/searchCourse", kJGT];
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager GET:urlStr parameters:@{@"searchKey":_searchTF.text} progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                _dataSource = [responseObject objectForKey:kData];
                if (_dataSource.count) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                    });
                } else {
                    [CLTool showAlert:@"没有查询到内容谷雅铜" target:self];
                }
            } else {
                [CLTool showAlert:@"查询失败" target:self];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error - %@", error);
        }];
    } else {
        [CLTool showAlert:@"请输入搜索内容" target:self];
    }
    
    return YES;
}

#pragma mark 返回首页
- (void)cancelBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellId = @"search";
    HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSDictionary * dic = _dataSource[indexPath.row];
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
    
    return cell;
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

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BuyViewController * buyVC = [BuyViewController new];
    buyVC.courseId = _dataSource[indexPath.row][@"courseId"];
    buyVC.price = _dataSource[indexPath.row][@"price"];
    [self.navigationController pushViewController:buyVC animated:YES];
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
