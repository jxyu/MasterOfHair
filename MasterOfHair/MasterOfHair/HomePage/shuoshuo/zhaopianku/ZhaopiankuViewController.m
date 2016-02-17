//
//  ZhaopiankuViewController.m
//  MasterOfHair
//
//  Created by 鞠超 on 16/2/16.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "ZhaopiankuViewController.h"
#import "ZhaopiankuCollectionViewCell.h"

#import "JKImagePickerController.h"
#import "JKAssets.h"
@interface ZhaopiankuViewController () <UITextViewDelegate, UIScrollViewDelegate, JKImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UITextView * text_View;
@property (nonatomic, strong) UILabel * label_placeHold;
//

@property (nonatomic, strong) UICollectionView * collectionView;


//数组
@property (nonatomic, strong) NSMutableArray * assetsArray;

@end

@implementation ZhaopiankuViewController

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
    _lblTitle.text = [NSString stringWithFormat:@"发布说说"];
    _lblTitle.font = [UIFont systemFontOfSize:19];
    
    [self addLeftButton:@"iconfont-fanhui"];
    
    //右边为定位
    [self addRightbuttontitle:@"发布"];
    _lblRight.font = [UIFont systemFontOfSize:18];
    _lblRight.frame = CGRectMake(SCREEN_WIDTH - 65, 19, 50, 44);
    _btnRight.frame = _lblRight.frame;
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

- (void)clickRightButton:(UIButton *)sender
{
    //    NSLog(@"发布");
    if([self.text_View.text length] == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文字后再发布" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        NSLog(@"发布成功");
    }
}

#pragma mark - 布局
- (void)p_setupView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 30);
    [self.view addSubview:self.scrollView];
    
    
    self.text_View = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.text_View.delegate = self;
    self.text_View.font = [UIFont systemFontOfSize:17];
    [self.scrollView addSubview:self.text_View];
    
    self.label_placeHold = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 100, 20)];
    self.label_placeHold.text = @"说点什么吧...";
    self.label_placeHold.textColor = [UIColor grayColor];
    [self.text_View addSubview:self.label_placeHold];
    
    
    //collectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    //每个item的大小
    CGFloat item_length = (SCREEN_WIDTH - 40) / 3;
    layout.itemSize = CGSizeMake(item_length, item_length);
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
//    CGFloat length_x = (SCREEN_WIDTH - 40) / 3;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.text_View.frame) + 10, SCREEN_WIDTH, item_length * 2 + 30) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[ZhaopiankuCollectionViewCell class] forCellWithReuseIdentifier:@"cell_photo"];
}

#pragma mark - collectionView代理

- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhaopiankuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_photo" forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark - 图片
- (void)composePicAdd
{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 6;
    imagePickerController.selectedAssetArray = self.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}

#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
        JKAssets * asset = self.assetsArray.firstObject;
        
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
//                self.image_1.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            }
        } failureBlock:^(NSError *error) {
            
        }];

    }];
}

- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - text代理 和 点击方法
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

#pragma mark - scrollView
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([self.scrollView isEqual:scrollView])
    {
        [self.text_View resignFirstResponder];
        
        if([self.text_View.text length] == 0)
        {
            self.label_placeHold.hidden = NO;
        }
    }
}




@end
