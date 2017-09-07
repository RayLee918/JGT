//
//  CommentViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController () <UITextViewDelegate>
{
    NSMutableArray * _starBtns;
    UILabel * _placeholderLabel;
}
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _starBtns = [NSMutableArray new];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"写评论";
}

- (void)initView {
    // 发布按钮
    UIBarButtonItem * publishItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishItemClick:)];
    self.navigationItem.rightBarButtonItem = publishItem;
    
    for (int i = 0; i <5; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = (kScreentWidth - 28.5*5 - 5*4) / 2 + (28.5 + 5) * i;
        btn.frame = CGRectMake(x, 15, 28.5, 28.5);
        [self.view addSubview:btn];
        [btn setTitleColor:kColor(0x4990E2) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.backgroundColor = kRedColor;
        [btn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_starBtns addObject:btn];
    }
    
    // 评论
    UITextView * tv = [UITextView new];
    tv.frame = CGRectMake(0, 28.5 + 40, kScreentWidth, 150);
    [self.view addSubview:tv];
    tv.delegate = self;
    tv.layer.borderColor = kColor(0xB0B0B0).CGColor;
    tv.layer.borderWidth = 0.5;
    
    _placeholderLabel = [UILabel new];
    _placeholderLabel.frame = CGRectMake(20, CGRectGetMinY(tv.frame), kScreentWidth - 20, 150);
    [self.view addSubview:_placeholderLabel];
    _placeholderLabel.font = [UIFont systemFontOfSize:12];
    _placeholderLabel.textColor = kColor(0xB0B0B0);
    _placeholderLabel.text = @"写下优质评论，有机会得到作者回复哦（80字以内）";
    _placeholderLabel.textAlignment = NSTextAlignmentCenter;

}

#pragma mark - textViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"%ld", textView.text.length);
    if (textView.text.length) {
        _placeholderLabel.hidden = YES;
    }
    else {
        _placeholderLabel.hidden = NO;
    }
}

#pragma mark - 星级评论
- (void)starBtnClick:(UIButton *)sender {

    NSInteger index = [_starBtns indexOfObject:sender];
    for (int i = 0; i < _starBtns.count; i++) {
        if (i <= index) {
            
            [_starBtns[i] setBackgroundColor:kGreenColor];
        } else {
            [_starBtns[i] setBackgroundColor:kRedColor];
        }
    }
}

#pragma mark - 发布
- (void)publishItemClick:(UIBarButtonItem *)sender {
    NSLog(@"publishItemClick");
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
