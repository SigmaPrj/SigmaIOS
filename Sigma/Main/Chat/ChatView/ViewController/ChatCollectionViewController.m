//
//  ChatCollectionViewController.m
//  KeyBoardView
//
//

#import "ChatCollectionViewController.h"
#import "SpringCollectionFlowLayout.h"
#import "ChatCollectionCell.h"
#import "ChatCollectionTimeCell.h"
#import "ChatHelp.h"
#import "ChatDemoDataSourceHelper.h"
#import "MessageSendHelper.h"

#import "BubblePressHandleHelper.h"

#import "ChatCollectionViewController+Helper.h"
#import "MediaAttachmentHelper.h"
#import "CacheHelper.h"
#import "IMServiceHelper.h"
#import "NSDate+Addition.h"

#import "DownloadFileHelper.h"
#import "SATeamRequest.h"
#import "CLProgressHUD.h"
#import "SAChatModel.h"

@interface ChatCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,VoiceReordingDelegate,TextInputDelegate,MoreViewDelegate,EmotionViewDelegate,chatCellClickDelegate,IMServiceDelegate>

@property(nonatomic,strong) UICollectionView *chatCollectionView;


@property(nonatomic,strong) KeyBoardView *keyBoardView;
@property(nonatomic,strong) VoiceRecordHelper *voiceRecordHelper;

@property(nonatomic,strong) NSMutableArray *chatFakeMessages;


//上一次点击音频indexPath
@property(nonatomic,strong) NSIndexPath *lastVoiceIndexPath;
//上一次消息发送接收时间
@property(nonatomic,strong) NSString *lastMessageDate;

// 用户头像
@property (nonatomic, copy) NSString *rightAvatar;
@property (nonatomic, copy) NSString *leftAvatar;
// 用户username
@property (nonatomic, copy) NSString *rightUsername;
@property (nonatomic, copy) NSString *leftUsername;
// 用户id
@property (nonatomic, assign) NSInteger rightUserId;
@property (nonatomic, assign) NSInteger leftUserId;

@end

@implementation ChatCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChatBackground"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"接收消息" style:UIBarButtonItemStylePlain target:self action:@selector(insertMessage:)];
    
    
    [self.view addSubview:self.chatCollectionView];
    
    [self.view addSubview:self.keyBoardView];
    [self.chatCollectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];


#pragma mark --- 废弃用通知监听imServie层的监听，采用代理方式实行
    //废弃api:
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveMessage:) name:KReceiveMessageNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didSendMessage:) name:KDidSendMessageNotification object:nil];


    //imService的代理，得到所有im网络层的消息监听
    [IMServiceHelper helper].delegate = self;


    // Do any additional setup after loading the view.
    [self addAllNotifications];
    [self sendRequest];
}

- (void)sendRequest {
    [SATeamRequest requestMessagesOfUser:self.rightUserId sUser:self.leftUserId];
}

- (void)setLeftUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar {
    _leftUserId = userId;
    _leftUsername = username;
    _leftAvatar = avatar;
    self.title = username;
}

- (void)setRightUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar {
    _rightUserId = userId;
    _rightUsername = username;
    _rightAvatar = avatar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    if (self.lastVoiceIndexPath) {
        MessageModel *message = self.chatFakeMessages[self.lastVoiceIndexPath.item];
        message.isPlaying ? [self audioRecoderBubbleDidSelectedOnMessage:message] : nil;
    }
    
    
}


//模拟消息插入
- (void)insertMessage:(UIBarButtonItem *)item
{
     MessageModel *message = [ChatDemoDataSourceHelper getReceiveMessage];
    
    [self didReceiveMessage:(MessageServiceModel *)message];
    
}




