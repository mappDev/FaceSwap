//
//  UIViewController+GetFaceViewController.h
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditToolView.h"
#import "ResizeToolView.h"
#import "GPUImage.h"
#import "MBProgressHUD.h"
typedef enum
{
    FilterPosterize = 0,
    FilterSaturate,
    FilterBrightness,
    FilterContrast,
    FilterGamma,
    FilterNoise,
    FilterInvert,
    FilterTotal
} FilterOptions;
@interface GetFaceViewController:UIViewController<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,EditToolViewDelegate,ResizeToolViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate>
{
    FilterOptions activeFilter;
        MBProgressHUD *progress;
}
@property (weak, nonatomic) IBOutlet UIScrollView *sliderView;
@property (weak, nonatomic) IBOutlet UIView *TotalImageView;
@property (strong, nonatomic) IBOutlet UIView *bottombar;
@property (strong, nonatomic) IBOutlet UIView *bottombar1;
@property (strong, nonatomic) IBOutlet UIView *frameview;
@property (strong, nonatomic) IBOutlet UIView *cameraview;
@property (strong, nonatomic) IBOutlet UIView *bottombar2;
@property (strong, nonatomic) UIImageView *frameimageview;
@property (strong, nonatomic) UIImageView *cameraimageview;
@property (strong, nonatomic) IBOutlet UIView *bottomtoolbar;
- (IBAction)bottombackbutton:(id)sender;
@property (strong, nonatomic) EditToolView *edittoolview;
@property (strong, nonatomic) ResizeToolView *resizetoolview;
@property (assign) int flipscale;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer;

- (IBAction)camerabutton:(id)sender;
- (IBAction)librarybutton:(id)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)frontback:(id)sender;
- (IBAction)editbutton:(id)sender;
- (IBAction)resizebutton:(id)sender;
- (IBAction)flipbutton:(id)sender;
- (IBAction)previewbutton:(id)sender;
- (IBAction)resetbutton:(id)sender;


@end
