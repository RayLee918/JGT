//
//  RegisterViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/25.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "RegisterViewController.h"
#import "RemarkViewController.h"

#pragma mark - UIScrollView的分类
@interface UIScrollView (UITouch)

@end

@implementation UIScrollView (UITouch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
}

@end

@interface RegisterViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

{
    UITextField * _nicknameTf;
    UITextField * _numberTF;
    UITextField * _pwdTF;
    UITextField * _subcribeTF;
    UIButton * _uploadImageBtn;
    
    // 头像
    UIImage * _headImage;
    NSString * _headImageStr;
    
    NSString * _isTeacher;
    UIButton * _teacherBtn;
    UIButton * _studentBtn;
    
    NSString * _pageCode;
    NSTimer * _timer;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isTeacher = @"0";
    _pageCode = @"";
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"快速注册";
}

- (void)initView {
    
    UIScrollView * scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight);
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(kScreentWidth, kScreentHeight + 200);
    scrollView.showsVerticalScrollIndicator = NO;
    
    // 返回按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    // 标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(30, 20, kScreentWidth - 60, 44);
    [scrollView addSubview:titleLabel];
    titleLabel.textColor = kColor(0x1F1F1F);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"请设置头像、昵称, 方便朋友认出你";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 上传头像按钮
    
    UIButton * uploadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadImageBtn.frame = CGRectMake((kScreentWidth - 79) / 2, CGRectGetMaxY(titleLabel.frame) + 25, 79, 79);
    [scrollView addSubview:uploadImageBtn];
//    uploadImageBtn.backgroundColor = kGlobalColor;
    [uploadImageBtn addTarget:self action:@selector(uploadImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [uploadImageBtn setBackgroundImage:kImageNamed(@"upload_head") forState:UIControlStateNormal];
    _uploadImageBtn = uploadImageBtn;
//    [_uploadImageBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"http://192.168.1.131:8080/jgt/downLoad/img?objKey=/image/2017/08/31/47e72b0465d547aeb8f28c5177e28c72.png"]];
    
//    UIImageView * uploadImageView = [UIImageView new];
//    uploadImageView.frame = CGRectMake((kScreentWidth - 79) / 2, CGRectGetMaxY(titleLabel.frame) + 25  +79, 79, 79);
//    [self.view addSubview:uploadImageView];
//    uploadImageView.image = [UIImage imageNamed:@""];
//    uploadImageView.backgroundColor = kRedColor;
//    [uploadImageView setImageWithURL:[NSURL URLWithString:@"http://192.168.1.131:8080/jgt/downLoad/img?objKey=/image/2017/08/31/47e72b0465d547aeb8f28c5177e28c72.png"]];
//    NSLog(@"-- %@", uploadImageView.image);
    
    // 昵称
    UILabel * nameLabel = [UILabel new];
    nameLabel.frame = CGRectMake(20, CGRectGetMaxY(uploadImageBtn.frame) + 25, 96, 48);
    [scrollView addSubview:nameLabel];
    nameLabel.textColor = kColor(0x1F1F1F);
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"昵称";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * nameTF = [UITextField new];
    nameTF.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMinY(nameLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:nameTF];
    nameTF.placeholder = @"例如\"王东方\"";
    nameTF.delegate = self;
    _nicknameTf = nameTF;
    
    UIView * line1 = [UIView new];
    line1.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame), kScreentWidth, 1);
    [scrollView addSubview:line1];
    line1.backgroundColor = kColor(0xF7F7F7);
    
    // 手机号
    UILabel * numberLabel = [UILabel new];
    numberLabel.frame = CGRectMake(20, CGRectGetMaxY(line1.frame) + 1, 96, 48);
    [scrollView addSubview:numberLabel];
    numberLabel.textColor = kColor(0x1F1F1F);
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"+86";
    numberLabel.textAlignment = NSTextAlignmentLeft;
    
    UITextField * numberTF = [UITextField new];
    numberTF.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame), CGRectGetMinY(numberLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:numberTF];
    numberTF.placeholder = @"请填写手机号";
    numberTF.keyboardType = UIKeyboardTypeNumberPad;
    numberTF.delegate = self;
    _numberTF = numberTF;
    
    
    UIView * line2 = [UIView new];
    line2.frame = CGRectMake(0, CGRectGetMaxY(numberLabel.frame), kScreentWidth, 1);
    [scrollView addSubview:line2];
    line2.backgroundColor = kColor(0xF7F7F7);
    
    // 验证码
    UITextField * subcribeTF = [UITextField new];
    subcribeTF.frame = CGRectMake(20, CGRectGetMaxY(line2.frame), kScreentWidth - 40, 48);
    [scrollView addSubview:subcribeTF];
    subcribeTF.placeholder = @"请输入验证码";
    _subcribeTF = subcribeTF;
    
    // 获取验证码
    UIButton * subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subscribeBtn.frame = CGRectMake(kScreentWidth - 10 - 135, CGRectGetMinY(subcribeTF.frame) + (48 - 37) / 2, 135, 37);
    [scrollView addSubview:subscribeBtn];
