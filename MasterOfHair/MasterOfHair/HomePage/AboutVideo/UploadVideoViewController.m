//
//  UploadVideoViewController.m
//  KongFuCenter
//
//  Created by 于金祥 on 15/12/19.
//  Copyright © 2015年 zykj. All rights reserved.
//

#import "UploadVideoViewController.h"
#import "SCRecorder.h"
#import "DataProvider.h"
//#import "ChannelViewController.h"

@interface UploadVideoViewController () <UITextViewDelegate>
{
//Preview
    SCPlayer *_player;
    
    UITextView * txt_title;
    UITextView * txt_Content;
    
    NSString * channelID;
}
@property (nonatomic, strong) UITextView * text_View;
@property (nonatomic, strong) UILabel * label_placeHold;

@end

@implementation UploadVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLeftButton:@"iconfont-fanhui"];
    channelID=@"";
    _lblTitle.text=@"视频信息";
    [self addRightbuttontitle:@"保存"];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectChannelCallBack:) name:@"select_channel_finish" object:nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:) ];
    [self.view addGestureRecognizer:tapGesture];
    
    [self InitAllView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

-(void)InitAllView
{
    
    self.text_View = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 150)];
    self.text_View.delegate = self;

    self.text_View.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.text_View];
    
    self.label_placeHold = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 20)];
    self.label_placeHold.text = @"说点什么吧...";
    self.label_placeHold.textColor = [UIColor grayColor];
    [self.text_View addSubview:self.label_placeHold];
    
    // 创建视频播放器
    _player = [SCPlayer player];
    SCVideoPlayerView *playerView = [[SCVideoPlayerView alloc] initWithPlayer:_player];
    playerView.tag = 400;
    playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerView.frame = CGRectMake(10, CGRectGetMaxY(self.text_View.frame) + 10, 120, 120);
    [self.view addSubview:playerView];
    _player.loopEnabled = YES;
    [_player setItemByUrl:_VideoFilePath];
    [_player play];
    
//    txt_title=[[UITextView alloc] initWithFrame:CGRectMake(playerView.frame.origin.x+playerView.frame.size.width+10, 74, SCREEN_WIDTH-(playerView.frame.origin.x+playerView.frame.size.width+20), playerView.frame.size.height)];
//    txt_title.backgroundColor=ItemsBaseColor;
//    txt_title.textColor = [UIColor whiteColor];
//    
//    [self.view addSubview:txt_title];
//    
//    UIView * selectView=[[UIView alloc] initWithFrame:CGRectMake(10, playerView.frame.size.height+playerView.frame.origin.y+10, SCREEN_WIDTH-20, 44)];
//    
//    selectView.backgroundColor=ItemsBaseColor;
//    
//    UILabel * lbl_title=[[UILabel alloc] initWithFrame:CGRectMake(0, 11, (SCREEN_WIDTH-20)/2, 20)];
//    
//    lbl_title.text=@"请选择视频分类";
//    lbl_title.textColor = [UIColor whiteColor];
//    [selectView addSubview:lbl_title];
//    
//    
//    UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
//    rightView.frame = CGRectMake((SCREEN_WIDTH - 20 -20), 13.5, 15, 15);
//    rightView.contentMode = UIViewContentModeScaleAspectFit;
//    
//    [selectView addSubview:rightView];
//    
//    channelNameLab = [[UILabel alloc] initWithFrame:CGRectMake(rightView.frame.origin.x - 100, 0, 90, selectView.frame.size.height)];
////    channelNameLab.font = [UIFont systemFontOfSize:14];
//    channelNameLab.textColor = [UIColor whiteColor];
//    channelNameLab.textAlignment = NSTextAlignmentRight;
//    
//    [selectView addSubview:channelNameLab];
//    
//    UIButton * btn_selectFenlei=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, selectView.frame.size.width, selectView.frame.size.height)];
//    
//    [btn_selectFenlei addTarget:self action:@selector(JumpToChannelVC) forControlEvents:UIControlEventTouchUpInside];
//    
//    [selectView addSubview:btn_selectFenlei];
//    
//    [self.view addSubview:selectView];
//    
//    
//    txt_Content=[[UITextView alloc] initWithFrame:CGRectMake(10,selectView.frame.size.height+selectView.frame.origin.y+10 , SCREEN_WIDTH-20, SCREEN_HEIGHT-selectView.frame.size.height-selectView.frame.origin.y-20)];
//    
//    txt_Content.backgroundColor=ItemsBaseColor;
//    txt_Content.textColor = [UIColor whiteColor];
//    [self.view addSubview:txt_Content];
//
}