NSString *const leftChatCollectionCellIdentifier = @"collectionCellleftCellId";
NSString *const rightChatCollectionCellIdentifier = @"collectionCellrightCellId";
NSString *const chatCollectionTimeCellIdentifier = @"collectiontimeCellId";
#pragma mark -- chatCollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.chatFakeMessages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = self.chatFakeMessages[indexPath.row];
    UICollectionViewCell *cell = nil;
    
    if ([obj isKindOfClass:[MessageModel class]]) {
        
        ChatCollectionCell *messageCell = (ChatCollectionCell *)cell;
        MessageModel *message = (MessageModel *)obj;
        if (message.isSender) {
            // 判断是否为 发起聊天的用户
            messageCell = [collectionView dequeueReusableCellWithReuseIdentifier:rightChatCollectionCellIdentifier forIndexPath:indexPath];

        }else{
            messageCell = [collectionView dequeueReusableCellWithReuseIdentifier:leftChatCollectionCellIdentifier forIndexPath:indexPath];
            
        }
        messageCell.message = message;
        messageCell.delegate = self;
        messageCell.backgroundColor = [UIColor whiteColor];

        return messageCell;
        
    }
    
    else
    {
        ChatCollectionTimeCell *timeCell = (ChatCollectionTimeCell *)cell;
        timeCell =  [collectionView dequeueReusableCellWithReuseIdentifier:chatCollectionTimeCellIdentifier forIndexPath:indexPath];
        NSString *time = (NSString *)obj;
        timeCell.time = time;
        
        timeCell.backgroundColor = [UIColor whiteColor];

        return timeCell;
    }
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = self.chatFakeMessages[indexPath.row];
    
    if ( [obj isKindOfClass:[MessageModel class]]) {
        return CGSizeMake(self.view.bounds.size.width, [ChatCollectionCell CellHeight:obj]);
    }
    
  return CGSizeMake(self.view.bounds.size.width,30);
    
}



