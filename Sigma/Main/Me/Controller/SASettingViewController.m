//
//  SASettingViewController.m
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "SASettingViewController.h"
#import "SASettingViewEngine.h"
#import "SASettingTableViewCell.h"
#import "SASettingCell.h"

#import "SASettingAboutViewController.h"

#import <MessageUI/MessageUI.h>


#define MINE_SETTINGS_ICON @"Mine_Settings_Gray"
#define HEIGHT_BASIC_INFO_OF_HEADER_VIEW 66

#define HEIGHT_TABBAR 49 //self.tabBar.frame.size.height为49
#define HEIGHT_NAVIGATIONBAR 64
#define HEIGHT_BUTTON 44
#define HEIGHT_TABLE_HEADER_VIEW 110+HEIGHT_BASIC_INFO_OF_HEADER_VIEW
#define MARGIN 15
#define IMAGE_REC_SIZE 65

@interface SASettingViewController ()<UITableViewDataSource, UITableViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,SASettingTableViewCellDelegate>

@property(nonatomic,strong)UITableView* settingTableView;

@property(nonatomic,strong)NSArray *dataArray1;
@property(nonatomic,strong)NSArray *dataArray2;
@property(nonatomic,strong)NSArray *dataArray3;

@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UIButton *exitButton;

@end

@implementation SASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray1 = [[SASettingViewEngine shareInstance] dataSection1];
    self.dataArray2 = [[SASettingViewEngine shareInstance] dataSection2];
    self.dataArray3 = [[SASettingViewEngine shareInstance] dataSection3];
    
    if ([self isExisted:self.dataArray1]&&[self isExisted:self.dataArray2]&&[self isExisted:self.dataArray3]) {
        [self.settingTableView reloadData];
    }
}

-(BOOL)isExisted:(NSArray*)array{
    if (array&&array.count>0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.view.backgroundColor=[UIColor colorWithWhite:0.969 alpha:1.000];

    [self initUI];
    self.title=@"设置";
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - Initialize UI
-(void)initUI{
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.settingTableView];
}

-(UITableView*)settingTableView{
    if (!_settingTableView) {
        _settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATIONBAR, SCREEN_WIDTH, SCREEN_HEIGHT-HEIGHT_NAVIGATIONBAR) style:UITableViewStyleGrouped];
        
        _settingTableView.showsHorizontalScrollIndicator = NO;
        _settingTableView.showsVerticalScrollIndicator = YES;
        
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        
        
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_NAVIGATIONBAR)];
        [_settingTableView.tableFooterView addSubview:self.footerView];
        
    }
    return _settingTableView;
}

-(UIView*)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_NAVIGATIONBAR)];
        
        [_footerView addSubview:self.exitButton];
    }
    return _footerView;
}

- (UIButton*)exitButton{
    if (!_exitButton) {
        
        _exitButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.frame=CGRectMake(MARGIN,0, SCREEN_WIDTH-MARGIN*2, HEIGHT_BUTTON);
        
        _exitButton.layer.cornerRadius = 20;

        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:0.900]];
//        [_exitButton setTitleColor:[UIColor colorWithWhite:0.702 alpha:1.000] forState:UIControlStateHighlighted];
        _exitButton.showsTouchWhenHighlighted=YES;
        
        [_exitButton addTarget:self action:@selector(exitBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _exitButton;
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该设备不支持短信功能!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)showMailView:(NSArray *)mail subject:(NSString *)subject body:(NSString *)body
{
    if( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        [mailCompose setMailComposeDelegate:self];
        [mailCompose setSubject:subject];
        [mailCompose setToRecipients:mail];
        [mailCompose setMessageBody:body isHTML:NO];

        [self presentViewController:mailCompose animated:YES completion:nil];
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该设备不支持邮件功能!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return [self.dataArray1 count];
        }
            break;
        case 1:
        {
            return [self.dataArray2 count];
        }
            break;
        case 2:
        {
            return [self.dataArray3 count];
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIndentifier = @"mycell";
    
    SASettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (!cell) {
        cell = [[SASettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        cell.delegate = self;
    }
    
    if(indexPath.section == 0){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray1 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 1){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray2 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }else if (indexPath.section == 2){
        SASettingCell* cellSection = (SASettingCell*)[self.dataArray3 objectAtIndex:indexPath.row];
        SASettingCell* data = [[SASettingCell alloc] init];
        
        data.title = cellSection.title;
        data.additionInfo = cellSection.additionInfo;
        
        cell.data = data;
        
        [cell showMineCell];
    }
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
            {
//                NSMutableString *mailUrl = [[NSMutableString alloc]init];
//                [mailUrl appendString:@"mailto:411311603@qq.com"];
//                //添加主题
//                [mailUrl appendString:@"?subject=意见反馈"];
//                
//                //添加邮件内容
//                [mailUrl appendString:@"&body=xx部分存在问题"];
//                
//                NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//                [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];

                [self showMailView:[NSArray arrayWithObject: @"411311603@qq.com"] subject:@"Feedback" body:@"Problem"];
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                [self showMessageView:nil title:@"Share" body:@"New Sigma app available! http://www.baidu.com"];
            }
                break;
            default:
                break;
        }
        
    }else if (indexPath.section==2){
        switch (indexPath.row) {
            case 0:
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你确定要清除缓存吗？" message:@"缓存数据有助于再次浏览或离线查看" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* cancleAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *cancleAction){
                    NSLog(@"Cancle");
                }];
                
                UIAlertAction* yesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *yesAction){
                    NSLog(@"Yes");
                }];
                [alert addAction:cancleAction];
                [alert addAction:yesAction];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
                break;
            case 1:
            {
                //                WebViewController *webVc = [WebViewController webVCWithUrlStr:@"/help/doc/mobile/index.html"];
                //                [self.navigationController pushViewController:webVc animated:YES];
            }
                break;
            case 2:
            {
                SASettingAboutViewController *vc=[[SASettingAboutViewController alloc]init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

/**
 *  section中header的高度
 *
 *  @param tableView
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 16;
    }
    return 8;
}

/**
 *  section中footer的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 16;
    }
    return 8;
}

/**
 *  cell中每行的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

#pragma mark - MFMessageComposeViewController

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Click/Tap Event

- (void)exitBtnClickHandler:(id)sender {
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"确定退出吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancleAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *cancleAction){
            NSLog(@"Cancle");
        }];
        
        
        UIAlertAction* yesAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *yesAction){
            NSLog(@"Yes");
        }];
        [alert addAction:cancleAction];
        [alert addAction:yesAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

@end

