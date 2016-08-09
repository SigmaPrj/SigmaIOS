//
//  SAChatView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/7.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SAChatView.h"
#import "SAChatServer.h"
#import "SAMessageModel.h"
#import "SAUserDataManager.h"
#import "SATeamRequest.h"
#import "CLProgressHUD.h"
#import "SAChatModel.h"

@interface SAChatView()

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) int mid;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation SAChatView

- (instancetype)initWithChatMode:(XMNChatMode)aChatMode {
    self = [super initWithChatMode:aChatMode];
    if (self) {
        self.chatServer = [[SAChatServer alloc] init];

        // 添加所有监听
        [self addAllNotifications];
    }
    return self;
}

- (void)dealloc {
    [self removeAllNotifications];
}

- (void)setMessageModel:(SAMessageModel *)messageModel {
    _messageModel = messageModel;

    // 设置uid
    _uid = messageModel.user_id;

    // 设置mid
    NSDictionary *userDict = [SAUserDataManager readUser];
    _mid = [userDict[@"id"] intValue];

    // 显示加载按钮
//    [CLProgressHUD showInView:self.chatController.view delegate:self tag:1 title:@"正在加载..."];

    // 发送请求, 获取所有数据
    [self sendRequest];

}

- (void)sendRequest {
    [SATeamRequest requestMessagesOfUser:self.mid sUser:self.uid];
}

- (void)setupMessages:(NSArray *)messages {
    // 转化成model
    for (int i = 0; i < messages.count; ++i) {
        SAChatModel *chatModel = [SAChatModel chatWthDict:messages[(NSUInteger)i]];
        [self.datas addObject:chatModel];
    }

    // 添加消息
    for (int j = 0; j < self.datas.count; ++j) {
        SAChatModel *cChatModel = self.datas[(NSUInteger)j];
        if (j == 0) {
            [self generateSystemMessage:cChatModel];
        } else {
            SAChatModel *lChatModel = self.datas[(NSUInteger)(j-1)];
            if (![lChatModel.date isEqualToString:cChatModel.date]) {
                [self generateSystemMessage:cChatModel];
            }
        }
        [self addMessage:cChatModel];
    }
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)addMessage:(SAChatModel *)chatModel {
    switch (chatModel.messageType) {
        case SAChatMessageDefault:
        {
            [self generateTextMessages:chatModel];
        }
            break;
        case SAChatMessageImage:
        {
            [self generateImageMessages:chatModel];
        }
            break;
        case SAChatMessageVoice:
        {
            [self generateVoiceMessages:chatModel];
        }
            break;
        default:
            break;
    }
}

- (void)generateSystemMessage:(SAChatModel *)chatModel {
    XMNChatSystemMessage *systemMessage = [[XMNChatSystemMessage alloc] initWithContent:chatModel.date state:XMNMessageStateSuccess owner:XMNMessageOwnerSystem];
    [self.messages addObject:systemMessage];
}

- (void)generateTextMessages:(SAChatModel *)chatModel {
    NSInteger userId = [SAUserDataManager readUserId];
    if (chatModel.fromUser == userId) {
        XMNChatTextMessage *textMessage = [[XMNChatTextMessage alloc] initWithContent:chatModel.message state:XMNMessageStateSuccess owner:XMNMessageOwnerSelf];
        [self.messages addObject:textMessage];
    } else {
        XMNChatTextMessage *textMessage = [[XMNChatTextMessage alloc] initWithContent:chatModel.message state:XMNMessageStateSuccess owner:XMNMessageOwnerOther];
        [self.messages addObject:textMessage];
    }
    /*NSArray *words = @[@"爱=不放弃。 -- 书摘",
            @"真理惟一可靠的标准就是永远自相符合。—— 欧文",
            @"土地是以它的肥沃和收获而被估价的；才能也是土地，不过它生产的不是粮食，而是真理。如果只能滋生瞑想和幻想的话，即使再大的才能也只是砂地或盐池，那上面连小草也长不出来的。—— 别林斯基",
            @"我需要三件东西：爱情友谊和图书。然而这三者之间何其相通！炽热的爱情可以充实图书的内容，图书又是人们最忠实的朋友。 —— 蒙田",
            @"时间是一切财富中最宝贵的财富。 —— 德奥弗拉斯多",
            @"世界上一成不变的东西，只有“任何事物都是在不断变化的”这条真理。 —— 斯里兰卡",
            @"生活有度，人生添寿。 —— 书摘",
            @"这世界要是没有爱情，它在我们心中还会有什么意义！这就如一盏没有亮光的走马灯。 —— 歌德",
            @"我们不应该不惜任何代价地去保持友谊，从而使它受到玷污。如果为了那更伟大的爱，必须牺牲友谊，那也是没有办法的事；不过如果能够保持下去，那么，它就能真的达到完美的境界了。 —— 泰戈尔"];

    [words enumerateObjectsUsingBlock:^(NSString  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XMNChatTextMessage *textMessage = [[XMNChatTextMessage alloc] initWithContent:obj state:XMNMessageStateSuccess owner:idx%2==0 ? XMNMessageOwnerSelf : XMNMessageOwnerOther];
        [self.messages addObject:textMessage];
    }];*/
}