//发送位置消息
- (void)sendLocationMessage:(CLLocation *)location address:(NSString *)address locationPhoto:(NSString *)locationPhoto
{
   LocationMessageModel *message = [LocationMessageModel LocalPositionPhoto:locationPhoto address:address location:location username:@"" timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
    message.avatarUrl = self.rightAvatar;
    
    
    [self sendMessage:message];
}




#pragma mark ---MoreViewClickDelegate
- (void)moreViewClick:(MoreViewType)type
{
    switch (type) {
        case MoreViewTypePhotoAblums:
            NSLog(@"相册");
        {
            [self pickerPhotoComplection:^(MediaType mediaType, NSData *data) {
        
                 [self handleMediaType:mediaType data:data];
             
            }];
            
        }
            
            break;
        case MoreViewTypePhotoLocation:
        {
            NSLog(@"位置");
            [self locationMapComplection:^(NSString *address,CLLocation *location,UIImage *locationPhoto,NSError *error) {
                if (!error) {
                    
                    [[MediaAttachmentHelper helper]imageHandle:UIImageJPEGRepresentation(locationPhoto, 1) completionCache:^(NSString *imagePath) {
                
                         [self sendLocationMessage:location address:address locationPhoto:imagePath];
                    }];
                   
                }
                
                else{
                    
                    NSLog(@"获取地址失败:%@",error);
                }
            }];
        }
       
            break;
        case MoreViewTypeTakePicture:
            NSLog(@"拍照/拍视频");
        {
             [self takePhotoOrVideoComplection:^(MediaType mediaType, NSData *data) {
                 
                 [self handleMediaType:mediaType data:data];
             }];
            
        }
            break;
        case MoreViewTypePhoneCall:
            NSLog(@"语音电话");
            
            break;
        case MoreViewTypeVideoCall:
            NSLog(@"视频通话");
            
            break;
            
        default:
            break;
    }
    
    
}





/**
 *  @brief 发送消息时选相册图片，拍照，视频的媒体内容处理
 *
 *  @param mediaType 媒体类型
 *  @param data      内容
 */
- (void)handleMediaType:(MediaType)mediaType data:(NSData *)data
{
    switch (mediaType)
    {
        case MediaTypePhoto:
        {
            
            
            //图片附件处理以及硬盘缓存
            [[MediaAttachmentHelper helper]imageHandle:data completionCache:^(NSString *imagePath) {
                
                PhotoMessageModel *message =  [PhotoMessageModel Photo:imagePath thumbnailUrl:nil originPhotoUrl:nil username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
                message.avatarUrl = self.rightAvatar;
                message.isGif = NO;
                
                
                [self sendMessage:message];
            }];
            
            
            break;
            
        }
            
            
            
        case MediaTypeVideo:
        {
            
            //音频附件处理以及硬盘缓存
            [[MediaAttachmentHelper helper]videoHandle:data completionCache:^(NSString *videoPath, NSString *videoThumbPath) {
                
            
                VideoMessageModel *message = [VideoMessageModel VideoThumbPhoto:videoThumbPath videoThumbUrl:nil videoUrl:nil username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
                message.avatarUrl = self.rightAvatar;
                message.isVideoCache = YES;
                message.locationVideoPath = videoPath;
                [self sendMessage:message];
            }];
            
            
            break;
        }
    }

}




#pragma mark ---voiceRecoder


//发送语音消息
- (void)sendVoiceRecoder:(NSString *)voiceRecoderPath voiceDuration:(NSString *)voiceDuration
{
    
    if ([voiceDuration floatValue] <1.0) {
        AlertShow(@"录音时间过短！");
        [[NSFileManager defaultManager]removeItemAtPath:voiceRecoderPath error:nil];
        return;
    }
    
    [[MediaAttachmentHelper helper]audioHandle:[NSData dataWithContentsOfFile:voiceRecoderPath] completionCache:^(NSString *audioPath) {
        
        //删除之前存的那个
        [[NSFileManager defaultManager]removeItemAtPath:voiceRecoderPath error:nil];
        
        VoiceMessageModel *message =  [VoiceMessageModel VoicePath:audioPath voiceUrl:nil voiceDuration:voiceDuration username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isRead:YES isSender:YES];
        message.isRead = NO;
        message.avatarUrl = self.rightAvatar;
        
        [self sendMessage:message];
        
        
        
    }];
}


- (void)pauseRecord
{
    
    [self.voiceRecordHelper pauseRecordingWithPauseRecorderCompletion:^{
        
    }];
}


- (void)resumeRecord
{
    [self.voiceRecordHelper resumeRecordingWithResumeRecorderCompletion:^{
        
    }];
    
}





- (VoiceRecordHelper *)voiceRecordHelper
{
    
    __weak typeof(self) weakSelf = self;
    if (!_voiceRecordHelper) {
        //   _isMaxTimeStop = NO;
        
        _voiceRecordHelper = [[VoiceRecordHelper alloc] init];
        _voiceRecordHelper.maxTimeStopRecorderCompletion = ^(NSString *path){
            NSLog(@"亲,到最大限制时间了！！");
            
            [weakSelf.voiceRecordHelper stopRecordingWithStopRecorderCompletion:^(NSString *path){
                
                [weakSelf sendVoiceRecoder:path voiceDuration:weakSelf.voiceRecordHelper.recordDuration];
                
            }];
        };
        _voiceRecordHelper.peakPowerForChannel = ^(float peakPowerForChannel) {
            
            
            weakSelf.keyBoardView.peakPower = peakPowerForChannel;
            
            
            
        };
        _voiceRecordHelper.maxRecordTime = kVoiceRecorderTotalTime;
    }
    return _voiceRecordHelper;
}




#pragma mark --- sendMessage
- (void)sendMessage:(MessageModel *)message
{
    message.messageId = [NSString stringWithFormat:@"%zd",arc4random_uniform(arc4random_uniform(1000)*arc4random_uniform(1000))];
    //先判断是否加入时间戳
    [self insertTimeMessage:message];
    
    
    
    
    //先加载到视图，再网络业务发送，成功后插入数据库
    
    
    //step1:updateUi
    message.deliveryState = MessageDeliveryStateDelivering;
    [self.chatFakeMessages addObject:message];
    [self.chatCollectionView reloadData];
    
    //接收消息自动滚动到当前可视区域取消
    
    //在colleview中因layout布局耗费时间，需要延时
    if ([message isKindOfClass:[MessageModel class]] &&  message.isSender ) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.chatCollectionView setContentOffset:CGPointMake(0, self.chatCollectionView.contentSize.height+self.keyBoardView.keyBoardDetalChange-SCREEN_HEIGHT+64) animated:YES];
        });
    }

    
    
    
    //服务层数据包装
    message.imMessage.from = @"";
    message.imMessage.to = @"";
    message.messageId = @"";
    
    
    switch (message.bubbleMessageBodyType) {
        case MessageBodyTypeText: {
            
            NSLog(@"messageSend  <Text>:%@",message.text);
            break;
        }
        case MessageBodyTypePhoto: {
            NSLog(@"messageSend <Photo>:%@",message.localPhotoPath);
            break;
        }
        case MessageBodyTypeVideo: {
            NSLog(@"messageSend <Video>:%@",message.videoThumbPhoto);
            break;
        }
        case MessageBodyTypeVoice: {
            NSLog(@"messageSend <Voice>:%@",message.voicePath);
            break;
        }
            
        case MessageBodyTypeLocation: {
            NSLog(@"messageSend <Location>:%@",message.location);
            break;
        }
    }
    

    
    
    //消息业务发送
    __block MessageModel *updateMessage = nil;
    [MessageSendHelper sendMessage:message completion:^(MessageServiceModel *serviceMessage) {
    
        //定位到ui上已经展示的那条消息，进行消息状态的更新
        for (MessageModel *message in self.chatFakeMessages) {
            
            if ([message isKindOfClass:[NSString class]]) {
                continue;
            }
            
            if ([message.messageId isEqualToString:serviceMessage.messageId]) {
                
                updateMessage = message;
                break;
            }
        }
        
        
        [self.chatCollectionView reloadData];
    }];
    
    
   self.lastMessageDate = message.timeStamp;
}



