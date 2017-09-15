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
    UIView * _priceView;
    UIView * _guigeView;
    NSArray * _moduleBtnArray;
    NSArray * _moduleTitleArray;
    NSString * _module;
    UIView * _moduleView;
    UIButton * _classBtn;
    UITextField * _classTF;
}
@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _module = @"";
    _moduleBtnArray = @[@"stock", @"fund", @"metal", @"foreign", @"analyze", @"bond", @"counselor", @"more"];
    _moduleTitleArray = @[@"股票", @"基金", @"贵金属", @"外汇", @"分析", @"债券", @"顾问", @"更多"];
    [self initView];
    [self initClassView];
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
    tv.frame = CGRectMake(20, 44, kScreentWidth - 20, 108);
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
    priceBtn.tag = 11;
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
    categoryBtn.tag = 12;
    
    categoryBtn.layer.cornerRadius = 15;
    categoryBtn.layer.masksToBounds = YES;
    [categoryBtn setBackgroundImage:kImageNamed(@"btn_background.png") forState:UIControlStateNormal];
    
    // 价格
    _priceView = [UIView new];
    _priceView.frame = CGRectMake(0, CGRectGetMaxY(optionView.frame) + 5, kScreentWidth, 44 * 6);
    [self.view addSubview:_priceView];
    _priceView.backgroundColor = kWhiteColor;
    
    UIImageView * priceImageV = [UIImageView new];
    priceImageV.frame = CGRectMake((kScreentWidth - 200) / 2, (220 - 25)/2, 25, 25);
    [_priceView addSubview:priceImageV];
    priceImageV.image = kImageNamed(@"money.png");
    
    UITextField * priceTF = [UITextField new];
    priceTF.frame = CGRectMake(CGRectGetMaxX(priceImageV.frame) + 5, CGRectGetMinY(priceImageV.frame), 200, 25);
    [_priceView addSubview:priceTF];
    priceTF.font = [UIFont systemFontOfSize:25];
    
    UIView * priceLineView = [UIView new];
    priceLineView.frame = CGRectMake((kScreentWidth - 200) / 2, CGRectGetMaxY(priceTF.frame) + 2, 200, 1);
    [_priceView addSubview:priceLineView];
    priceLineView.backgroundColor = kLineColor;
    
    // ------------------- 商品规格 -------------------
    _guigeView = [UIView new];
    _guigeView.frame = CGRectMake(0, CGRectGetMaxY(optionView.frame) + 5, kScreentWidth, 44 * 6);
    [self.view addSubview:_guigeView];
    _guigeView.backgroundColor = kWhiteColor;
    [self.view sendSubviewToBack:_guigeView];
    
    // 持仓周期
    UILabel * zhouqiLabel = [UILabel new];
    zhouqiLabel.frame = CGRectMake(20, 0, 80, 44);
    [_guigeView addSubview:zhouqiLabel];
    zhouqiLabel.text = @"持仓周期";
    
    UITextField * zhouqiTF = [UITextField new];
    zhouqiTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(zhouqiLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:zhouqiTF];
    zhouqiTF.placeholder = @"8-10周期";
    
    UIView * guigeLineView = [UIView new];
    guigeLineView.frame = CGRectMake(0, CGRectGetMaxY(zhouqiLabel.frame) - 1, kScreentWidth, 1);
    [_guigeView addSubview:guigeLineView];
    guigeLineView.backgroundColor = kLineColor;
    
    // 预计收益
    UILabel * shouyiLabel = [UILabel new];
    shouyiLabel.frame = CGRectMake(20, CGRectGetMaxY(zhouqiLabel.frame), 80, 44);
    [_guigeView addSubview:shouyiLabel];
    shouyiLabel.text = @"预计收益";
    
    UITextField * shouyiTF = [UITextField new];
    shouyiTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(shouyiLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:shouyiTF];
    shouyiTF.placeholder = @"10W";
    
    UIView * shouyiLineView = [UIView new];
    shouyiLineView.frame = CGRectMake(0, CGRectGetMaxY(shouyiLabel.frame) - 1, kScreentWidth, 1);
    [_guigeView addSubview:shouyiLineView];
    shouyiLineView.backgroundColor = kLineColor;

    // 资金要求
    UILabel * zijinLabel = [UILabel new];
    zijinLabel.frame = CGRectMake(20, CGRectGetMaxY(shouyiLabel.frame), 80, 44);
    [_guigeView addSubview:zijinLabel];
    zijinLabel.text = @"资金要求";
    
    UITextField * zijinTF = [UITextField new];
    zijinTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(zijinLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:zijinTF];
    zijinTF.placeholder = @"不低于20W";
    
    UIView * zijinLineView = [UIView new];
    zijinLineView.frame = CGRectMake(0, CGRectGetMaxY(zijinLabel.frame) - 1, kScreentWidth, 1);
    [_guigeView addSubview:zijinLineView];
    zijinLineView.backgroundColor = kLineColor;

    // 资金最高
    UILabel * zuigaoLabel = [UILabel new];
    zuigaoLabel.frame = CGRectMake(20, CGRectGetMaxY(zijinLabel.frame), 80, 44);
    [_guigeView addSubview:zuigaoLabel];
    zuigaoLabel.text = @"资金最高";
    
    UITextField * zuigaoTF = [UITextField new];
    zuigaoTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(zuigaoLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:zuigaoTF];
    zuigaoTF.placeholder = @"不高于100W";
    
    UIView * zuigaoLineView = [UIView new];
    zuigaoLineView.frame = CGRectMake(0, CGRectGetMaxY(zuigaoLabel.frame) - 1, kScreentWidth, 1);
    [_guigeView addSubview:zuigaoLineView];
    zuigaoLineView.backgroundColor = kLineColor;

    // 购买人数
    UILabel * renshuLabel = [UILabel new];
    renshuLabel.frame = CGRectMake(20, CGRectGetMaxY(zuigaoLabel.frame), 80, 44);
    [_guigeView addSubview:renshuLabel];
    renshuLabel.text = @"购买人数";
    
    UITextField * renshuTF = [UITextField new];
    renshuTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(renshuLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:renshuTF];
    renshuTF.placeholder = @"最多100人";
    
    UIView * renshuLineView = [UIView new];
    renshuLineView.frame = CGRectMake(0, CGRectGetMaxY(renshuLabel.frame) - 1, kScreentWidth, 1);
    [_guigeView addSubview:renshuLineView];
    renshuLineView.backgroundColor = kLineColor;
    
    // 分类
    UILabel * classLabel = [UILabel new];
    classLabel.frame = CGRectMake(20, CGRectGetMaxY(renshuLabel.frame), kScreentWidth, 44);
    [_guigeView addSubview:classLabel];
    classLabel.text = @"分类";
    
    UITextField * classTF = [UITextField new];
    classTF.frame = CGRectMake(CGRectGetMaxX(zhouqiLabel.frame) + 10, CGRectGetMinY(classLabel.frame), kScreentWidth - 20 - zhouqiLabel.frame.size.width, zhouqiLabel.frame.size.height);
    [_guigeView addSubview:classTF];
    classTF.placeholder = @"";
    _classTF = classTF;
    classTF.userInteractionEnabled = NO;
    
    UIButton * classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    classBtn.frame = CGRectMake(kScreentWidth - 44  - 100, CGRectGetMaxY(renshuLabel.frame), 100, 44);
    [_guigeView addSubview:classBtn];
    [classBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    [classBtn setTitle:@"请选择分类" forState:UIControlStateNormal];
    [classBtn addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    classBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _classBtn = classBtn;
    
    UIImageView * arrowImageV = [UIImageView new];
    arrowImageV.frame = CGRectMake(kScreentWidth - 27, CGRectGetMaxY(renshuLabel.frame) + (44 - 7) / 2, 7, 12);
    [_guigeView addSubview:arrowImageV];
    arrowImageV.image = kImageNamed(@"arrow.png");
    
    // 分割线
//    UIView * lineView4 = [UIView new];
//    lineView4.frame = CGRectMake(0, CGRectGetMaxY(classBtn.frame) - 1, kScreentWidth, 1);
//    [self.view addSubview:lineView4];
//    lineView4.backgroundColor = kLineColor;
    
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

- (void)initClassView {
    UIView * view = [UIView new];
    view.frame = kScreenRect;
    [self.view addSubview:view];
    view.backgroundColor = kWhiteColor;
    
    for (NSInteger i = 0; i < _moduleBtnArray.count; i++) {
        CGFloat width = 66;
        CGFloat marginX = (kScreentWidth-66*2)/3;
        CGFloat marginY = (kScreentHeight - kTabbarHeight - kNavgationBarHeight - 66*4)/5 - 20;
        CGFloat x = marginX + (marginX+width)*(i%2);
        CGFloat y = marginY + (marginY+width)*(i/2);
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, width);
        btn.tag = 20 + i;
        [btn setBackgroundImage:kImageNamed(_moduleBtnArray[i]) forState:UIControlStateNormal];
//        btn.backgroundColor = kBlueColor;
        [view addSubview:btn];
        [btn addTarget:self action:@selector(courseModuleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * label = [UILabel new];
        label.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame) + 5, width, 20);
        [view addSubview:label];
        label.text = _moduleTitleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
    }
    view.hidden = YES;
    _moduleView = view;

}

- (void)courseModuleBtnClick:(UIButton *)sender {
    NSLog(@"coursemodule - %ld", sender.tag - 20);
    _module = _moduleBtnArray[sender.tag - 20];
    _moduleView.hidden = YES;
    [self.view sendSubviewToBack:_moduleView];
    _classTF.placeholder = _moduleTitleArray[sender.tag - 20];
}

#pragma mark - 发布课程
- (void)publishBtnClick:(UIButton *)sender {
    NSLog(@"publishBtnClick");
}

#pragma mark - 请选择分类
- (void)classBtnClick:(UIButton *)sender {
    NSLog(@"classBtnClick");
    _moduleView.hidden = NO;
    [self.view bringSubviewToFront:_moduleView];
}

#pragma mark - 选项按钮
- (void)optionBtnClick:(UIButton *)sender {
    if (sender.tag == 11) {
        [self.view sendSubviewToBack:_guigeView];
        [self.view bringSubviewToFront:_priceView];
    } else {
        [self.view sendSubviewToBack:_priceView];
        [self.view bringSubviewToFront:_guigeView];
    }
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
