//
//  UploadViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/24.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "UploadViewController.h"


@interface UploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView {
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(0, 0, kScreentWidth, 60);
    [self.view addSubview:label];
    label.text = @"请上传开户人的有效身份证件";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = kColor(0x1F1F1F);
    label.textAlignment = NSTextAlignmentCenter;
    
    // 正面上传
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((kScreentWidth - 339) / 2, CGRectGetMaxY(label.frame), 339, 170);
    [self.view addSubview:btn1];
    btn1.tag = 11;
    [btn1 setBackgroundImage:[UIImage imageNamed:@"upload_card_1.png"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
//    btn1.backgroundColor = kRedColor;
    
    // 反面上传
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake((kScreentWidth - 339) / 2, CGRectGetMaxY(btn1.frame) + 10, 339, 170);
    [self.view addSubview:btn2];
    btn2.tag = 12;
    [btn2 setBackgroundImage:[UIImage imageNamed:@"upload_card_2.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
//    btn2.backgroundColor = kBlueColor;
}

- (void)btn1Click:(UIButton *)sender {
    NSLog(@"btn1Click");
    [self uploadImage:sender];
}

- (void)uploadImage:(UIButton *)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 从图库选取
    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        imagePicker.view.tag = sender.tag;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        NSLog(@"haha - %d", [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]);
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)btn2Click:(UIButton *)sender {
    NSLog(@"btn2Click");
    [self uploadImage:sender];
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
    
    // 上传头像图片
    NSString * urlStr = [NSString stringWithFormat:@"%@/upload/image", kJGT];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1) name:@"file" fileName:@"png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIButton * uploadBtn = (UIButton *)[self.view viewWithTag:picker.view.tag];
        [uploadBtn setBackgroundImage:image forState:UIControlStateNormal];
        [self showAlert:[responseObject objectForKey:kMsg]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error - %@", error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)showAlert:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"上传证件";
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
