//
//  ViewController.m
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryItem.h"
#import "GalleryItemCollectionViewCell.h"
#import "ImageViewController.h"
#import "AppDelegate.h"
#import "KLCPopup/KLCPopup.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)
#define kRandomText @"\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\""

@interface GalleryViewController ()
{
    NSArray *_galleryItems;
}
@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, strong) GADInterstitial * interstitial_;

@end

@implementation GalleryViewController
@synthesize BannerView;

#pragma mark -
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
//    float h= self.navigationController.navigationBar.frame.size.height;
//    UIButton *mb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
//    [mb setImage:[UIImage imageNamed:@"menu_button.png"] forState:UIControlStateNormal];
//    [mb addTarget:self action:@selector(menuitem) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:mb];
//    self.navigationItem.leftBarButtonItem = menuButton;
//    
//    UIButton *pb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
//    [pb setImage:[UIImage imageNamed:@"plus_button.png"] forState:UIControlStateNormal];
//    [pb addTarget:self action:@selector(additem) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithCustomView:pb];
//    self.navigationItem.rightBarButtonItem = plusButton;
    
//    self.menuLeft = [[VKSideMenu alloc] initWithWidth:[UIScreen mainScreen].bounds.size.width*0.8f andDirection:VKSideMenuDirectionLeftToRight];
//    self.menuLeft.dataSource       = self;
//    self.menuLeft.delegate         = self;
//    self.menuLeft.textColor        = [UIColor whiteColor];
//    self.menuLeft.enableOverlay    = NO;
//    self.menuLeft.hideOnSelection  = NO;
//    self.menuLeft.selectionColor   = [UIColor colorWithWhite:.0 alpha:.3];
//    self.menuLeft.iconsColor       = nil;
//    
//    
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
//        self.menuLeft.blurEffectStyle = UIBlurEffectStyleDark;
//    else
//        self.menuLeft.backgroundColor = [UIColor colorWithWhite:0. alpha:0.8];
    
//    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    BannerView.delegate = self;
    BannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    BannerView.rootViewController = self;
//    
//    [self.view addSubview:BannerView];
    //bannerView.hidden = YES;
    
    GADRequest *request = [GADRequest request];
    [BannerView loadRequest:request];
    [self loadGoogleAdsFull];

    [self initGalleryItems];
//
    [_collectionView reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    //
    //    if (([self.interstitial_ isReady] == YES) && ([APP_DELEGATE.fullScreenBannerShow isEqualToString:@"1"])) {
    //        [self.interstitial_ presentFromRootViewController:self];
    //        APP_DELEGATE.fullScreenBannerShow = @"0";
    //    }else{
    //
    //        self.interstitial_ = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    //        self.interstitial_.delegate = self;
    //
    //        GADRequest *request = [GADRequest request];
    //        request.testDevices = @[ kGADSimulatorID ];
    //        [self.interstitial_ loadRequest:request];
    //    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden=YES;
    //
    //    if (([self.interstitial_ isReady] == YES) && ([APP_DELEGATE.fullScreenBannerShow isEqualToString:@"1"])) {
    //        [self.interstitial_ presentFromRootViewController:self];
    //        APP_DELEGATE.fullScreenBannerShow = @"0";
    //    }else{
    //
    //        self.interstitial_ = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    //        self.interstitial_.delegate = self;
    //
    //        GADRequest *request = [GADRequest request];
    //        request.testDevices = @[ kGADSimulatorID ];
    //        [self.interstitial_ loadRequest:request];
    //    }
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void) loadGoogleAdsFull {
    
    self.interstitial_ = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    self.interstitial_.delegate = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    [self.interstitial_ loadRequest:request];
}

- (void) interstitialDidReceiveAd:(GADInterstitial *)ad
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    BOOL isLanuched = [settings boolForKey:@"launched"];
    if (!isLanuched)
    {
        [settings setBool:YES forKey:@"launched"];
        [settings synchronize];
        return;
    }
    
    if ([self.interstitial_ isReady]) {
        [self.interstitial_ presentFromRootViewController:self];
    }
}
- (void)initGalleryItems
{
    NSMutableArray *items = [NSMutableArray array];
    
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"folders" ofType:@"plist"];
    NSArray *inputDataArray = [NSArray arrayWithContentsOfFile:inputFile];
    
    for (NSString *inputItem in inputDataArray)
    {
        [items addObject:[GalleryItem galleryItemWithDictionary:inputItem]];
    }
    
    _galleryItems = items;
}

