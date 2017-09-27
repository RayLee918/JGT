//
//  CardViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CardViewController.h"
#import "CardCell.h"
#import "AddCardViewController.h"

@interface CardViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _dataSource;
    UITableView * _tablView;
    NSArray * _colorArray;
}
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    _colorArray = @[@{@"firstColor":kColor(0x419BE3), @"secondColor":kColor(0x37A0F4)}, @{@"firstColor":kColor(0xD64E2C), @"secondColor":kColor(0xF95B34)}, @{@"firstColor":kColor(0x017C6E), @"secondColor":kColor(0x017C6E)}];
    [self initView];
//    [self getCardDataSource];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"银行卡管理";

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getCardDataSource];
}

- (void)getCardDataSource {
    
//    _dataSource = [NSMutableArray arrayWithArray:@[@{@"bankName":@"交通银行", @"cardType":@"储蓄卡", @"cardNum":@"1234567891234567"}, @{@"bankName":@"交通银行", @"cardType":@"储蓄卡", @"cardNum":@"1234567891234567"}]];
//    [_tablView reloadData];
    // user/manageCard/removeCard
    NSString * url = [NSString stringWithFormat:@"%@/user/manageCard/getCardList", kJGT];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"card - %@", responseObject);
        if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
            if (![[responseObject objectForKey:kData] isEqual:[NSNull null]]) {
                _dataSource = [NSMutableArray arrayWithArray:[responseObject objectForKey:kData]];
                NSLog(@"card - data - %@", [responseObject objectForKey:kData]);
                [_tablView reloadData];
            }
        } else {
            [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

- (void)initView {

    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 添加银行卡按钮
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加银行卡" style:UIBarButtonItemStylePlain target:self action:@selector(addCardBtnClick)];
    self.navigationItem.rightBarButtonItem = addItem;
    
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kMargin64);
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tablView = tableView;
}

#pragma mark - 添加银行卡
- (void)addCardBtnClick {
    AddCardViewController * addCardVC = [AddCardViewController new];
    [self.navigationController pushViewController:addCardVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"removeCard --------- ");
        // 删除银行卡
        NSString * url = [NSString stringWithFormat:@"%@/user/manageCard/removeCard", kJGT];
        [[AFHTTPSessionManager manager] GET:url parameters:@{@"id":_dataSource[indexPath.row][@"id"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"removeCard - %@", responseObject);
            if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                [CLTool showAlert:@"删除成功" target:self];
                // 刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_dataSource removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                });
                
            } else {
                [CLTool showAlert:[responseObject objectForKey:kMsg] target:self];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    CardCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    // 随机背景渐变色
    NSDictionary * colorDic = _colorArray[indexPath.row % 3];
    [CLTool gradualBackgroundColorLeftAndRight:cell.cardImageView firstColor:colorDic[@"firstColor"] secondColor:colorDic[@"secondColor"]];
    
    // 设置卡属性
    // 银行名
    NSDictionary * dic = _dataSource[indexPath.row];
    if (![dic[@"bankName"] isEqual:[NSNull null]]) {
        
        cell.bankLabel.text = dic[@"bankName"];
    }
    
    // 卡类型
    if (![dic[@"cardType"] isEqual:[NSNull null]]) {
        
        cell.typeLabel.text = dic[@"cardType"];
    }

    // 卡号
    NSString * cardNum = dic[@"cardNum"];
    if (cardNum.length >= 4) {
        cardNum = [cardNum substringFromIndex:cardNum.length - 4];
        cell.cardNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@", cardNum];
    }

    // 发卡组织
    NSString * bankType = dic[@"bankType"];
    if ([bankType isEqualToString:@"VISA"]) {
        cell.issueImageView.image = kImageNamed(bankType);
    } else {
        cell.issueImageView.frame= CGRectMake(cell.cardImageView.frame.size.width - 20 - 51, cell.cardImageView.frame.size.height - 15 - 33, 51, 33);
        cell.issueImageView.image = kImageNamed(@"union.png");
    }
    
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
