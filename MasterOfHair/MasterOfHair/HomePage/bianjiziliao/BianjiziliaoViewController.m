//
//  BianjiziliaoViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/3/5.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BianjiziliaoViewController.h"
#import "VPImageCropperViewController.h"


#define ORIGINAL_MAX_WIDTH 640.0f
@interface BianjiziliaoViewController () <UIScrollViewDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,VPImageCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIImageView * touxiang;

@property (nonatomic, strong) UITextField * nicheng;

//存放
@property (nonatomic, strong) UIImageView * portraitImageView;
@end

@implementation BianjiziliaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _lblTitle.text = [NSString stringWithFormat:@"编辑完善个人资料"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    [self addRightbuttontitle:@"保存"];
}

//返回
- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//隐藏tabbar
-(void)viewWillAppear:(BOOL)animated
{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] hiddenTabBar];
}

- (void )clickRightButton:(UIButton *)sender
{
//    NSLog(@"保存");
    [self.nicheng resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
    //判断
    if([self.nicheng.text length] != 0)
    {
        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
        
        [dataprovider updateWithMember_id:[userdefault objectForKey:@"member_id"] member_nickname:self.nicheng.text];
    }
    else
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"昵称不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];

    }
}

#pragma mark - 布局
- (void)p_setupView
{
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    
    //白背景
    UIView * view_white = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view_white.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, 20, 100, 35)];
    name.text = @"我的头像";
    name.font = [UIFont systemFontOfSize:15];
    name.textColor = [UIColor grayColor];
    name.textAlignment = NSTextAlignmentCenter;
    [view_white addSubview:name];
    
    //头像
    self.touxiang = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, CGRectGetMaxY(name.frame) + 10, 100, 100)];
    self.touxiang.layer.cornerRadius = 50;
    self.touxiang.userInteractionEnabled = YES;
    [view_white addSubview:self.touxiang];
    
    if([[userdefault objectForKey:@"member_headpic"] length] == 0 || [[userdefault objectForKey:@"member_headpic"] isEqualToString:@"<null>"])
    {
        self.touxiang.image = [UIImage imageNamed:@"touxiang"];
    }
    else
    {
        [self.touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url,[userdefault objectForKey:@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    
    //手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.touxiang addGestureRecognizer:tapGesture];
    
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 20, CGRectGetMaxY(self.touxiang.frame) - 25, 25, 25)];
    image.image = [UIImage imageNamed:@"bazhaotupian"];
    [view_white addSubview:image];
    
    
    //白背景
    UIView * view_white1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_white.frame) + 10, SCREEN_WIDTH, 50)];
    view_white1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_white1];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
    label.text = @"昵称";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [view_white1 addSubview:label];
    
    self.nicheng = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 20, 10, SCREEN_WIDTH - CGRectGetMaxX(label.frame) - 40, 30)];
    self.nicheng.delegate = self;
    self.nicheng.font = [UIFont systemFontOfSize:15];
    self.nicheng.textColor = navi_bar_bg_color;
    [view_white1 addSubview:self.nicheng];
    
    
    if([[userdefault objectForKey:@"member_nickname"] length] == 0 || [[userdefault objectForKey:@"member_nickname"] isEqualToString:@"<null>"])
    {
        self.nicheng.text = [userdefault objectForKey:@"account"];
    }
    else
    {
        self.nicheng.text = [userdefault objectForKey:@"member_nickname"];
    }
}



#pragma mark - 点击收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.nicheng resignFirstResponder];
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.nicheng resignFirstResponder];
}

//
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [self.nicheng resignFirstResponder];

    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {
        
    }];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.7 animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 150);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 上传昵称
- (void)update:(id )dict
{
//    NSLog(@"%@",dict);
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"保存成功" maskType:(SVProgressHUDMaskTypeBlack)];
            
            NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
            
            [userdefault setObject:self.nicheng.text forKey:@"member_nickname"];
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

#pragma mark - 上传头像
-(void)UploadHeadPic:(id)dict
{
//    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    if ([dict[@"status"][@"succeed"] intValue]==1) {
        //准备刷新头像
        [SVProgressHUD showSuccessWithStatus:@"图片上传成功" maskType:SVProgressHUDMaskTypeBlack];
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];
        
        [userdefault setObject:dict[@"data"][@"member_headpic"] forKey:@"member_headpic"];
        
        [self.touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@uploads/member/%@",Url,dict[@"data"][@"member_headpic"]]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:dict[@"status"][@"message"] maskType:SVProgressHUDMaskTypeBlack];
    }
}


#pragma mark - 点击头像
-(void)tapGesture:(id)sender
{
    NSLog(@"上传图片");
    [self editPortrait];
}

- (void)editPortrait {
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
        
        [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];

        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"UploadHeadPic:"];
        
        [dataprovider UploadHeadPicWithMember_id:[userdefault objectForKey:@"member_id"] member_headpic:imageData];
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