-(void)tapViewAction:(id)sender
{
    NSLog(@"tap view---");
    
    [self.view endEditing:YES];
    
//    if(_keyShow == true)
//    {
//        _keyShow = false;
//        [_textView resignFirstResponder];//关闭textview的键盘
//        [_titleField resignFirstResponder];//关闭titleField的键盘
//        
//    }
}

-(void)clickRightButton:(UIButton *)sender
{
//掉接口
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    DataProvider * dataprovider=[[DataProvider alloc] init];
    
    [dataprovider setDelegateObject:self setBackFunctionName:@"create:"];
    
//    [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] talk_content:self.text_View.text file_type:@"1" Path:self.VideoFilePath];
        
    [dataprovider createWithMember_id:@"3" talk_content:self.text_View.text file_type:@"2" Path:self.VideoFilePath];

    
    [SVProgressHUD showWithStatus:@"正在上传视频..." maskType:SVProgressHUDMaskTypeBlack];
}


- (void)create:(id )dict
{
    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"发布成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}



-(void)uploadVideoCallBack:(id)dict
{
    NSLog(@"%@",dict);
    [SVProgressHUD dismiss];
    [SVProgressHUD showWithStatus:@"正在保存视频信息..." maskType:SVProgressHUDMaskTypeBlack];
    
//    code = 200;
//    date =     {
//        ImageName = "UpLoad\\Image\\83e46012-91f3-4a31-a27b-fdb658601adf.JPG";
//        VideoDuration = "00:00:08";
//        VideoName = "UpLoad\\Video\\279b6db9-455e-4feb-9e03-1e5fa15a9879.mov";
//    };
    
    if ([dict[@"code"] intValue]==200) {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        
        [dataprovider setDelegateObject:self setBackFunctionName:@"UploadVideoInfoCallBack:"];
        
        @try {
            NSMutableDictionary * prm=[[NSMutableDictionary alloc] init];
            
            [prm setObject:@"0" forKey:@"id"];
            
            
            
            [prm setObject:[[NSString stringWithFormat:@"%@",dict[@"data"][@"ImageName"]] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"] forKey:@"ImagePath"];
            
            [prm setObject:txt_Content.text forKey:@"Content"];
            
            [prm setObject:txt_title.text forKey:@"Title"];
            
            [prm setObject:dict[@"data"][@"VideoName"] forKey:@"VideoPath"];
            
            [prm setObject:@"TRUE" forKey:@"IsOriginal"];
            
            [prm setObject:@"TRUE" forKey:@"IsFree"];
            
            [prm setObject:channelID forKey:@"CategoryId"];
            
            [prm setObject:[Toolkit getUserID] forKey:@"UserId"];
            
            [prm setObject:dict[@"data"][@"VideoDuration"] forKey:@"VideoDuration"];
            
            [prm setObject:_uploadType forKey:@"uploadType"];
            
//            [dataprovider SendVideoInfo:prm];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
        
    }
}


-(void)UploadVideoInfoCallBack:(id)dict
{
    [SVProgressHUD dismiss];
    if ([dict[@"code"] intValue]==200) {
        
        [SVProgressHUD showSuccessWithStatus:@"发布成功" maskType:SVProgressHUDMaskTypeBlack];
        
        
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)JumpToChannelVC
{
//    ChannelViewController *channelViewCtl = [[ChannelViewController alloc] init];
//    
//    channelViewCtl.navtitle = @"请选择分类";
//    
//    channelViewCtl.isVideoSelectCadagray=YES;
//    
//    [self.navigationController pushViewController:channelViewCtl animated:YES];
}
-(void)SelectChannelCallBack:(NSNotification *)notice
{
    NSLog(@"%@",[notice object]);
    
    channelID=[[notice object] objectForKey:@"channelId"];
    channelNameLab.text = [[notice object] objectForKey:@"channelName"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.text_View resignFirstResponder];
    
    if([self.text_View.text length] == 0)
    {
        self.label_placeHold.hidden = NO;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.label_placeHold.hidden = YES;
    
    return YES;
}



@end
