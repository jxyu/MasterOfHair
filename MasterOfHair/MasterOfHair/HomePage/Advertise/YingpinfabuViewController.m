//
//  YingpinfabuViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/22.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "YingpinfabuViewController.h"
#import "xinziViewController.h"
#import "fenleifabuViewController.h"
#import "fabudizhiViewController.h"

#import "VPImageCropperViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f
@interface YingpinfabuViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate,VPImageCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UITextField * text_jingli;

@property (nonatomic, strong) UIImageView * image_pic;
@property (nonatomic, strong ) UIView * view_bg;



@property (nonatomic, strong) UIImageView * portraitImageView;
@property (nonatomic, strong) NSData * imageData;
@end

@implementation YingpinfabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_navi];
    
    [self p_setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navi
- (void)p_navi
{
    _lblTitle.text = [NSString stringWithFormat:@"详情页"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    
    UITextField * text_1 = [self.view viewWithTag:100];
    UIImageView * image_1 = [self.view viewWithTag:101];
    if([[userdefault objectForKey:@"zhaopingxinzi_name_1"] length] != 0)
    {
        text_1.text =  [userdefault objectForKey:@"zhaopingxinzi_name_1"];
        image_1.hidden = YES;
    }
    
    
    UITextField * text_2 = [self.view viewWithTag:200];
    UIImageView * image_2 = [self.view viewWithTag:201];
    if([[userdefault objectForKey:@"zhaopingfei_name_2"] length] != 0)
    {
        text_2.text =  [userdefault objectForKey:@"zhaopingfei_name_2"];
        image_2.hidden = YES;
    }
    
    UITextField * text_3 = [self.view viewWithTag:300];
    UIImageView * image_3 = [self.view viewWithTag:301];
    if([[userdefault objectForKey:@"diquweizhi3_"] length] != 0)
    {
        text_3.text =  [userdefault objectForKey:@"diquweizhi3_"];
        image_3.hidden = YES;
    }
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self p_headView];
    
    self.tableView.tableHeaderView = self.view_bg;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    UIView * view_foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    view_foot.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.tableView.tableFooterView = view_foot;
    
    [self.view addSubview:self.tableView];
}

//头布局
- (void)p_headView
{
    self.view_bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.view_bg.backgroundColor = [UIColor whiteColor];
    
    UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 10)];
    view_line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view_bg addSubview:view_line];
    
    self.image_pic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 80, 80)];
//    self.image_pic.backgroundColor = [UIColor orangeColor];
    self.image_pic.image = [UIImage imageNamed:@"shuoshuo111111111"];
    [self.view_bg addSubview:self.image_pic];
    
    self.image_pic.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture4:)];
    tapGesture4.numberOfTapsRequired = 1; //点击次数
    tapGesture4.numberOfTouchesRequired = 1; //点击手指数
    [self.image_pic addGestureRecognizer:tapGesture4];
}


