//
//  ViewController.m
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageItem.h"
#import "ImageItemCollectionViewCell.h"
#import "GetFaceViewController.h"
#import "AppDelegate.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface ImageViewController ()
{
    NSArray *_galleryItems;
    NSArray *imageArray;
}

@end

@implementation ImageViewController

#pragma mark -
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(progress == nil) {
        progress = [[MBProgressHUD alloc] initWithView:self.view];
    }

    
    [self.view addSubview:progress];
    progress.dimBackground = YES;
    progress.delegate = self;
    [progress show:YES];
    
    self.navigationController.navigationBarHidden=NO;
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    float h= self.navigationController.navigationBar.frame.size.height;
    float w= self.navigationController.navigationBar.frame.size.width;
   
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectframe"]];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    UIView* titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w/2, 44)];
//    imageView.frame = titleView.bounds;
//    [titleView addSubview:imageView];
//    self.navigationItem.titleView = titleView;
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:h*0.6]}];
    self.navigationItem.title=@"Select Frame";
//    [self.navigationItem.titleView setFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
    UIButton *pb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
    [pb setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [pb addTarget:self action:@selector(backitem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithCustomView:pb];
    self.navigationItem.leftBarButtonItem = plusButton;

    [self initGalleryItems];
    
    [_collectionView reloadData];
}
-(void)endFill {
//    scrollContainer.userInteractionEnabled = true;
    [progress hide:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.1f];

}
- (void)initGalleryItems
{
    NSMutableArray *items = [NSMutableArray array];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"icons" ofType:@"plist"];
    NSArray *inputDataArray = [NSArray arrayWithContentsOfFile:inputFile];
    imageArray = [inputDataArray objectAtIndex:(int)app.gallerynumber];
    for (NSString *inputItem in imageArray)
    {
        [items addObject:[ImageItem galleryItemWithDictionary:(NSString *)inputItem]];
    }
    
    _galleryItems = items;
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_galleryItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageItemCollectionViewCell" forIndexPath:indexPath];
    [cell setGalleryItem:_galleryItems[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark -
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UIAlertController *controller = [UIAlertController alertControllerWithTitle: @"didSelectItemAtIndexPath:"
    //                                                                        message: [NSString stringWithFormat: @"Indexpath = %@", indexPath]
    //                                                                 preferredStyle: UIAlertControllerStyleAlert];
    //
    //    UIAlertAction *alertAction = [UIAlertAction actionWithTitle: @"Dismiss"
    //                                                          style: UIAlertActionStyleDestructive
    //                                                        handler: nil];
    //
    //    [controller addAction: alertAction];
    //
    //    [self presentViewController: controller animated: YES completion: nil];
    //
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.imageName = [imageArray objectAtIndex:indexPath.row];
    app.imagenumber=(NSInteger)indexPath.row;
    [progress show:YES];

    GetFaceViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"getimageview"];
    [self.navigationController pushViewController:newView animated:YES];
}

#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = self.view.frame.size.width / 2.2f;
    return CGSizeMake(picDimension, picDimension);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat leftRightInset = self.view.frame.size.width / 100.0f;
    return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset);
}

-(void)backitem
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.1f];

}

@end
