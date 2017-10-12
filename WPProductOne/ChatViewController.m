//
//  ChatViewController.m
//  WPProductOne
//
//  Created by ZeroHour on 2017/9/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import "MyLetterCell.h"
#import "FriendLetterCell.h"

@interface ChatViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, NIMChatManagerDelegate>
{
    UITextField * _tf;
    UIView * _backgroundView;
    
    UITextField * _tf2;
    UIView * _backgroundView2;
    
    UITableView * _chatTableView;
    NSMutableArray * _chatDataSource;
    
    NSString * _imId;
    NSString * _headPic;
    NSString * _nickName;
    NSString * _isLecturer;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary * userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUser];
    _headPic = userInfo[kHeadPic];
    _nickName = userInfo[kNickName];
    _isLecturer = userInfo[kIsLecturer];
//    _imId = userInfo[kIMAccId];
    _imId = @"18233989613tdig";
    NSLog(@"imid- %@", _imId);
    
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    
    // 初始数据
    _chatDataSource = [NSMutableArray arrayWithCapacity:0];
    
    // 初始视图
    [self initView];
    [self setupTableView];
    
    // 历史记录
    [self getChatHistory];
}

- (void)getChatHistory {
    NIMSession * session = [NIMSession session:self.team.teamId type:NIMSessionTypeTeam];
    NIMHistoryMessageSearchOption * option = [NIMHistoryMessageSearchOption new];
    option.limit = 20;
    [[NIMSDK sharedSDK].conversationManager fetchMessageHistory:session option:option result:^(NSError * _Nullable error, NSArray<NIMMessage *> * _Nullable messages) {

        NSLog(@"history - %ld", messages.count);
//        for (NIMMessage * m in messages) {
//            
//            NSLog(@"getChatHistory - %@", m.text);
//        }
            [_chatDataSource addObjectsFromArray:messages.reverseObjectEnumerator.allObjects];
            [_chatTableView reloadData];
            // 滚动到底部
        if (_chatDataSource.count > 0) {
            [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatDataSource.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}

- (void)dealloc {
    [[NIMSDK sharedSDK].chatManager removeDelegate:self];
}

#pragma mark - 发送消息
- (void)sendMsg:(NSString *)msg {
    // ------------------- 发送消息 -------------------
    // 构造出具体会话
    NIMSession * session = [NIMSession session:self.team.teamId type:NIMSessionTypeTeam];
    
    // 构造出具体消息
    NIMMessage * message = [[NIMMessage alloc] init];
    message.text = msg;
    
    // 设置消息成员属性
    NSDictionary * remoteExt = @{kHeadPic:_headPic, kNickName:_nickName, kIsLecturer:_isLecturer};
    message.remoteExt = remoteExt;
    
    // 错误反馈对象
    NSError *error = nil;
    
    // 发送消息
    [[NIMSDK sharedSDK].chatManager sendMessage:message toSession:session error:&error];
}

#pragma mark - NIMChatManagerDelegate
- (void)sendMessage:(NIMMessage *)message progress:(float)progress {
    NSLog(@"sendMessage - %f", progress);
}

- (void)sendMessage:(NIMMessage *)message didCompleteWithError:(NSError *)error {
    NSLog(@"didCompleteWithError - %@", error);

    [_chatDataSource addObject:message];
    [_chatTableView reloadData];
    
    NSLog(@"%ld", _chatDataSource.count);
    // 滚动到底部
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatDataSource.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
//        NSArray * indexPaths = @[[NSIndexPath indexPathForRow:_chatDataSource.count inSection:0]];
//        [_chatTableView beginUpdates];
//        [_chatTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//        [_chatTableView endUpdates];
    
    _tf2.text = @"";
    _tf.text = @"";
}

#pragma mark - 接收消息
- (void)onRecvMessages:(NSArray<NIMMessage *> *)messages {
    NSLog(@"onRecvMessages - %@", messages);

    [_chatDataSource addObjectsFromArray:messages];
    NSLog(@"onRecvMessages - %@", _chatDataSource);
    [_chatTableView reloadData];
    // 滚动到底部
    [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatDataSource.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)setupTableView {
    
    CGRect frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight - 64);
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _chatTableView = tableView;
    tableView.backgroundColor = kColor(0xF3F4F5);
//    tableView.userInteractionEnabled = NO;
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chatDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NIMMessage * message = _chatDataSource[indexPath.row];
    // 自适应高度
    UILabel * label = [UILabel new];
    label.frame = CGRectMake(20, 10, kScreentWidth - 60 - 68 - 35, 40);
    label.numberOfLines = 0;
    label.text = message.text;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    
    return size.height + 20 + 10 + 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell_myLetter";
    static NSString * identifier2 = @"cell_friendLetter";
    
    NIMMessage * message = _chatDataSource[indexPath.row];
    if ([message.from isEqualToString:_imId]) {
        MyLetterCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MyLetterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.message = message;
        return cell;
    } else {
        FriendLetterCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[FriendLetterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        cell.message = message;
        return cell;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)initView {
    
    // 只是用来显示
    UIView * backgroundView = [UIView new];
    backgroundView.frame = CGRectMake(0, kScreentHeight - kTabbarHeight - kMargin64, kScreentWidth, 44);
    [self.view addSubview:backgroundView];
    backgroundView.backgroundColor = kColor(0xF3F4F5);
    _backgroundView = backgroundView;
    
    UITextField * tf = [UITextField new];
    _tf = tf;
    tf.frame = CGRectMake(15, 7, kScreentWidth - 45 - 50, 30);
    [backgroundView addSubview:tf];
    tf.backgroundColor = kWhiteColor;
    tf.layer.cornerRadius = 5;
    tf.layer.masksToBounds = YES;
    tf.placeholder = @"我来说两句...";
    tf.delegate = self;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreentWidth - 50 - 10, CGRectGetMinY(tf.frame), 50, 30);
    [backgroundView addSubview:btn];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = kColor(0xBA020D);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    // 真正的功能实现
    UIView * backgroundView2 = [UIView new];
    backgroundView2.frame = CGRectMake(0, kScreentHeight - kTabbarHeight - kMargin64, kScreentWidth, 44);
    backgroundView2.backgroundColor = kColor(0xF3F4F5);
    _backgroundView2 = backgroundView2;
    
    UITextField * tf2 = [UITextField new];
    _tf2 = tf2;
    tf2.delegate = self;
    tf2.frame = CGRectMake(15, 7, kScreentWidth - 45 - 50, 30);
    [backgroundView2 addSubview:tf2];
    tf2.backgroundColor = kWhiteColor;
    tf2.layer.cornerRadius = 5;
    tf2.layer.masksToBounds = YES;
    tf2.placeholder = @"我来说两句...";
    tf.inputAccessoryView = _backgroundView2;
    tf2.delegate = self;
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(kScreentWidth - 50 - 10, CGRectGetMinY(tf.frame), 50, 30);
    [backgroundView2 addSubview:btn2];
    [btn2 setTitle:@"发送" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(sendBtnClick2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = kColor(0xBA020D);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    
    // 键盘监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 键盘将要显示
- (void)keyboardWillShow:(NSNotification *)noti
{
    NSLog(@"keyboard - %@", noti.userInfo);
    NSDictionary * dic = noti.userInfo;
    CGRect endRect = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    _chatTableView.frame = CGRectMake(0, 0, kScreentWidth, endRect.origin.y - 64);
    _chatTableView.contentOffset = CGPointMake(0, _chatTableView.contentSize.height - _chatTableView.frame.size.height);
    [_tf2 becomeFirstResponder];
}

#pragma mark - 键盘将要隐藏
- (void)keyboardWillHide:(NSNotification *)noti
{
    _chatTableView.frame = CGRectMake(0, 0, kScreentWidth, kScreentHeight - kTabbarHeight - 64);
    _tf.text = _tf2.text;
}

#pragma mark - 第一个发送按钮弹出键盘
- (void)sendBtnClick {
    NSLog(@"sendBtnClick");
    if (_tf.text.length > 0) {
        [self sendMsg:_tf.text];
    }
}

#pragma mark - 第二个发送按钮退出键盘
- (void)sendBtnClick2 {
    NSLog(@"sendBtnClick2");
    if (_tf2.text.length > 0) {
        [self sendMsg:_tf2.text];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _tf.text = _tf2.text;
    [self.view endEditing:YES];
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [CLTool globalSetting:self isNavigationBarHidden:NO backgroundColor:[UIColor whiteColor] title:self.team.teamName];
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tabbarView.hidden = YES;

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