- (void)generateImageMessages:(SAChatModel *)chatModel {
    NSInteger userId = [SAUserDataManager readUserId];
    if (chatModel.fromUser == userId) {
        XMNChatImageMessage *imageMessage = [[XMNChatImageMessage alloc] initWithContent:[self getImageFromUrl:chatModel.message] state:XMNMessageStateSuccess owner:XMNMessageOwnerSelf];
        [self.messages addObject:imageMessage];
    } else {
        XMNChatImageMessage *imageMessage = [[XMNChatImageMessage alloc] initWithContent:[self getImageFromUrl:chatModel.message] state:XMNMessageStateSuccess owner:XMNMessageOwnerOther];
        [self.messages addObject:imageMessage];
    }
/*     添加本地图片 测试消息
    XMNChatImageMessage *imageMessage = [[XMNChatImageMessage alloc] initWithContent:[UIImage imageNamed:@"test01"] state:XMNMessageStateSuccess owner:XMNMessageOwnerOther];
    imageMessage.state = XMNMessageStateSending;
    [self.messages addObject:imageMessage];

    添加测试语音消息
    XMNChatVoiceMessage *voiceMessage = [[XMNChatVoiceMessage alloc] initWithContent:@"https://raw.githubusercontent.com/ws00801526/XMNAudio/master/XMNAudioExample/XMNAudioExample/letitgo_v.mp3" state:XMNMessageStateSuccess owner:XMNMessageOwnerOther];
    voiceMessage.state = XMNMessageStateSending;
    [self.messages addObject:voiceMessage];

    添加测试语音消息2
    XMNChatVoiceMessage *voiceMessage2 = [[XMNChatVoiceMessage alloc] initWithContent:@"https://raw.githubusercontent.com/ws00801526/XMNAudio/master/XMNAudioExample/XMNAudioExample/letitgo_v.mp3" state:XMNMessageStateSuccess owner:XMNMessageOwnerSelf];
    voiceMessage2.state = XMNMessageStateSending;
    [self.messages addObject:voiceMessage2];*/
}

- (void)generateVoiceMessages:(SAChatModel *)chatModel {
    NSInteger userId = [SAUserDataManager readUserId];
    if (chatModel.fromUser == userId) {
        XMNChatVoiceMessage *voiceMessage = [[XMNChatVoiceMessage alloc] initWithContent:chatModel.message state:XMNMessageStateSuccess owner:XMNMessageOwnerSelf];
        [self.messages addObject:voiceMessage];
    } else {
        XMNChatVoiceMessage *voiceMessage = [[XMNChatVoiceMessage alloc] initWithContent:chatModel.message state:XMNMessageStateSuccess owner:XMNMessageOwnerOther];
        [self.messages addObject:voiceMessage];
    }
}

- (UIImage *)getImageFromUrl:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}

#pragma mark -
#pragma mark notifications
- (void)receiveMessagesSuccess:(NSNotification *)notification {
    if ([notification.userInfo[@"code"] intValue] == 200) {

        [self setupMessages:notification.userInfo[@"data"]];

        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.chatController.view];
    } else {
        [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.chatController.view];
        [CLProgressHUD showErrorInView:self.chatController.view delegate:self title:@"加载失败!" duration:.4];
    }
}

- (void)receiveMessagesFailed:(NSNotification *)notification {
    [CLProgressHUD dismissHUDByTag:1 delegate:self inView:self.chatController.view];
    [CLProgressHUD showErrorInView:self.chatController.view delegate:self title:@"加载失败!" duration:.4];
}

- (void)addAllNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessagesSuccess:) name:NOTI_TEAM_USER_MESSAGES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessagesFailed:) name:NOTI_TEAM_USER_MESSAGES_ERROR object:nil];
}

- (void)removeAllNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