#pragma mark - 代理
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 14;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 5 || indexPath.row == 11)
    {
        return 10;
    }
    else if(indexPath.row == 10)
    {
        return 100;
    }
    else if(indexPath.row == 13)
    {
        return 80;
    }
    else
    {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row)
    {
        case 0:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"应聘职位";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.placeholder = @"请输入应聘职位";
            detail.delegate = self;
            detail.tag = 10001;
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 1:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"期望薪资";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            detail.placeholder = @"请选择薪资区间";
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 100;
            image.tag = 101;
            
            [cell addSubview:image];
        }
            break;
        case 2:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"职位分类";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            detail.placeholder = @"请选择分类";
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 200;
            image.tag = 201;
            
            [cell addSubview:image];
        }
            break;
        case 3:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"选择城市";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15 - 30, 30)];
            detail.enabled = NO;
            detail.placeholder = @"请选择城市";
            [cell addSubview:detail];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(detail.frame) + 5, 12.5, 25, 25)];
            image.image = [UIImage imageNamed:@"01fanhui_07"];
            
            detail.tag = 300;
            image.tag = 301;
            
            [cell addSubview:image];
        }
            break;
        case 4:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"工作地点";
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10002;
            detail.placeholder = @"请输入期望工作地点";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 5:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            //            view_bg.layer.borderColor = [UIColor grayColor].CGColor;
            //            view_bg.layer.borderWidth = 1;
            
            [cell addSubview:view_bg];
        }
            break;
            
        case 6:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"姓名";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10003;
            detail.placeholder = @"请输入姓名";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 7:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"年龄";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10004;
            detail.placeholder = @"请输入年龄";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 8:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"性别";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10005;
            detail.placeholder = @"请输入性别";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 9:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"居住地址";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10006;
            detail.placeholder = @"请输入居住地址";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 10:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"工作经历";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 90)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextView * detail = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 80)];
            detail.delegate = self;
            detail.tag = 10007;
            [cell addSubview:detail];
            
            self.text_jingli = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            self.text_jingli.delegate = self;
            self.text_jingli.placeholder = @"请输入工作经历";
            self.text_jingli.clearButtonMode = UITextFieldViewModeAlways;
            self.text_jingli.enabled = NO;
            [cell addSubview:self.text_jingli];
        }
            break;
            
        case 11:
        {
            UIView * view_bg = [[UIView alloc] initWithFrame:CGRectMake(- 5, 0, SCREEN_WIDTH + 10, 10)];
            view_bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
            //            view_bg.layer.borderColor = [UIColor grayColor].CGColor;
            //            view_bg.layer.borderWidth = 1;
            
            [cell addSubview:view_bg];
        }
            break;
        case 12:
        {
            UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 30)];
            name.textColor = [UIColor grayColor];
            name.text = @"联系方式";
            name.textAlignment = NSTextAlignmentRight;
            [cell addSubview:name];
            
            UIView * view_line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame) + 5, 5, 1, 40)];
            view_line.backgroundColor = [UIColor grayColor];
            [cell addSubview:view_line];
            
            UITextField * detail = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(view_line.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(view_line.frame) - 15, 30)];
            detail.delegate = self;
            detail.tag = 10008;
            detail.placeholder = @"请输入联系方式";
            detail.clearButtonMode = UITextFieldViewModeAlways;
            [cell addSubview:detail];
        }
            break;
        case 13:
        {
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
            [btn setTitle:@"立即发布" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            
            btn.backgroundColor = navi_bar_bg_color;
            
            [cell addSubview:btn];
            
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 1:
        {
            xinziViewController * zhaopinxinziViewController = [[xinziViewController alloc] init];
            
            [self showViewController:zhaopinxinziViewController sender:nil];
        }
            break;
        case 2:
        {
            fenleifabuViewController * enleifabuViewController = [[fenleifabuViewController alloc] init];
            
            [self showViewController:enleifabuViewController sender:nil];
        }
            break;
        case 3:
        {
            fabudizhiViewController * enleifabuViewController = [[fabudizhiViewController alloc] init];
            
            [self showViewController:enleifabuViewController sender:nil];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 代理
- (void )touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (int i = 1; i < 9; i ++)
    {
        UITextField * text1 = [self.view viewWithTag:10000 + i];
        [text1 resignFirstResponder];
    }
    
    UITextView * text = [self.view viewWithTag:10007];
    if([text.text length] == 0)
    {
        self.text_jingli.hidden = NO;
    }
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void )textFieldDidBeginEditing:(UITextField *)textField
{
    NSInteger x = textField.tag - 10000;
    
    if(x > 1 && x!= 6 && x!= 8)
    {
        NSIndexPath * scrollIndexPath = [NSIndexPath indexPathForRow:x + 2 inSection:0];
        [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
    }
    if( x == 6)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 500);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else if(x == 8)
    {
        [UIView animateWithDuration:0.7 animations:^{
            
            self.tableView.contentOffset = CGPointMake(0, 650);
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.text_jingli.hidden = YES;
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.tableView.contentOffset = CGPointMake(0, 500);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 照相
-(void)tapGesture4:(id)sender
{
    [self p_pick];
}

- (void)p_pick
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
        [self saveImage:editedImage withName:@"avatar.jpg"];
        
        NSData *imageData = UIImagePNGRepresentation(editedImage);
        
        self.image_pic.image = editedImage;
        self.imageData = imageData;

        //        [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
        
#warning 拿数据imageData
        //        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        //
        //        DataProvider * dataprovider=[[DataProvider alloc] init];
        //        [dataprovider setDelegateObject:self setBackFunctionName:@"UploadHeadPic:"];
        //
        //        [dataprovider UploadHeadPicWithMember_id:[userdefault objectForKey:@"member_id"] member_headpic:imageData];
        
    }];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
















@end