//********************************************IMService*********************************************/
#pragma mark --- IMServiceDelegate  
//IM业务层消息监听：收到消息，发送消息成功，添加好友申请

// 消息发送成功，通知监听:消息发送时消息ui提前跟新，网络成功后再实时更新当前状态

- (void)didSendMessage:(MessageServiceModel *)imMessage
{
    
    MessageModel *upDateMessage = nil;
    for (MessageModel *message in self.chatFakeMessages) {
        
        if ([message.imMessage.messageId isEqualToString:imMessage.messageId]) {
            
            upDateMessage = message;
            
            //根据messageId找到列表中messageModel,进行状态更新
            upDateMessage.deliveryState = imMessage.deliveryState;
            break;
        }
    }
    
    
    
    [self.chatCollectionView reloadData];
    
   
}

//- (void)didSendMessage:(NSNotification *)notify
//{
//    
//}




#pragma mark --- 接受消息，通知监听：消息接受到的是MessageServiceModel,进行组装成MessageModel来更新界面
-(void)didReceiveMessage:(MessageServiceModel *)imMessage
{
    
    //先判断是否加入时间戳
    [self insertTimeMessage:imMessage];
    
    
    
    //在下载媒体类型附件
    
#pragma mark --- 正式使用:消息组装，组装uiMessage数据，进行本地存储等相关操作
    //因为是模拟数据，这里imMessage其实是messageModel
    MessageModel *messageModel = [self formateMessage:imMessage];
    
    
    
    
    
    [self handleReceiveMessage:messageModel completion:^{
        NSLog(@"插入接收消息成功！");
        [self.chatFakeMessages addObject:messageModel];
        [self.chatCollectionView reloadData];
        
    }];
    
    
   
    
    if ([imMessage isKindOfClass:[MessageModel class]]) {
        self.lastMessageDate = imMessage.timeStamp;
    }
    
}

//- (void)didReceiveMessage:(NSNotification *)notify
//{
//    
//}



//根据接收的serviceMessageModel组装messageModel:刷新ui等操作
- (MessageModel *)formateMessage:(MessageServiceModel *)serviceMessage
{
    //因为是模拟，这里serviceMessage其实是messagemodel
      return serviceMessage;
    
    
    
#pragma mark  --- 正式使用
    MessageModel *fakeServiceMessage = (MessageModel *)serviceMessage;
    MessageModel *message = nil;
    
    switch (serviceMessage.messageType) {
        case MessageBodyTypeText: {
            
            message = [TextMessageModel text:nil username:nil timeStamp:nil isSender:NO];
            break;
        }
        case MessageBodyTypePhoto: {
            message = [PhotoMessageModel Photo:nil thumbnailUrl:nil originPhotoUrl:nil username:nil timeStamp:nil isSender:NO];
            break;
        }
        case MessageBodyTypeVideo: {
            message = [VideoMessageModel VideoThumbPhoto:nil videoThumbUrl:nil videoUrl:nil username:nil timeStamp:nil isSender:NO];
            break;
        }
        case MessageBodyTypeVoice: {
            message = [VoiceMessageModel VoicePath:nil voiceUrl:nil voiceDuration:nil username:nil timeStamp:nil isRead:nil isSender:NO];
            break;
        }
        case MessageBodyTypeLocation: {
            message = [LocationMessageModel LocalPositionPhoto:nil address:nil location:nil username:nil timeStamp:nil isSender:NO];
            break;
        }
    }
}



