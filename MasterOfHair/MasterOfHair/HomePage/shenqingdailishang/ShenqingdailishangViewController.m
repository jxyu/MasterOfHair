//
//  ShenqingdailishangViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/2.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ShenqingdailishangViewController.h"
#import "VPImageCropperViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f
@interface ShenqingdailishangViewController () <UITextFieldDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,VPImageCropperDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

//
@property (nonatomic, strong) UITextField * name;
@property (nonatomic, strong) UITextField * tel;
//
@property (nonatomic, strong) UIImageView * image_1;
@property (nonatomic, strong) UIImageView * image_2;
@property (nonatomic, strong) UIImageView * image_3;
@property (nonatomic, strong) UIImageView * image_4;
//
@property (nonatomic, strong) UIButton * btn_zhifu;

//存放
@property (nonatomic, strong) UIImageView * portraitImageView;

@property (nonatomic, strong) NSData * data1;
@property (nonatomic, strong) NSData * data2;
@property (nonatomic, strong) NSData * data3;
@property (nonatomic, strong) NSData * data4;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ShenqingdailishangViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"申请代理商"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    _lblLeft.text=@"返回";
    _lblLeft.textAlignment=NSTextAlignmentLeft;
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

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60)];
    [self.view addSubview:self.scrollView];
    
    
    
    UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    view_1.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_1];
    
    UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_1.text = @"联系人姓名";
    [view_1 addSubview:label_1];
    
    self.name = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_1.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_1.frame) - 15, 30)];
    self.name.placeholder = @"请输入联系人真实姓名";
    self.name.delegate = self;
    self.name.clearButtonMode = UITextFieldViewModeAlways;
    [view_1 addSubview:self.name];
    
    
    UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_1.frame) + 2, SCREEN_WIDTH, 50)];
    view_2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_2];
    
    UILabel * label_2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    label_2.text = @"联系方式";
    [view_2 addSubview:label_2];
    
    self.tel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label_2.frame) + 5, 10, SCREEN_WIDTH - CGRectGetMaxX(label_2.frame) - 15, 30)];
    self.tel.placeholder = @"请输入联系人联系方式";
    self.tel.delegate = self;
    self.tel.clearButtonMode = UITextFieldViewModeAlways;
    [view_2 addSubview:self.tel];

    
    UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_2.frame) + 10, SCREEN_WIDTH, 130)];
    view_3.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_3];
    
    UILabel * label_3 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 15)];
    label_3.text = @"上传法人身份证正反面";
    label_3.font = [UIFont systemFontOfSize:13];
    label_3.textColor = [UIColor grayColor];
    [view_3 addSubview:label_3];
    
    self.image_1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label_3.frame) + 10, 86, 86)];
