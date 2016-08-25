//
//  ViewController.h
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSideMenu/VKSideMenu.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,VKSideMenuDelegate, VKSideMenuDataSource,GADBannerViewDelegate, GADInterstitialDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet GADBannerView *BannerView;

@end