/**
 *  @brief 接收消息时处理媒体类型附件：
 *
 *  @param message <#message description#>
 */

//文本消息不处理;
//图片自己不做硬盘管理，全权交给sdWebImage:首先展现在ui上;
//音频先下载下来再进行ui展示
//视频先下载下来，播放视频时在未下载到本地时使用网络同步播放    或者先展示截图，再进度下载视频，直至下载完才可播放视频：
//位置同照片，全权交给sdWebImage:首先展现在ui上
- (void)handleReceiveMessage:(MessageModel *)message completion:(void(^)())completion
{
    switch (message.bubbleMessageBodyType) {
        case MessageBodyTypeText: {
            //doNothing
            completion();
            break;
        }
        case MessageBodyTypePhoto: {
            //sdWebImage do allThing
            completion();
            break;
        }
        case MessageBodyTypeVideo: {
            //videoThumb  sdWebImage do allThing
            //video       catchIntoDisk,later play
        //边播边下载
            completion ? completion() : nil;
            
            if (!message.isDownloading) {
                NSString *cachePath = [[CacheHelper helper]savePathFormediaType:MessageBodyTypeVideo];
                message.locationVideoPath = cachePath;
                [[DownloadFileHelper helper]downloadRequest:message.videoUrl destinationPath:cachePath progress:^(NSProgress *progress) {
                    NSLog(@"视频下载中:%@",progress);
                    message.isDownloading = YES;
                } complete:^(NSURL *url, NSError *error) {
                    
                    if (error) {
                        NSLog(@"视频下载失败:%@",error);
                    }else{
                        NSLog(@"视频下载完成:%@",cachePath);
                        message.isVideoCache = YES;
                        completion ? completion() : nil;
                    }
                }];
            }
            
      
            break;
        }
        case MessageBodyTypeVoice: {
            //catchVoiceIntoDisk,later play
            
          
            
            NSString *cachePath = [[CacheHelper helper]savePathFormediaType:MessageBodyTypeVoice];
            message.voicePath = cachePath;
            [[DownloadFileHelper helper]downloadRequest:message.voiceUrl destinationPath:cachePath progress:^(NSProgress *progress) {
                  NSLog(@"音频下载中:%@",progress);
            } complete:^(NSURL *url, NSError *error) {
                
                if (error) {
                   NSLog(@"音频下载失败:%@",error);
                    
                }else{
                    NSLog(@"音频下载完成:%@",cachePath);
                    completion ? completion() : nil;
                }
            }];
            
            
            break;
        }
        case MessageBodyTypeLocation: {
            //catchPhotoIntoDisk,later play
            completion();
            break;
        }
    }
}







#pragma mark --- 插入时间戳

- (void)insertTimeMessage:(MessageModel *)message
{
  
    NSDate *lastMessageDate = [NSDate dateString:self.lastMessageDate WithFormate:KDateFormate];
    
    NSDate *messageDate = [NSDate dateString:message.timeStamp WithFormate:KDateFormate];
    
    //加入时间戳
    CGFloat timeInterval = [NSDate timeIntervalWithFormer:lastMessageDate latter:messageDate];
    if (timeInterval>kTimeInterval) {

        [self.chatFakeMessages addObject:message.timeStamp];
    }
}



/********************************************CellClickAction*********************************************/
#pragma mark --- ChatCellClickDelegate

//bubble点击

