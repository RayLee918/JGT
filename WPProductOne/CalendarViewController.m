//
//  CalendarViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/8/22.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
{
    __block MBProgressHUD * _hud;
}

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hud showAnimated:YES];
    
//    NSString * str = @"http://192.168.1.131:8080/jgt/downLoad/download?fileid=258e371a85fb4478808a744892211e1a.pdf";
//    [self downloadPDF:str];
//    [self downloadFile:str];

}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"RayLee";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

//下载文件
- (void)downloadFile:(NSString *)downLoadUrl{
    
    NSURL * url = [NSURL URLWithString:downLoadUrl
                   ];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    NSURLSessionDownloadTask * task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress - - %lld, %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self loadDocument:filePath.relativePath];
    }];
    [task resume];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"日历";
}

// 下载文件或者打开文件
- (void)downloadPDF:(NSString *)downloadUrl {
    NSArray * arr = [downloadUrl componentsSeparatedByString:@"="];
    NSString * fileName = [arr lastObject];
    if ([self isFileExist:fileName]) {
        NSLog(@"存在");
        //获取Documents 下的文件路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        [self loadDocument:filePath];
    } else {
        NSLog(@"不存在");
        [self downloadFile:downloadUrl];
    }
}


// 下载好的文件用UIWebView显示
-(void)loadDocument:(NSString *)documentName
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight)];
    webView.backgroundColor = kWhiteColor;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL fileURLWithPath:documentName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

// 判断沙盒中是还存在此文件
-(BOOL) isFileExist:(NSString *)fileName
{
    //获取Documents 下的文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL result = [fileManager fileExistsAtPath:filePath];
    
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    
    return result;
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