//    subscribeBtn.backgroundColor = kGlobalColor;
    [CLTool gradualBackgroundColor:subscribeBtn];
    subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [subscribeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    subscribeBtn.layer.cornerRadius = 10;
    
    UIView * line3 = [UIView new];
    line3.frame = CGRectMake(0, CGRectGetMaxY(subcribeTF.frame), kScreentWidth, 1);
    [scrollView addSubview:line3];
    line3.backgroundColor = kColor(0xF7F7F7);
    
    // 登录密码
    UILabel * pwdLabel = [UILabel new];
    pwdLabel.frame = CGRectMake(20, CGRectGetMaxY(line3.frame) + 1, 96, 48);
    [scrollView addSubview:pwdLabel];
    pwdLabel.textColor = kColor(0x1F1F1F);
    pwdLabel.font = [UIFont systemFontOfSize:15];
    pwdLabel.text = @"登录密码";
    pwdLabel.textAlignment = NSTextAlignmentLeft;
    
    // 密码输入框
    UITextField * pwdTF = [UITextField new];
    pwdTF.frame = CGRectMake(CGRectGetMaxX(pwdLabel.frame), CGRectGetMinY(pwdLabel.frame), kScreentWidth - 96 - 18 - 20, 48);
    [scrollView addSubview:pwdTF];
    pwdTF.placeholder = @"组合字母、数字或符号";
    pwdTF.secureTextEntry = YES;
    _pwdTF = pwdTF;
    
    UIButton * pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pwdBtn.frame = CGRectMake(kScreentWidth - 44, CGRectGetMinY(pwdTF.frame), 44, 44);
    [scrollView addSubview:pwdBtn];
//    pwdBtn.backgroundColor = kGlobalColor;
    [pwdBtn addTarget:self action:@selector(pwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pwdBtn setImage:kImageNamed(@"pwd.png") forState:UIControlStateNormal];
    
    // 分割线
    UIView * line4 = [UIView new];
    line4.frame = CGRectMake(0, CGRectGetMaxY(pwdLabel.frame), kScreentWidth, 1);
    [scrollView addSubview:line4];
    line4.backgroundColor = kColor(0xF7F7F7);
    
    // 老师
    UIButton * teacherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    teacherBtn.frame = CGRectMake((kScreentWidth - 150) / 4, CGRectGetMaxY(line4.frame) + 20, 100, 30);
    [scrollView addSubview:teacherBtn];
    [teacherBtn setTitle:@"讲师" forState:UIControlStateNormal];
    teacherBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [teacherBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    [teacherBtn addTarget:self action:@selector(teacherBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    teacherBtn.layer.cornerRadius = 5;
    teacherBtn.layer.borderColor = kGlobalColor.CGColor;
    teacherBtn.layer.borderWidth = 0.5;
    _teacherBtn = teacherBtn;
    
    
    // 学生
    UIButton * studentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    studentBtn.frame = CGRectMake((kScreentWidth - 150) / 4 + kScreentWidth / 2, CGRectGetMaxY(line4.frame) + 20, 100, 30);
    [scrollView addSubview:studentBtn];
    [studentBtn setTitle:@"普通用户" forState:UIControlStateNormal];
    studentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [studentBtn setTitleColor:kColor(0xB0B0B0) forState:UIControlStateNormal];
    [studentBtn addTarget:self action:@selector(studentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    studentBtn.layer.cornerRadius = 5;
    studentBtn.layer.borderColor = kGlobalColor.CGColor;
    studentBtn.layer.borderWidth = 0.5;
    _studentBtn = studentBtn;
    
    // 注册
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(30, CGRectGetMaxY(teacherBtn.frame) + 20, kScreentWidth - 60, 44);
    [CLTool gradualBackgroundColor:registerBtn];
    [scrollView addSubview:registerBtn];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 备注
    UILabel * remarkLabel1 = [UILabel new];
    remarkLabel1.frame = CGRectMake(0, CGRectGetMaxY(registerBtn.frame) + 25, kScreentWidth, 20);
    [scrollView addSubview:remarkLabel1];
    remarkLabel1.textColor = kColor(0x898989);
    remarkLabel1.font = [UIFont systemFontOfSize:14];
    remarkLabel1.text = @"点击\"注册\"按钮, 即表示";
    remarkLabel1.textAlignment = NSTextAlignmentCenter;
    
    UILabel * remarkLabel2 = [UILabel new];
    remarkLabel2.frame = CGRectMake(0, CGRectGetMaxY(remarkLabel1.frame), kScreentWidth, 20);
    [scrollView addSubview:remarkLabel2];
    remarkLabel2.textColor = kColor(0x898989);
    remarkLabel2.font = [UIFont systemFontOfSize:14];
    remarkLabel2.textAlignment = NSTextAlignmentCenter;
    
    NSString * str = @"你同意荐股网服务协议";
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mStr addAttribute:NSForegroundColorAttributeName value:kGlobalColor range:NSMakeRange(str.length - 7, 7)];
    remarkLabel2.attributedText = mStr;
    
    UIButton * remarkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    remarkBtn.frame = CGRectMake(0, CGRectGetMinY(remarkLabel1.frame), kScreentWidth, 40);
    [self.view addSubview:remarkBtn];
    [remarkBtn addTarget:self action:@selector(remarkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 老师学生选项
- (void)teacherBtnClick:(UIButton *)sender {
    _isTeacher = @"1";
    _studentBtn.backgroundColor = kWhiteColor;
    sender.backgroundColor = kGlobalColor;
}

- (void)studentBtnClick:(UIButton *)sender {
    _isTeacher = @"0";
    _teacherBtn.backgroundColor = kWhiteColor;
    sender.backgroundColor = kGlobalColor;
}

#pragma mark - 密码显示隐藏
- (void)pwdBtnClick {
    _pwdTF.secureTextEntry = !_pwdTF.secureTextEntry;
}

#pragma mark - 上传头像
- (void)uploadImageBtnClick {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 从图库选取
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        NSLog(@"手机相册选取 - %d", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:NULL];
            NSLog(@"拍照 - %d", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]);
        }
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - imagePicker delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage * image = nil;
    if (![info objectForKey:UIImagePickerControllerEditedImage]) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    _headImage = image;
    [_uploadImageBtn setBackgroundImage:_headImage forState:UIControlStateNormal];
    
    // 上传头像图片
    NSString * urlStr = [NSString stringWithFormat:@"%@/upload/image", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(_headImage, 0.5) name:@"file" fileName:@"png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success - %@", responseObject);
        _headImageStr = [responseObject objectForKey:kData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 退出键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 注册
- (void)registerBtnClick:(UIButton *)sender {
    NSLog(@"registerBtnClick");
    if (_nicknameTf.text.length >= 1) {
        if (_numberTF.text.length == 11) {
            if (_subcribeTF.text.length >= 1) {
                if (_pwdTF.text.length >= 6) {
                    if (_isTeacher.length == 1) {
                        NSString * headImageStr = @"";
                        if (_headImageStr.length != 0) {
                            headImageStr = _headImageStr;
                        }
                        NSDictionary * params = @{@"nickName":_nicknameTf.text, @"password":_pwdTF.text, @"token":@"", @"mac":[[NSUserDefaults standardUserDefaults] valueForKey:@"device"], @"phone":_numberTF.text, @"headPic":headImageStr, @"isLecturer":_isTeacher, @"inputCode":_subcribeTF.text, @"pageCode":_pageCode};
                        NSString * urlStr = [NSString stringWithFormat:@"%@/regOrLog/regUser", kJGT];
                        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                        [manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                            
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"status - %@, %@", [responseObject objectForKey:kStatus], [responseObject objectForKey:kMsg]);
                            if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                                [alert addAction:[UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    NSLog(@"返回登录界面 - -");
                                    // 返回登录界面
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                    });
                                }]];
                                [self presentViewController:alert animated:YES completion:nil];
                            } else {
                                [self showAlert:[responseObject objectForKey:@"msg"]];
                            }
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"error - %@", error);
                        }];
                    } else {
                        [self showAlert:@"请选择用户类别"];
                    }
                } else {
                    [self showAlert:@"密码至少为6位"];
                }
            } else {
                [self showAlert:@"验证码不能为空"];
            }
        } else {
            [self showAlert:@"手机号为11位"];
        }
    } else {
        [self showAlert:@"昵称不能为空"];
    }
}

- (void)showAlert:(NSString *)message {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil]];
}