//点击音频bubble
- (void)audioRecoderBubbleDidSelectedOnMessage:(MessageModel *)message
{
    NSLog(@"点击了音频bubble");
    
    message.isRead = YES;
    
    //局部刷新
    
    NSInteger item = [self.chatFakeMessages indexOfObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    
    //如果上次和当前选中非同一行： 先取消上一次音频播放
   
    if (! (indexPath == self.lastVoiceIndexPath) && self.lastVoiceIndexPath) {
        MessageModel *lastPlayMessage =  self.lastVoiceIndexPath ? self.chatFakeMessages[self.lastVoiceIndexPath.item] : nil;
        lastPlayMessage ? (lastPlayMessage.isPlaying = NO) : (nil);
        
         [self.chatCollectionView reloadItemsAtIndexPaths:@[self.lastVoiceIndexPath]];
    }

    

    //再当前选中音频播放/暂停
    message.isPlaying ^= 1;
  
    [self.chatCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    self.lastVoiceIndexPath = indexPath;
    

    [[BubblePressHandleHelper helper] audioPlayOrStop:message finishPlay:^(NSString *url) {
        
        for (NSInteger i = 0; i<self.chatFakeMessages.count; i++) {
            
            MessageModel *finishPlayMessage = self.chatFakeMessages[i];
            
            if ([finishPlayMessage isKindOfClass:[MessageModel class]]) {
                if (finishPlayMessage.voicePath) {
                    
                    if ([finishPlayMessage.voicePath isEqualToString:url]) {
                        
                        finishPlayMessage.isPlaying = NO;
                        [self.chatCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
                    }
                }
            }
            
            
        }
        
    }];
    
}






//点击视频bubble
- (void)videoBubbleDidSelectedOnMessage:(MessageModel *)message
{
    NSLog(@"点击了视频bubble");
    [[BubblePressHandleHelper helper] videoPlay:message];
}

//双击纯文本Bubble
- (void)textBubbleDidSelectedOnMessage:(MessageModel *)message
{
     NSLog(@"双击了纯文本bubble");
    [[BubblePressHandleHelper helper] viewTextContent:message];
    
}


//点击位置bubble
- (void)locationBubbleDidSelectedOnMessage:(MessageModel *)message
{
     NSLog(@"点击了位置bubble");
    [[BubblePressHandleHelper helper]locationMap:message viewController:self];
}

//点击图片bubble
- (void)photoBubbleDidSelectedOnMessage:(MessageModel *)message photo:(UIImageView *)photo
{
     NSLog(@"点击了图片bubble");
    [[BubblePressHandleHelper helper] photoBrow:message photo:photo];
}



//头像点击
- (void)avaterDidSelectedOnMessage:(MessageModel *)message
{
     NSLog(@"点击了头像");
}


//消息发送失败后重新发送消息
- (void)resendMessage:(MessageModel *)message
{
     message.deliveryState = MessageDeliveryStateDelivering;
    [self refreshSingleMessage:message];

    //消息业务发送
    __block MessageModel *updateMessage = nil;
    [MessageSendHelper sendMessage:message completion:^(MessageServiceModel *serviceMessage) {
        
        //定位到ui上已经展示的那条消息，进行消息状态的更新
        for (MessageModel *message in self.chatFakeMessages) {
            
            if ([message isKindOfClass:[NSString class]]) {
                continue;
            }
            
            if ([message.messageId isEqualToString:serviceMessage.messageId]) {
                
                updateMessage = message;
                updateMessage.deliveryState = serviceMessage.deliveryState;
                break;
            }
        }
        
        
        [self.chatCollectionView reloadData];
    }];
     NSLog(@"重新发送消息");
}



//富文本消息，点击链接
- (void)didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
     NSLog(@"点击了链接");
    [[BubblePressHandleHelper helper]linkHandle:link type:type];
}





- (void)refreshSingleMessage:(MessageModel *)message
{
    NSInteger item = [self.chatFakeMessages indexOfObject:message];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
    
    [self.chatCollectionView reloadItemsAtIndexPaths:@[indexPath]];
}



#pragma mark -- kvo  键盘事件调整table的offset
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //监测键盘变化：改变chatTable的offset
    if ([keyPath isEqualToString:@"keyBoardDetalChange"]){
        
        [self.chatCollectionView setContentOffset:CGPointMake(0, self.chatCollectionView.contentSize.height+self.keyBoardView.keyBoardDetalChange-SCREEN_HEIGHT+64) animated:YES];
        
    }
    
    //监测聊天消息接收和发送，系统table的contentSize变化，改变offset:在tabeView上可用，在colleview中因layout有问题不能使用
    else if ([keyPath isEqualToString:@"contentSize"]){
        
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//               [self.chatCollectionView setContentOffset:CGPointMake(0, self.chatCollectionView.contentSize.height+self.keyBoardView.keyBoardDetalChange-SCREEN_HEIGHT) animated:NO];
//        });
     
    }
    
}


#pragma mark -- scrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.keyBoardView.hideKeyBoard = YES;
}


