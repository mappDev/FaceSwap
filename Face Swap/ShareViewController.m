//
//  UIViewController+CameraViewController.m
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import "ShareViewController.h"
#import "ImageViewController.h"
#import "GalleryViewController.h"
#import "AppDelegate.h"

@interface ShareViewController(){
    UIView *bview;
    UIImageView *saveview;
}

@end

@implementation ShareViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setAlpha:1];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];

    float h= self.navigationController.navigationBar.frame.size.height;
    self.navigationItem.title=@"Save/Send";


    UIButton *bb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
    [bb setImage:[UIImage imageNamed:@"back_button.png"] forState:UIControlStateNormal];
    [bb addTarget:self action:@selector(backitem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:bb];
    self.navigationItem.leftBarButtonItem = backButton;

    UIButton *hb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*h, 0.6f*h)];
    [hb setImage:[UIImage imageNamed:@"home_button.png"] forState:UIControlStateNormal];
    [hb addTarget:self action:@selector(homeitem) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithCustomView:hb];
    self.navigationItem.rightBarButtonItem = homeButton;

    AppDelegate *app =[UIApplication sharedApplication].delegate;
    float w=[UIScreen mainScreen].bounds.size.width;
    float hh=[UIScreen mainScreen].bounds.size.height;
    CGFloat iw=app.saveImage.size.width;
    CGFloat ih=app.saveImage.size.height;
    saveview=[[UIImageView alloc] initWithFrame:CGRectMake(5,5, w*0.7f,ih*0.7f*w/iw)];
    bview=[[UIView alloc] initWithFrame:CGRectMake(0,0, w*0.7f+10,ih*0.7f*w/iw+10)];
    saveview.image=app.saveImage;
    [bview addSubview:saveview];
    [self.view addSubview:bview];
    bview.backgroundColor=[UIColor greenColor];
    saveview.backgroundColor=[UIColor whiteColor];
    bview.center=CGPointMake(w/2, hh/2-30);
    
    
    
//    [saveimageview setFrame:CGRectMake(0,0, w,ih*w/iw)];
//    saveimageview.image= app.saveImage;
//    saveimageview.backgroundColor=[UIColor redColor];
//    [backview setFrame:CGRectMake(0, 0, w+10, ih*w/iw+10) ];
//    backview.backgroundColor=[UIColor greenColor];
//    [backview addSubview:saveimageview];
//    [self.view addSubview:backview];
    
    
   
//    UIBarButtonItem *homeitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                                                                target:self
//                                                                                action:@selector(homeitem)];
//    self.navigationItem.rightBarButtonItem = homeitem;
//    UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
//                                                                                target:self
//                                                                                action:@selector(backitem)];
//    self.navigationItem.leftBarButtonItem = backitem;
    // Do any additional setup after loading the view, typically from a nib.
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)homeitem{
        GalleryViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
        [self.navigationController pushViewController:newView animated:YES];
}
-(void)backitem{

    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButton:(id)sender {
    
        if(saveview.image){
            NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
            
            UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[saveview.image] applicationActivities:nil];
            
            activityView.excludedActivityTypes = excludedActivityTypes;
            activityView.completionHandler = ^(NSString *activityType, BOOL completed){
                if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved successfully" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            };
            
            [self presentViewController:activityView animated:YES completion:nil];
        }
        else{
//            [self pushedNewBtn];
        }
    
}
//- (IBAction)facebookShareBtnClick:(id)sender {
////    Face *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"imageviewcontroller"];
////    [self.navigationController pushViewController:newView animated:YES];
////    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
////    
////    //    [login logInWithReadPermissions: @[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
////    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
////        if (error) {
////            NSLog(@"Process error");
////        } else if (result.isCancelled) {
////            NSLog(@"Cancelled");
////        } else {
////            NSLog(@"Logged in with token : @%@", result.token);
////            if ([result.grantedPermissions containsObject:@"email"]) {
////                [self fetchUserFacebookInfo];
////            }
////        }
////    }];
//}
//
//- (void)fetchUserFacebookInfo {
//    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, gender, bio, location, friends, hometown, friendlists"}]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"facebook fetched info : %@", result);
////                 tempFB = (NSDictionary *)result;
//                 //                 [self dataRefreshFB];
//                 
//             } else {
//                 NSLog(@"Error %@",error);
//             }
//         }];
//    }
//}

@end