#pragma mark - 获取验证码
- (void)subscribeBtnClick:(UIButton *)sender {
    NSLog(@"subscribeBtnClick");
    if (_numberTF.text.length == 11) {
        
        // 获取验证码
        NSString * urlStr = [NSString stringWithFormat:@"%@/regOrLog/sendCode", kJGT];
        [[AFHTTPSessionManager manager] GET:urlStr parameters:@{@"type":@"1", @"phone":_numberTF.text} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:kStatus] integerValue] == 1) {
                _pageCode = [responseObject objectForKey:kData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        // 获取验证码按钮展示
        __block NSInteger value = 60;
        sender.userInteractionEnabled = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"subscribeBtnClick - %ld", value);
            NSString * str = [NSString stringWithFormat:@"%ld重新获取", --value];
            if (value == 0) {
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                [_timer invalidate];
            } else {
                [sender setTitle:str forState:UIControlStateNormal];
            }
        }];
    } else {
        [CLTool showAlert:@"填写手机号" target:self];
    }
}

#pragma mark - 服务协议
- (void)remarkBtnClick:(UIButton *)sender {
    RemarkViewController * remarkVC = [RemarkViewController new];
    [self.navigationController pushViewController:remarkVC animated:YES];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"didEndEditing --------");
    if (textField == _nicknameTf) {
        if (textField.text.length >= 1) {
            NSDictionary * params = @{@"nickName":_nicknameTf.text};
            [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/validateName", kJGT] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!([[responseObject objectForKey:kStatus] integerValue] == 1)) {
                    [self showAlert:[responseObject objectForKey:kMsg]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"endEdit --- %@", error);
            }];
        } else {
            [self showAlert:@"昵称不能为空"];
        }
    }else if (textField == _numberTF) {
        if (textField.text.length == 11) {
            NSDictionary * params = @{@"phone":_numberTF.text};
            [[AFHTTPSessionManager manager] GET:[NSString stringWithFormat:@"%@/regOrLog/validatePhone", kJGT] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (!([[responseObject objectForKey:kStatus] integerValue] == 1)) {
                    
                    [self showAlert:[responseObject objectForKey:kMsg]];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        } else {
            [self showAlert:@"手机号为11位"];
        }
    }
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