#pragma mark --- lazyLoading

- (UICollectionView *)chatCollectionView
{
    if (!_chatCollectionView) {
        
        SpringCollectionFlowLayout *springlayOut =   [[SpringCollectionFlowLayout alloc] init];
        springlayOut.minimumInteritemSpacing = 0;
        springlayOut.minimumLineSpacing = 0;
        _chatCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:springlayOut];
        _chatCollectionView.backgroundColor = [UIColor whiteColor];
        [_chatCollectionView registerClass:[ChatCollectionCell class] forCellWithReuseIdentifier:leftChatCollectionCellIdentifier];

         [_chatCollectionView registerClass:[ChatCollectionCell class] forCellWithReuseIdentifier:rightChatCollectionCellIdentifier];
  
        [_chatCollectionView registerClass:[ChatCollectionTimeCell class] forCellWithReuseIdentifier:chatCollectionTimeCellIdentifier];
        _chatCollectionView.delegate = self;
        _chatCollectionView.dataSource = self;
        _chatCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    }
    return _chatCollectionView;
}



- (NSMutableArray *)chatFakeMessages
{
    if (_chatFakeMessages == nil) {
        _chatFakeMessages = [NSMutableArray array];
//        [_chatFakeMessages addObjectsFromArray:[ChatDemoDataSourceHelper getFakeMessages]];
    }
    return _chatFakeMessages;
}


/***************************************** ***customKeyBoard*********************************************/

#pragma mark -- customKeyBoard


