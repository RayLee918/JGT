//
//  CourseViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/23.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CourseViewController.h"

@interface CourseViewController () <UITextViewDelegate>
{
    UILabel * _placeholderLabel;
}
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"课程上传";
    
}

- (void)initView {
    
    // 发布按钮
    UIBarButtonItem * publishItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publishBtnClick:)];
    self.navigationItem.rightBarButtonItem = publishItem;
    
    UITextField * tf = [UITextField new];
    tf.frame = CGRectMake(20, 0, kScreentWidth - 20, 44);
    [self.view addSubview:tf];
    tf.font = [UIFont systemFontOfSize:15];
    tf.placeholder = @"标题	新建上传课程资料";
    
    // 分割线
    UIView * lineView = [UIView new];
    lineView.frame = CGRectMake(0, CGRectGetMaxY(tf.frame) - 1, kScreentWidth, 1);
    [self.view addSubview:lineView];
    lineView.backgroundColor = kLineColor;
    
    // 内容
    UITextView * tv = [UITextView new];
    tv.frame = CGRectMake(20, 44, kScreentWidth - 20, 150);
    [self.view addSubview:tv];
    tv.delegate = self;
    tv.font = [UIFont systemFontOfSize:15];
    
    _placeholderLabel = [UILabel new];
    _placeholderLabel.frame = CGRectMake(20, CGRectGetMinY(tv.frame), kScreentWidth - 20, 44);
    [self.view addSubview:_placeholderLabel];
    _placeholderLabel.font = [UIFont systemFontOfSize:15];
    _placeholderLabel.textColor = kColor(0xB0B0B0);
    _placeholderLabel.text = @"描述一下你的课程";
    
    // 上传文档按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(tv.frame), 68, 59);
    [self.view addSubview:btn];