//    self.image_1.backgroundColor = [UIColor orangeColor];
    self.image_1.image = [UIImage imageNamed:@"placeholder_short.jpg"];
    [view_3 addSubview:self.image_1];
    
    //手势
    self.image_1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.image_1 addGestureRecognizer:tapGesture];
    
    self.image_2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_1.frame) + 15, CGRectGetMaxY(label_3.frame) + 10, 86, 86)];
    //    self.image_1.backgroundColor = [UIColor orangeColor];
    self.image_2.image = [UIImage imageNamed:@"placeholder_short.jpg"];
    [view_3 addSubview:self.image_2];
    
    //手势
    self.image_2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture2:)];
    tapGesture2.numberOfTapsRequired = 1; //点击次数
    tapGesture2.numberOfTouchesRequired = 1; //点击手指数
    [self.image_2 addGestureRecognizer:tapGesture2];
    
    UIView * view_4 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view_3.frame) + 10, SCREEN_WIDTH, 130)];
    view_4.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:view_4];
    
    UILabel * label_4 = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 15)];
    label_4.text = @"上传企业组织机构代码证、企业营业执照";
    label_4.font = [UIFont systemFontOfSize:13];
    label_4.textColor = [UIColor grayColor];
    [view_4 addSubview:label_4];
    
    self.image_3 = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label_4.frame) + 10, 86, 86)];
    //    self.image_3.backgroundColor = [UIColor orangeColor];
    self.image_3.image = [UIImage imageNamed:@"placeholder_short.jpg"];
    [view_4 addSubview:self.image_3];
    
    self.image_3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture3:)];
    tapGesture3.numberOfTapsRequired = 1; //点击次数
    tapGesture3.numberOfTouchesRequired = 1; //点击手指数
    [self.image_3 addGestureRecognizer:tapGesture3];
    
    
    
    self.image_4 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image_3.frame) + 15, CGRectGetMaxY(label_4.frame) + 10, 86, 86)];
    //    self.image_4.backgroundColor = [UIColor orangeColor];
    self.image_4.image = [UIImage imageNamed:@"placeholder_short.jpg"];
    [view_4 addSubview:self.image_4];
    
    self.image_4.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture4:)];
    tapGesture4.numberOfTapsRequired = 1; //点击次数
    tapGesture4.numberOfTouchesRequired = 1; //点击手指数
    [self.image_4 addGestureRecognizer:tapGesture4];

    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(view_4.frame) + 15);

    
    self.btn_zhifu = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.btn_zhifu.frame = CGRectMake(15, SCREEN_HEIGHT - 55, SCREEN_WIDTH - 30, 45);
    self.btn_zhifu.backgroundColor = navi_bar_bg_color;
    [self.btn_zhifu setTitle:@"申请提交" forState:(UIControlStateNormal)];
    [self.btn_zhifu setTintColor:[UIColor whiteColor]];
    self.btn_zhifu.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.btn_zhifu];
    
    [self.btn_zhifu addTarget:self action:@selector(btn_zhifuAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

#pragma mark - btn申请提交
- (void)btn_zhifuAction:(UIButton *)sender
{
    NSLog(@"提交");
    
    if([self.name.text length] == 0 || [self.tel.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入真实姓名或联系方式" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
    }
    else if([self.image_1.image isEqual:[UIImage imageNamed:@"placeholder_short.jpg"]] || [self.image_2.image isEqual:[UIImage imageNamed:@"placeholder_short.jpg"]] || [self.image_3.image isEqual:[UIImage imageNamed:@"placeholder_short.jpg"]] || [self.image_4.image isEqual:[UIImage imageNamed:@"placeholder_short.jpg"]] )
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请上传相应的照片信息" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
    }
    else
    {
        [self.tel resignFirstResponder];
        [self.name resignFirstResponder];
        
//        NSLog(@"提交申请");
        
        NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults];

        DataProvider * dataprovider=[[DataProvider alloc] init];
        [dataprovider setDelegateObject:self setBackFunctionName:@"update:"];
        
//        NSLog(@"%@",self.data1);
        [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];

        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] applyAgent_name:self.name.text applyAgent_phone:self.tel.text idcard_frond:self.data1 idcard_side:self.data2 framework_image:self.data3 business_image:self.data4];

//        [dataprovider createWithMember_id:[userdefault objectForKey:@"member_id"] applyAgent_name:self.name.text applyAgent_phone:self.tel.text idcard_frond:self.data1 idcard_side:self.data2 framework_image:self.data3 business_image:self.data4];
    }
}

#pragma mark - 上传图文
- (void)update:(id )dict
{
    NSLog(@"%@",dict);
    
    [SVProgressHUD dismiss];
    
    if ([dict[@"status"][@"succeed"] intValue] == 1) {
        @try
        {
            [SVProgressHUD showSuccessWithStatus:@"上传成功" maskType:(SVProgressHUDMaskTypeBlack)];
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



#pragma mark - 提交照片
-(void)tapGesture:(id)sender
{
    self.index = 1;
    
    [self p_pick];
}

-(void)tapGesture2:(id)sender
{
    self.index = 2;
    
    [self p_pick];

}

-(void)tapGesture3:(id)sender
{
    self.index = 3;
    
    [self p_pick];
}

-(void)tapGesture4:(id)sender
{
    self.index = 4;
    
    [self p_pick];
}

#pragma mark - textField 
- (BOOL )textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tel resignFirstResponder];
    
    [self.name resignFirstResponder];
}

- (void)p_pick
{
    [self.tel resignFirstResponder];
    
    [self.name resignFirstResponder];
    
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
        
        
        switch (self.index)
        {
            case 1:
            {
                self.image_1.image = editedImage;
                
                self.data1 = imageData;
            }
                break;
            case 2:
            {
                self.image_2.image = editedImage;
                
                self.data2 = imageData;
            }
                break;
            case 3:
            {
                self.image_3.image = editedImage;
                
                self.data3 = imageData;
            }
                break;
            case 4:
            {
                self.image_4.image = editedImage;
                
                self.data4 = imageData;
            }
                break;
            default:
                break;
        }
        
        
//        [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeBlack];
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