- (KeyBoardView *)keyBoardView
{
    
    
    if (_keyBoardView == nil) {
        _keyBoardView = [[KeyBoardView alloc]init];
        _keyBoardView.voiceRecoderDelegate = self;
        _keyBoardView.textInputDelegate = self;
        _keyBoardView.moreViewDelegate = self;
        _keyBoardView.emoijViewDelegate = self;
        [_keyBoardView addObserver:self forKeyPath:@"keyBoardDetalChange" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
    }
    
    return _keyBoardView;
}



#pragma mark - VoiceRecording delegate
- (void)prepareRecordingVoiceAction
{
    
    NSString *path = [[CacheHelper helper]savePathFormediaType:MessageBodyTypeVoice];
    [self.voiceRecordHelper prepareRecordingWithPath:path prepareRecorderCompletion:^BOOL{
        return YES;
    }];
}

- (void)didStartRecordingVoiceAction {
    [self.voiceRecordHelper startRecordingWithStartRecorderCompletion:^{
        
    }];
}

- (void)didCancelRecordingVoiceAction {
    [self.voiceRecordHelper cancelledDeleteWithCompletion:^{
        
    }];
}

- (void)didFinishRecoingVoiceAction {
    [self.voiceRecordHelper stopRecordingWithStopRecorderCompletion:^(NSString *path){
        
        [self sendVoiceRecoder:path voiceDuration:self.voiceRecordHelper.recordDuration];
        
    }];
    
}



//暂不开放这两个接口
/*
 - (void)didDragOutsideAction {
 NSLog(@"didDragOutsideAction");
 [self resumeRecord];
 }
 
 - (void)didDragInsideAction {
 NSLog(@"didDragInsideAction");
 [self pauseRecord];
 }
 
 */



#pragma mark ---TextSendDelegate
//发送纯文本消息
- (void)sendTextMessage:(NSString *)text
{
    
    TextMessageModel *message =  [TextMessageModel text:text username:@"" timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
    message.avatarUrl = [self rightAvatar];


    [self sendMessage:message];
    
}


#pragma mark ---EmotionMessageSendDelegate
//发送emoi表情
- (void)sendEmoijMessage:(NSString *)text
{
    TextMessageModel *message =  [TextMessageModel text:text username:@"" timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
    message.avatarUrl = [self rightAvatar];

    [self sendMessage:message];
    
    
}


//发送非emoij图片，gif或静态photo
- (void)sendEmotionImage:(NSString *)localPath emotionType:(EmotionType)emotionType
{
    
    PhotoMessageModel *message =  [PhotoMessageModel Photo:localPath thumbnailUrl:nil originPhotoUrl:nil username:nil timeStamp:[NSDate date:[NSDate date] WithFormate:KDateFormate] isSender:YES];
    if (emotionType == EmotionTypeGif)
    {
        message.isGif = YES;
    }
    else
    {
        message.isGif = NO;
    }
    
    message.avatarUrl = [self rightAvatar];

    [self sendMessage:message];
    
}

/*!
 * 将远程消息数据转化为实体数据
 * @param messages
 */
- (void)setupMessages:(NSMutableArray *)messages {
    for (int i = 0; i < messages.count; ++i) {
        SAChatModel *chatModel = [SAChatModel chatWthDict:messages[(NSUInteger)i]];
        MessageModel *messageModel = nil;
        switch (chatModel.messageType) {
            case SAChatMessageDefault:
            {
                if (self.rightUserId == chatModel.fromUser) {
                    // 右侧
                    messageModel = [TextMessageModel text:chatModel.message username:self.rightUsername timeStamp:chatModel.date isSender:YES];
                    messageModel.avatarUrl = self.rightAvatar;
                } else {
                    // 左侧
                    messageModel = [TextMessageModel text:chatModel.message username:self.leftUsername timeStamp:chatModel.date isSender:NO];
                    messageModel.avatarUrl = self.leftAvatar;
                }
            }
                break;
            case SAChatMessageImage:
            {
                if (self.rightUserId == chatModel.fromUser) {
                    // 右侧
                    messageModel = [PhotoMessageModel Photo:nil thumbnailUrl:chatModel.message originPhotoUrl:chatModel.message username:self.rightUsername timeStamp:chatModel.date isSender:YES];
                    messageModel.avatarUrl = self.rightAvatar;
                } else {
                    // 左侧
                    messageModel = [PhotoMessageModel Photo:nil thumbnailUrl:chatModel.message originPhotoUrl:chatModel.message username:self.leftUsername timeStamp:chatModel.date isSender:NO];
                    messageModel.avatarUrl = self.leftAvatar;
                }
            }
                break;
            case SAChatMessageVoice:
            {
                if (self.rightUserId == chatModel.fromUser) {
                    // 右侧
                    messageModel = [VoiceMessageModel VoicePath:nil voiceUrl:chatModel.message voiceDuration:@"2\"" username:self.rightUsername timeStamp:chatModel.date isSender:YES];
                    messageModel.avatarUrl = self.rightAvatar;
                } else {
                    // 左侧
                    messageModel = [VoiceMessageModel VoicePath:nil voiceUrl:chatModel.message voiceDuration:@"2\"" username:self.leftUsername timeStamp:chatModel.date isSender:NO];
                    messageModel.avatarUrl = self.leftAvatar;
                }
            }
                break;
            case SAChatMessageVideo:
            {
                // TODO : 添加视频消息转化
            }
                break;
            default:
                break;
        }

        [self.chatFakeMessages addObject:messageModel];
    }

    [self.chatCollectionView reloadData];

    // 滚动到底部
    [self.chatCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.chatFakeMessages.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}


#pragma mark --
#pragma mark Notifications
- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserMessagesSuccess:) name:NOTI_TEAM_USER_MESSAGES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUserMessagesFailed:) name:NOTI_TEAM_USER_MESSAGES_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_TEAM_USER_MESSAGES object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_TEAM_USER_MESSAGES_ERROR object:nil];
}

#pragma mark -- NOTI_TEAM_USER_MESSAGES
- (void)receiveUserMessagesSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {
        [self setupMessages:notification.userInfo[@"data"]];
    } else {
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"消息加载失败!" duration:.5];
    }
}

- (void)receiveUserMessagesFailed:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 404) {
        // 没有消息
    } else {
        [CLProgressHUD showErrorInView:self.view delegate:self title:@"请稍后再试!" duration:.5];
    }
}

#pragma mark -- dealloc
- (void)dealloc
{
    [self.chatCollectionView removeObserver:self forKeyPath:@"contentSize"];
    [self.keyBoardView removeObserver:self forKeyPath:@"keyBoardDetalChange"];
//    [[NSNotificationCenter defaultCenter]removeObserver:self.keyBoardView forKeyPath:@"contentSize"];
//    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"keyBoardDetalChange"];

    [self removeAllNotifications];
}

@end