#pragma mark -
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_galleryItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GalleryItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GalleryItemCollectionViewCell" forIndexPath:indexPath];
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
    app.gallerynumber = (NSInteger *)indexPath.item;
    ImageViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"imageviewcontroller"];
    [self.navigationController pushViewController:newView animated:YES];
}

#pragma mark -
#pragma mark - UICollectionViewFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = self.view.frame.size.width / 2.5f;
    return CGSizeMake(picDimension, picDimension);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat leftRightInset = self.view.frame.size.width / 14.0f;
    return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset);
}
-(void)additem
{
    //    GetFaceViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"getimageview"];
    //    [self.navigationController pushViewController:newView animated:YES];
    //
    
    
    UIViewController *presentingController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"popupController"];
    
    //    CCMPopupTransitioning *popup = [CCMPopupTransitioning sharedInstance];
    //    if (self.view.bounds.size.height < 420) {
    //        popup.destinationBounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height-20) * .75, [UIScreen mainScreen].bounds.size.height-20);
    //    } else {
    //        popup.destinationBounds = CGRectMake(0, 0, 300, 400);
    //    }
    //    popup.presentedController = presentingController;
    //    popup.presentingController = self;
    //    self.popupController = presentingController;
    //    [self presentViewController:presentingController animated:YES completion:nil];
    
    UIImageView* contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moreappimage"]];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView setFrame:CGRectMake(0, 0, 250, 400)];
    contentView.layer.cornerRadius = 12.0;
    KLCPopupLayout layout = KLCPopupLayoutMake((KLCPopupHorizontalLayout)KLCPopupHorizontalLayoutCenter,
                                               (KLCPopupVerticalLayout)KLCPopupVerticalLayoutCenter);
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:(KLCPopupShowType)  KLCPopupShowTypeBounceIn
                                         dismissType:(KLCPopupDismissType)  KLCPopupDismissTypeBounceOut
                                            maskType:(KLCPopupMaskType)KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:YES];
    
    [popup showWithLayout:layout];

}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.view layoutIfNeeded];
    //    if (size.height < 420) {
    //        [UIView animateWithDuration:[coordinator transitionDuration] animations:^{
    //            self.popupController.view.bounds = CGRectMake(0, 0, (size.height-20) * .75, size.height-20);
    //            [self.view layoutIfNeeded];
    //        }];
    //    } else {
    //        [UIView animateWithDuration:[coordinator transitionDuration] animations:^{
    //            self.popupController.view.bounds = CGRectMake(0, 0, 300, 400);
    //            [self.view layoutIfNeeded];
    //        }];
    //    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //    CCMPopupSegue *popupSegue = (CCMPopupSegue *)segue;
    //    if (self.view.bounds.size.height < 420) {
    //        popupSegue.destinationBounds = CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.height-20) * .75, [UIScreen mainScreen].bounds.size.height-20);
    //    } else {
    //        popupSegue.destinationBounds = CGRectMake(0, 0, 250, 400);
    //    }
    //    popupSegue.backgroundBlurRadius = 7;
    //    popupSegue.backgroundViewAlpha = 0.3;
    //    popupSegue.backgroundViewColor = [UIColor blackColor];
    //    popupSegue.dismissableByTouchingBackground = YES;
    //    self.popupController = popupSegue.destinationViewController;
}
-(void)menuitem
{
    [self.menuLeft show];
}
#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return sideMenu == self.menuLeft ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 4;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft) // All LEFT menu items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Profile";
                item.icon  = [UIImage imageNamed:@"ic_option_1"];
                break;
                
            case 1:
                item.title = @"Messages";
                item.icon  = [UIImage imageNamed:@"ic_option_2"];
                break;
                
            case 2:
                item.title = @"Cart";
                item.icon  = [UIImage imageNamed:@"ic_option_3"];
                break;
                
            case 3:
                item.title = @"Settings";
                item.icon  = [UIImage imageNamed:@"ic_option_4"];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 0) // RIGHT menu first section items
    {
        item.title = @"Login";
        item.icon  = [UIImage imageNamed:@"ic_login"];
    }
    else // RIGHT menu second section items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Like";
                break;
                
            case 1:
                item.title = @"Share";
                break;
            default:
                break;
        }
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSLog(@"%@ VKSideMenue did show", sideMenu == self.menuLeft ? @"LEFT" : @"RIGHT");
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSLog(@"%@ VKSideMenue did hide", sideMenu == self.menuLeft ? @"LEFT" : @"RIGHT");
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}


@end