//    [btn setTitle:@"上传文档" forState:UIControlStateNormal];
//    btn.backgroundColor = kRedColor;
    [btn setBackgroundImage:kImageNamed(@"upload.png") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(uploadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 定位
    UIImageView * iv = [UIImageView new];
    iv.frame = CGRectMake(20, CGRectGetMaxY(btn.frame)+ 10 + 2, 10, 12);
    [self.view addSubview:iv];
    iv.image = kImageNamed(@"location.png");
    
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(40, CGRectGetMaxY(btn.frame)  + 10, kScreentWidth - 30 * 2, 16);
    [self.view addSubview:label];
    label.textColor = kColor(0xB0B0B0);
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"河北	石家庄	新华区";
    
    // 分割线
    UIView * lineView2 = [UIView new];
    lineView2.frame = CGRectMake(0, CGRectGetMaxY(label.frame) + 5, kScreentWidth, 1);
    [self.view addSubview:lineView2];
    lineView2.backgroundColor = kLineColor;
    
    // 选项卡
    UIView * optionView = [UIView new];
    optionView.frame = CGRectMake((kScreentWidth - 190) / 2, CGRectGetMaxY(label.frame) + 20, 190, 44);
    [self.view addSubview:optionView];
    optionView.layer.borderWidth = 0.5;
    optionView.layer.borderColor = kColor(0xB0B0B0).CGColor;
    optionView.layer.cornerRadius = 22;
    
    UIButton * priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    priceBtn.frame = CGRectMake(5, 7, 80, 30);
    [optionView addSubview:priceBtn];
    [priceBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    priceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [priceBtn setTitle:@"商品价格" forState:UIControlStateNormal];
    [priceBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    priceBtn.layer.cornerRadius = 15;
    priceBtn.layer.masksToBounds = YES;
    [priceBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    
    UIButton * categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryBtn.frame = CGRectMake(optionView.frame.size.width - 5 - 80, 7, 80, 30);
    [optionView addSubview:categoryBtn];
    [categoryBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [categoryBtn setTitle:@"商品分类" forState:UIControlStateNormal];
    [categoryBtn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    categoryBtn.layer.cornerRadius = 15;
    categoryBtn.layer.masksToBounds = YES;
    [categoryBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    
    // 价格
    UIImageView * priceImageV = [UIImageView new];
    priceImageV.frame = CGRectMake(kScreentWidth/3, CGRectGetMaxY(optionView.frame) + 50, 25, 25);
    [self.view addSubview:priceImageV];
    priceImageV.image = kImageNamed(@"money.png");
    
    UITextField * priceTF = [UITextField new];
    priceTF.frame = CGRectMake(CGRectGetMaxX(priceImageV.frame) + 5, CGRectGetMinY(priceImageV.frame), 200, 25);
    [self.view addSubview:priceTF];
    priceTF.font = [UIFont systemFontOfSize:25];
    
    UIView * priceLineView = [UIView new];
    priceLineView.frame = CGRectMake((kScreentWidth - 200) / 2, CGRectGetMaxY(priceTF.frame) + 2, 200, 1);
    [self.view addSubview:priceLineView];
    priceLineView.backgroundColor = kLineColor;
    
    // 分割线
    UIView * lineView3 = [UIView new];
    lineView3.frame = CGRectMake(0, CGRectGetMaxY(priceImageV.frame)  + 50 - 1, kScreentWidth, 1);
    [self.view addSubview:lineView3];
    lineView3.backgroundColor = kLineColor;
    
    // 分类
    UILabel * classLabel = [UILabel new];
    classLabel.frame = CGRectMake(20, CGRectGetMaxY(lineView3.frame), kScreentWidth, 44);
    [self.view addSubview:classLabel];
    classLabel.text = @"分类";
    
    UIButton * classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(kScreentWidth - 44  - 100, CGRectGetMaxY(lineView3.frame), 100, 44);
    [self.view addSubview:classBtn];
    [classBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    [classBtn setTitle:@"请选择分类" forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    classBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView * arrowImageV = [UIImageView new];
    arrowImageV.frame = CGRectMake(kScreentWidth - 27, CGRectGetMaxY(lineView3.frame) + (44 - 7) / 2, 7, 12);
    [self.view addSubview:arrowImageV];
//    arrowImageV.backgroundColor = kGlobalColor;
    arrowImageV.image = kImageNamed(@"arrow.png");
    
    // 分割线
    UIView * lineView4 = [UIView new];
    lineView4.frame = CGRectMake(0, CGRectGetMaxY(classBtn.frame) - 1, kScreentWidth, 1);
    [self.view addSubview:lineView4];
    lineView4.backgroundColor = kLineColor;
    
    // 发布
    UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(20, kScreentHeight - kMargin64 - kTabbarHeight - 33 - 10, kScreentWidth - 40, 33);
    [self.view addSubview:publishBtn];
    [publishBtn setTitle:@"确定发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [publishBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    publishBtn.layer.cornerRadius = 5;
    publishBtn.layer.masksToBounds = YES;
    
    // 分割线
    UIView * lineView5 = [UIView new];
    lineView5.frame = CGRectMake(0, CGRectGetMinY(publishBtn.frame) - 10, kScreentWidth, 1);
    [self.view addSubview:lineView5];
    lineView5.backgroundColor = kLineColor;
}

#pragma mark - 发布课程
- (void)publishBtnClick:(UIButton *)sender {
    NSLog(@"publishBtnClick");
}

#pragma mark - 请选择分类
- (void)classBtnClick:(UIButton *)sender {
    NSLog(@"classBtnClick");
}

#pragma mark - 选项按钮
- (void)optionBtnClick:(UIButton *)sender {
    NSLog(@"optionBtnClick");
}

#pragma mark - 上传
- (void)uploadBtnClick:(UIButton *)sender {
    NSLog(@"uploadBtnClick");
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length) {
        _placeholderLabel.hidden = YES;
    }
    else {
        _placeholderLabel.hidden = NO;
    }
}

#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
