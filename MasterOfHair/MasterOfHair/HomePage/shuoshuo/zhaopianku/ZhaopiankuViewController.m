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

//

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
    if(self.assetsArray.count == 0)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择一张图片再发表" preferredStyle:(UIAlertControllerStyleAlert)];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:action];
    }
    else
    {
        if([self.text_View.text length] == 0)
        {
            self.label_placeHold.hidden = NO;
        }
        [self.text_View resignFirstResponder];
    
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
    if(self.assetsArray.count == 6)
    {
        return 6;
    }
    else
    {
        return self.assetsArray.count + 1;
    }
}

- (UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZhaopiankuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_photo" forIndexPath:indexPath];

    if(self.assetsArray.count != 6)
    {
//        cell.image.image = [UIImage imageNamed:@"shuoshuo98765"];
        if(indexPath.item < self.assetsArray.count)
        {
            JKAssets * asset = self.assetsArray[indexPath.row];
            
            ALAssetsLibrary * lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    
                    cell.image.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                }
                
            }failureBlock:^(NSError *error) {
                
            }];
            cell.image.tag = (indexPath.row + 100);
            
            cell.btn.hidden = NO;
            cell.btn.tag = indexPath.row + 10000;
            [cell.btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        else
        {
            cell.image.image = [UIImage imageNamed:@"shuoshuo98765"];
            cell.btn.hidden = YES;

        }
    }
    else
    {
        JKAssets * asset = self.assetsArray[indexPath.row];
        
        ALAssetsLibrary * lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                
                cell.image.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            }
            
        }failureBlock:^(NSError *error) {
            
        }];
        cell.image.tag = (indexPath.row + 100);
        
        cell.btn.hidden = NO;
        cell.btn.tag = indexPath.row + 10000;
        [cell.btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self composePicAdd];
}

#pragma mark - 删除图片
- (void)btnAction:(UIButton *)sender
{
    if(self.assetsArray.count == 1)
    {
        [self.assetsArray removeObjectAtIndex:0];
        self.assetsArray = nil;
    }
    else
    {
        [self.assetsArray removeObjectAtIndex:sender.tag - 10000];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新tableView(记住,要更新放在主线程中)
        [self.collectionView reloadData];
    });
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
    self.assetsArray = nil;
    
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{

        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新tableView(记住,要更新放在主线程中)
            [self.collectionView reloadData];
        });
        
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
