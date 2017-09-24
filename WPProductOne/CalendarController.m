//
//  CalendarController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/18.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "CalendarController.h"

@interface CalendarController ()

@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLSessionConfiguration * configuration = [ NSURLSessionConfiguration  defaultSessionConfiguration ];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc ] initWithSessionConfiguration:configuration];
    
//    NSURL * url = [ NSURL  URLWithString:@"http://192.168.1.131:8080/jgt/downLoad/download?fileid=258e371a85fb4478808a744892211e1a.pdf"];
    NSURL * url = [NSURL URLWithString:@"https://wkbos.bdimg.com/v1/wenku78//b75c57edceae561944c7f26d898dd418?responseContentDisposition=attachment%3B%20filename%3D%22JAVA-%E8%AF%95%E9%A2%98.pdf%22&responseContentType=application%2Foctet-stream&responseCacheControl=no-cache&authorization=bce-auth-v1%2Ffa1126e91489401fa7cc85045ce7179e%2F2017-09-18T07%3A48%3A29Z%2F3600%2Fhost%2Fb2274ce50f8583c6a688d182a0f6cff0cd3dcac2c468c0468f3656a6ab93a50a&token=090b8a17c1aabd2d28fa4df8c92187c2a6a9270d92d318150134255a8f50463c&expire=2017-09-18T08:48:29Z"];
    NSURLRequest * request = [ NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest: request progress:^(NSProgress *downloadProgress){
        NSLog(@"process - %.f", downloadProgress.fractionCompleted * 100);
    } destination: ^ NSURL *(NSURL * targetPath, NSURLResponse * response){
        NSURL * documentsDirectoryURL = [[ NSFileManager  defaultManager ] URLForDirectory:NSDocumentDirectory  inDomain:NSUserDomainMask  appropriateForURL:nil  create:NO  error:nil ];
        return [documentsDirectoryURL URLByAppendingPathComponent: [response suggestedFilename]];
    } completionHandler:^(NSURLResponse * response,NSURL * filePath, NSError * error){
        NSLog(@"%@", filePath);
    }];
   [downloadTask resume ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = kWhiteColor;
    self.title = @"日历";
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
