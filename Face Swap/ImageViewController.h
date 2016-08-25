//
//  ViewController.h
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ImageViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *progress;

}
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

