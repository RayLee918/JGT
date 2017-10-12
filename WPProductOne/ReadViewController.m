//
//  ReadViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/19.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "ReadViewController.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self downloadPDF:self.courseDoc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.courseName;
}

#pragma mark - 下载的文档处理
//下载文件
- (void)downloadFile:(NSString *)downLoadUrl{
    
    NSURL * url = [NSURL URLWithString:downLoadUrl
                   ];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask * task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress - - %lld, %lld", downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString * fileName = [[downLoadUrl componentsSeparatedByString:@"="] lastObject];
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self loadDocument:filePath.relativePath];
    }];
    [task resume];
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
