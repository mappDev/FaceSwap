//
//  UIViewController+GetFaceViewController.m
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import "GetFaceViewController.h"
#import "ShareViewController.h"
#import "NYXImagesKit.h"
#import "AppDelegate.h"
#import "InfinitePagingView.h"
#import <AVFoundation/AVFoundation.h>
@interface GetFaceViewController ()<InfinitePagingViewDelegate>
{
    AVCaptureSession *session;
    AVCaptureStillImageOutput *stillImageOutput;
    AVCaptureVideoPreviewLayer *previewLayer;
    UIButton *mb;
    UIButton *cb;
    float h,w;
    CGFloat lastRotation;
    CGFloat lastScale,lastScalex,lastScaley;
    CGFloat lastX, lastY;
    UIImage *CameraImage;
    CGFloat navheight,staheight;
    BOOL fb;
    UIImage *flipCameraImage;
    UIBarButtonItem *closeButton,*menuButton,*cameraButton,*libraryButton,*actionButton;
    NSArray *rightbuttons;
    BOOL btakePhoto;
    BOOL bfirsttakeCamera,bsecondtakeCamera;
    UIPageControl *pageControl;
    InfinitePagingView *pagingView;
    NSMutableArray *imageArray;
    NSMutableArray *items;
    UIImage *frameimage;
    BOOL bPreview;
    float bv,cv,hv,sv;
    BOOL bcameraimage;
    float cx,cy,ss;
    int selnumber;
}
@end

@implementation GetFaceViewController
@synthesize edittoolview;
@synthesize resizetoolview;
@synthesize flipscale;
@synthesize TotalImageView;
@synthesize frameimageview;
@synthesize cameraimageview;
@synthesize frameview;
@synthesize cameraview;
@synthesize sliderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(progress == nil) {
        progress = [[MBProgressHUD alloc] initWithView:self.view];
    }
    
    [self.view addSubview:progress];
    progress.dimBackground = YES;
    progress.delegate = self;
    [progress show:YES];
    ss=1;
    cx=0;
    cy=0;

    
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    self.navigationItem.title=@"Take Your Photo";

    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    h= self.view.frame.size.height;
    w= self.view.frame.size.width;
//    h= [UIScreen mainScreen].bounds.size.height;
//    w= [UIScreen mainScreen].bounds.size.height;
    navheight=self.navigationController.navigationBar.frame.size.height;
    staheight=[UIApplication sharedApplication].statusBarFrame.size.height;
    staheight=0;
    hv=50;
    cv=50;
    bv=50;
    sv=50;
    bcameraimage=YES;
    mb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*navheight, 0.6f*navheight)];
    [mb setImage:[UIImage imageNamed:@"back_button"] forState:UIControlStateNormal];
    [mb addTarget:self action:@selector(undoitem) forControlEvents:UIControlEventTouchUpInside];
    menuButton = [[UIBarButtonItem alloc] initWithCustomView:mb];
    self.navigationItem.leftBarButtonItem = menuButton;

    cb=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*navheight, 0.6f*navheight)];
    [cb setImage:[UIImage imageNamed:@"close_button"] forState:UIControlStateNormal];
    [cb addTarget:self action:@selector(closeitem) forControlEvents:UIControlEventTouchUpInside];
    closeButton = [[UIBarButtonItem alloc] initWithCustomView:cb];
    self.navigationItem.rightBarButtonItem = closeButton;
    
//    actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionitem)];
    
    UIButton *camera=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*navheight, 0.6f*navheight)];
    [camera setImage:[UIImage imageNamed:@"camera_icon"] forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(cameraitem) forControlEvents:UIControlEventTouchUpInside];
    cameraButton = [[UIBarButtonItem alloc] initWithCustomView:camera];
    UIButton *action=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*navheight, 0.6f*navheight)];
    [action setImage:[UIImage imageNamed:@"action_button"] forState:UIControlStateNormal];
    [action addTarget:self action:@selector(actionitem) forControlEvents:UIControlEventTouchUpInside];
    actionButton = [[UIBarButtonItem alloc] initWithCustomView:action];
    
    UIButton *library=[[UIButton alloc] initWithFrame:CGRectMake(0,0, 0.6f*navheight, 0.6f*navheight)];
    [library setImage:[UIImage imageNamed:@"library_icon"] forState:UIControlStateNormal];
    [library addTarget:self action:@selector(libraryitem) forControlEvents:UIControlEventTouchUpInside];
    libraryButton = [[UIBarButtonItem alloc] initWithCustomView:library];
    
    rightbuttons=[[NSArray alloc] initWithObjects:actionButton,libraryButton,cameraButton, nil];
    
    [cb setHidden:YES];
    
    flipscale = 1;
    CameraImage = [[UIImage alloc] init];
    
    lastScale = 1.0f;
    lastScalex = 1.0f;
    lastScaley = 1.0f;
    lastRotation = 0.0f;
    fb=YES;
    btakePhoto = NO;
    bfirsttakeCamera = YES;
    bsecondtakeCamera = NO;
    bPreview=YES;
    [self.bottombar2 setHidden:YES];

    [TotalImageView setFrame:CGRectMake(0, navheight, w, h-navheight-50)];
    
    [cameraview setFrame:self.TotalImageView.frame];
//    [frameview setFrame:self.TotalImageView.frame];
    cameraimageview = [[UIImageView alloc] initWithFrame:self.cameraview.frame];
    [cameraimageview setContentMode:UIViewContentModeScaleAspectFill];
    [frameview addSubview:cameraimageview];
    frameimageview = [[UIImageView alloc] initWithFrame:self.frameview.frame];

//    AppDelegate *app =[UIApplication sharedApplication].delegate;
//    UIImage *fimage=[UIImage imageNamed:app.imageName];
    
//    GPUImageBrightnessFilter *stillImageFilter2 = [[GPUImageBrightnessFilter alloc] init];
//    UIImage *quickFilteredImage = [stillImageFilter2 imageByFilteringImage:fimage];
    
    [frameimageview setContentMode:UIViewContentModeScaleAspectFit];
    [frameview addSubview:frameimageview];

//    pagingView = [[InfinitePagingView alloc] initWithFrame:TotalImageView.frame];
//    pagingView.delegate = self;
    [self initGalleryItems];
//    [self.TotalImageView addSubview:pagingView];
    
   
    
    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePinch:)];
    pgr.delegate = self;
    [frameview addGestureRecognizer:pgr];
    UIRotationGestureRecognizer *rgr = [[UIRotationGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handleRotate:)];
    rgr.delegate = self;
    [frameview addGestureRecognizer:rgr];
    UIPanGestureRecognizer *pagr = [[UIPanGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePan:)];
    pagr.delegate = self;
    [frameview addGestureRecognizer:pagr];
    
    edittoolview=[[EditToolView alloc]init];
    [self.view addSubview:edittoolview];
    edittoolview.delegate=self;
    resizetoolview=[[ResizeToolView alloc]init];
    [self.view addSubview:resizetoolview];
    resizetoolview.delegate=self;
    [self firstview];
//===================
    session=[[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];
    AVCaptureDevice *inputDevice = nil;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *camera in devices) {
        if([camera position] == AVCaptureDevicePositionFront) { // is front camera
            inputDevice = camera;
            break;
        }
    }
    NSError *error;
    AVCaptureDeviceInput *deviceInput=[AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
    
    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }
    
    
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [cameraview layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = CGRectMake(0, navheight+staheight, self.view.frame.size.width, self.view.frame.size.height-navheight-staheight-50);
    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:1];
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
   

}
-(void)endFill {
    //    scrollContainer.userInteractionEnabled = true;
    [progress hide:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.2f];
    
}

- (void)initGalleryItems
{
    items = [NSMutableArray array];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"items" ofType:@"plist"];
    NSArray *inputDataArray = [NSArray arrayWithContentsOfFile:inputFile];
    imageArray =[NSMutableArray arrayWithArray:[inputDataArray objectAtIndex:(int)app.gallerynumber]];
    selnumber=(int)app.imagenumber;
//    if (app.imagenumber==0) {
//        NSString *strtemp=[imageArray lastObject];
//        [imageArray removeLastObject];
//        [imageArray insertObject:strtemp atIndex:0];
//        selnum++;
////        NSLog(@"%d",(int)app.imagenumber);
////        app.imagenumber=(int)app.imagenumber+1;
////        NSLog(@"%d",(int)app.imagenumber);
//    }
//    else if((int)app.imagenumber==(int)(imageArray.count-1)){
//        NSString *strtemp=[imageArray objectAtIndex:0];
//        [imageArray removeObjectAtIndex:0];
//        [imageArray insertObject:strtemp atIndex:imageArray.count-1];
////        NSLog(@"%d",(int)app.imagenumber);
////        app.imagenumber=(int)app.imagenumber-1;
////        NSLog(@"%d",(int)app.imagenumber);
//        selnum--;
//    }
//
    for (int i=0 ; i< imageArray.count; i++)
    {
        UIImage *image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
//        UIImageView *page = [[UIImageView alloc] initWithImage:image];
//        page.frame = CGRectMake(0.f, 0.f, pagingView.frame.size.width , pagingView.frame.size.height );
//        page.contentMode = UIViewContentModeScaleAspectFit;
//        [pagingView addPageView:page];
        [items addObject:image];
    }
    frameimage=[items objectAtIndex:selnumber];
    frameimageview.image=frameimage;
//    pagingView.currentPageIndex=(NSInteger)selnum;
}
- (void)initpoint
{
    NSMutableArray *ips = [NSMutableArray array];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSString *inputFile = [[NSBundle mainBundle] pathForResource:@"idata" ofType:@"plist"];
    NSArray *inputDataArray = [NSArray arrayWithContentsOfFile:inputFile];
    NSArray *iparray = [inputDataArray objectAtIndex:(int)app.gallerynumber];
    NSArray *ipdata = [iparray objectAtIndex:selnumber];
    ss=[(NSString *)[ipdata objectAtIndex:0] floatValue];
    cx=[(NSString *)[ipdata objectAtIndex:1] floatValue];
    cy=[(NSString *)[ipdata objectAtIndex:2] floatValue];
    
}

#pragma mark - InfinitePagingViewDelegate

- (void)pagingView:(InfinitePagingView *)pagingView didEndDecelerating:(UIScrollView *)scrollView atPageIndex:(NSInteger)pageIndex
{
    pageControl.currentPage = pageIndex;
//    [frameimageview setImage:[UIImage imageNamed:[items objectAtIndex:pageIndex]]];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:frameview];
    cameraimageview.center = CGPointMake(cameraimageview.center.x + translation.x,
                                         cameraimageview.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:frameview];
    [frameview setAlpha:0.5f];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [frameview setAlpha:1];
//        
//        CGPoint velocity = [recognizer velocityInView:self.cameraview.superview];
//        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
//        CGFloat slideMult = magnitude / 200;
//        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
//        
//        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
//        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
//                                         recognizer.view.center.y + (velocity.y * slideFactor));
//        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
//        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
//        
//        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            recognizer.view.center = finalPoint;
//        } completion:nil];
//        
   }
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    [frameview setAlpha:0.5f];
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, recognizer.scale, recognizer.scale);
    lastScale = lastScale * recognizer.scale;
    recognizer.scale = 1;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [frameview setAlpha:1];
    }
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    
    [frameview setAlpha:0.5f];
    cameraimageview.transform = CGAffineTransformRotate(cameraimageview.transform, recognizer.rotation);
    lastRotation = lastRotation + recognizer.rotation;
    recognizer.rotation = 0;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [frameview setAlpha:1];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)resetcameraView{
    cameraimageview.image=CameraImage;
    CGFloat scalex=1;
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, scalex/lastScalex, 1);
    lastScalex= scalex;
    CGFloat scaley=1;
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, 1, scaley/lastScaley);
    lastScaley= scaley;
    cameraimageview.center=CGPointMake(frameview.frame.size.width/2-cx*w, frameview.frame.size.height/2-cy*h) ;
    cameraimageview.center=CGPointMake(frameview.frame.size.width/2-cx*w, frameview.frame.size.height/2-cy*h) ;
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, 1 /lastScale/lastScalex, 1/lastScale/lastScaley);
    cameraimageview.transform = CGAffineTransformRotate(cameraimageview.transform, -lastRotation);
    lastRotation = 0;
    lastScale = 1;
    lastScalex = 1;
    lastScaley = 1;
    flipscale = 1;
}
- (IBAction)takePhoto:(UIButton *)sender {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            CameraImage = [UIImage imageWithData:imageData];
            if (fb) {
                flipCameraImage= [UIImage imageWithCGImage:CameraImage.CGImage scale:CameraImage.scale orientation:(CameraImage.imageOrientation + 3) % 8];
                CameraImage=flipCameraImage;
                
            }
            
            cameraimageview.image = CameraImage;
            cameraimageview.center=CGPointMake(frameview.frame.size.width/2-cx*w, frameview.frame.size.height/2-cy*h) ;
        }
    }];
    
    bcameraimage=YES;
    [self thirdview];
    [session stopRunning];
    
}
- (IBAction)frontback:(id)sender {
    
    //    AVCaptureDevice *inputDevice=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if(session)
    {
        [session beginConfiguration];
        
        AVCaptureInput *currentCameraInput = [session.inputs objectAtIndex:0];
        
        [session removeInput:currentCameraInput];
        
        AVCaptureDevice *newCamera = nil;
        
        if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack)
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            fb=YES;
        }
        else
        {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            fb=NO;
        }
        
        NSError *err = nil;
        
        AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:&err];
        
        if(!newVideoInput || err)
        {
            NSLog(@"Error creating capture device input: %@", err.localizedDescription);
        }
        else
        {
            [session addInput:newVideoInput];
        }
        
        [session commitConfiguration];
    }}

- (IBAction)editbutton:(id)sender {
    [edittoolview setHidden:NO];
}

- (IBAction)resizebutton:(id)sender {
    [resizetoolview setHidden:NO];
}

- (IBAction)flipbutton:(id)sender {
    [progress show:YES];
    if (bcameraimage) {
        flipCameraImage= fb ? [UIImage imageWithCGImage:CameraImage.CGImage scale:CameraImage.scale orientation:(CameraImage.imageOrientation + 5) % 8]:[UIImage imageWithCGImage:CameraImage.CGImage scale:CameraImage.scale orientation:(CameraImage.imageOrientation + 3) % 8];
    }
    else{
        flipCameraImage= fb ? [UIImage imageWithCGImage:CameraImage.CGImage scale:CameraImage.scale orientation:(CameraImage.imageOrientation + 4) % 8]:[UIImage imageWithCGImage:CameraImage.CGImage scale:CameraImage.scale orientation:(CameraImage.imageOrientation + 4) % 8];

    }

    if (flipscale == 1) {
        self.cameraimageview.image= flipCameraImage;
    }
    else{
        self.cameraimageview.image= CameraImage;
    }
//    self.cameraimageview.transform = CGAffineTransformMakeScale((-1)*flipscale, 1);
    flipscale=(-1)*flipscale;
    [self resetColor];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.1f];
    
}

- (IBAction)previewbutton:(id)sender {
    self.navigationItem.title=@"Preview";

    [progress show:YES];
    [self.bottombar2 setHidden:NO];
    if (bPreview) {
        UIGraphicsBeginImageContext(frameview.bounds.size);
        [frameview.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [TotalImageView setBackgroundColor:[UIColor whiteColor]];
        frameview.frame=TotalImageView.frame;
        frameimageview.image=image;
        frameimageview.frame=frameview.frame;
        [cameraimageview setHidden:YES];
        bPreview=NO;
        NSLog(@"iw=%f,  ih=%f",image.size.width,image.size.height);

        AppDelegate *app =[UIApplication sharedApplication].delegate;
        app.saveImage=image;
    }
    else{
        [frameimageview setImage:frameimage];
        CGFloat iw=frameimage.size.width;
        CGFloat ih=frameimage.size.height;
        //    [frameview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih, (h-navheight-50))];
        [frameimageview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih*ss, (h-navheight-50)*ss)];
        [frameview setFrame:frameimageview.frame];
        //    frameimageview.center=CGPointMake(frameview.frame.size.width/2, frameview.frame.size.height/2) ;
        frameview.center=CGPointMake(w/2+cx*w, (h-navheight-50)/2+navheight+cy*h) ;
        [cameraimageview setHidden:NO];
        bPreview=YES;
        [TotalImageView setBackgroundColor:[UIColor clearColor]];
//        cameraimageview.center=CGPointMake(frameview.frame.size.width/2, frameview.frame.size.height/2) ;
//        [self resetcameraView];
    }
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.2f];

}

- (IBAction)resetbutton:(id)sender {
    [progress show:YES];
    [self resetcameraView];
    [self resetColor];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.2f];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)undoitem{
    if (!bPreview) {
        [self bottombackbutton:self.bottombar2];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)cameraitem {
    [self secondview];
}
- (void)libraryitem {
    [progress show:YES];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.5f];
}
- (void)actionitem {
//    UIView *view1 = TotalImageView;// your view
    [progress show:YES];
    if (bPreview) {
        UIGraphicsBeginImageContext(frameview.bounds.size);
        [frameview.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        AppDelegate *app =[UIApplication sharedApplication].delegate;
        app.saveImage=image;
        
    }
//        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//        [imageData writeToFile:path atomically:YES];
    
        ShareViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"shareview"];
        [self.navigationController pushViewController:newView animated:YES];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.2f];
}
-(void)closeitem{
    
    if (bfirsttakeCamera) {
        [self firstview];
    }
    else{
        [self thirdview];
    }
    
}
-(void)firstview{
    self.navigationItem.title=@"Take Your Photo";
    [self.bottombar setHidden:YES];
    [self.bottombar1 setHidden:NO];
    [self.bottomtoolbar setHidden:YES];
    [self.cameraimageview setHidden:YES];
    self.navigationItem.rightBarButtonItems=nil;
    [mb setHidden:NO];
    [cb setHidden:YES];
    bfirsttakeCamera=YES;
    [previewLayer setHidden:YES];
    [edittoolview setHidden:YES];
    [resizetoolview setHidden:YES];
    frameview.frame=TotalImageView.frame;
    [frameimageview setImage:frameimage];
    frameimageview.frame=frameview.frame;
    cameraimageview.frame=cameraview.frame;
}
-(void)secondview{
    self.navigationItem.title=@"Take Your Photo";
    
    CGFloat iw=frameimage.size.width;
    CGFloat ih=frameimage.size.height;
    [frameimageview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih*ss, (h-navheight-50)*ss)];
    [frameview setFrame:frameimageview.frame];
    frameview.center=CGPointMake(w/2+cx*w, (h-navheight-50)/2+navheight+cy*h) ;

//    [UIView transitionWithView:self.bottombar
//                      duration:0.4
//                       options:UIViewAnimationOptionLayoutSubviews
//                    animations:^{
//                        self.bottombar.hidden = NO;
//                    }
//                    completion:NULL];
//    [UIView transitionWithView:self.bottombar1
//                      duration:0.4
//                       options:UIViewAnimationOptionLayoutSubviews
//                    animations:^{
//                        self.bottombar1.hidden = YES;
//                    }
//                    completion:NULL];
//    [UIView transitionWithView:self.bottomtoolbar
//                      duration:0.4
//                       options:UIViewAnimationOptionLayoutSubviews
//                    animations:^{
//                        self.bottomtoolbar.hidden = YES;
//                    }
//                    completion:NULL];
    [self.bottombar setHidden:NO];
    [self.bottombar1 setHidden:YES];
    [self.bottomtoolbar setHidden:YES];
    [self.cameraimageview setHidden:YES];
    [mb setHidden:YES];
    [cb setHidden:NO];
    self.navigationItem.rightBarButtonItems=nil;
    self.navigationItem.rightBarButtonItem=closeButton;
    [previewLayer setHidden:NO];
    [pagingView setHidden:YES];
    [frameview setHidden:NO];
    [self resetcameraView];
    [session startRunning];
}
-(void)thirdview{
    self.navigationItem.title=@"Edit";
    CGFloat iw=frameimage.size.width;
    CGFloat ih=frameimage.size.height;
    [frameimageview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih*ss, (h-navheight-50)*ss)];
    [frameview setFrame:frameimageview.frame];
    frameview.center=CGPointMake(w/2+cx*w, (h-navheight-50)/2+navheight+cy*h) ;
    [cameraimageview setHidden:NO];
    [previewLayer setHidden:YES];
    [self.bottombar1 setHidden:YES];
    [self.bottombar setHidden:YES];
    [self.bottomtoolbar setHidden:NO];
    [frameview setHidden:NO];
    self.navigationItem.rightBarButtonItems=rightbuttons;
    [mb setHidden:NO];
    bfirsttakeCamera=NO;
    [pagingView setHidden:YES];
    [self resetcameraView];
    
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position)
            return device;
    }
    return nil;
}
- (IBAction)camerabutton:(id)sender {
    [progress show:YES];
    [self initpoint];
   [self secondview];
    [session startRunning];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.3f];
}

- (IBAction)librarybutton:(id)sender {
    [self libraryitem];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    CameraImage= [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
//    self.cameraimageview.image = CameraImage;
    cameraimageview.image = CameraImage;
    cameraimageview.center=CGPointMake(frameview.frame.size.width/2-cx*w, frameview.frame.size.height/2-cy*h) ;
    bcameraimage=NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(!bPreview)
    {
        [frameimageview setImage:frameimage];
        CGFloat iw=frameimage.size.width;
        CGFloat ih=frameimage.size.height;
        [frameimageview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih, (h-navheight-50))];
        frameview.frame=frameimageview.frame;
        frameview.center=CGPointMake(w/2, (h-navheight-50)/2+navheight) ;
        [cameraimageview setHidden:NO];
        bPreview=YES;
        [TotalImageView setBackgroundColor:[UIColor clearColor]];
    }
    frameimage=[items objectAtIndex:selnumber];
    [self initpoint];
    [self thirdview];
}
-(void)resetColor{
    UIImage *currentImage;
    if (flipscale==1) {
        currentImage=CameraImage;
    }
    else{
        currentImage=flipCameraImage;
    }
    GPUImageBrightnessFilter *stillImageFilter1 = [[GPUImageBrightnessFilter alloc] init];
    [stillImageFilter1 setBrightness:(CGFloat) ((bv-50.0f)/50.0f)];
    UIImage *quickFilteredImage = [stillImageFilter1 imageByFilteringImage:currentImage];
    
    GPUImageContrastFilter *stillImageFilter2 = [[GPUImageContrastFilter alloc] init];
    [stillImageFilter2 setContrast:(CGFloat) ((cv*2.0f)/100.0f)];
    quickFilteredImage = [stillImageFilter2 imageByFilteringImage:quickFilteredImage];
    
    GPUImageHueFilter *stillImageFilter3 = [[GPUImageHueFilter alloc] init];
    [stillImageFilter3 setHue:(CGFloat) (360.0f*(hv/50.0f-50))];
    quickFilteredImage = [stillImageFilter3 imageByFilteringImage:quickFilteredImage];
    
    GPUImageSaturationFilter *stillImageFilter4 = [[GPUImageSaturationFilter alloc] init];
    [stillImageFilter4 setSaturation:(CGFloat) ((sv*2.0f)/100.0f)];
    quickFilteredImage = [stillImageFilter4 imageByFilteringImage:quickFilteredImage];
    self.cameraimageview.image=quickFilteredImage;
    
}

- (void)doneButtonAction:(EditToolView *)sender{
    [edittoolview setHidden:YES];
}
- (void)resetButtonAction:(EditToolView *)sender{
//    [edittoolview setHidden:YES];
}
- (void)resizedoneButtonAction:(ResizeToolView *)sender{
    [resizetoolview setHidden:YES];
}
-(void)resizeresetButtonAction:(ResizeToolView *)sender{
}
-(void)editColor:(EditToolView *)sender Brightness:(float)value1 Contrast:(float)value2 Hue:(float)value3 Saturation:(float)value4{
    bv=value1;
    cv=value2;
    hv=value3;
    sv=value4;
    [self resetColor];
}
-(void)resizeview:(ResizeToolView *)sender widthDidChange:(float)value{
    CGFloat scalex=(value<50) ? 0.5f+(CGFloat)(value)/100.0f : (CGFloat)value/50.0f;
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, scalex/lastScalex, 1);
    lastScalex= scalex;
}
-(void)resizeview:(ResizeToolView *)sender heightDidChange:(float)value{
    CGFloat scaley=(value<50) ? 0.5f+(CGFloat)(value)/100.0f : (CGFloat)value/50.0f;
    cameraimageview.transform = CGAffineTransformScale(cameraimageview.transform, 1, scaley/lastScaley);
    lastScaley= scaley;
}

- (IBAction)bottombackbutton:(id)sender {
    self.navigationItem.title=@"Edit";

    [progress show:YES];

    [self.bottombar2 setHidden:YES];
    [frameimageview setImage:frameimage];
    CGFloat iw=frameimage.size.width;
    CGFloat ih=frameimage.size.height;
    //    [frameview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih, (h-navheight-50))];
    [frameimageview setFrame:CGRectMake(0,0, iw*(h-navheight-50)/ih*ss, (h-navheight-50)*ss)];
    [frameview setFrame:frameimageview.frame];
    //    frameimageview.center=CGPointMake(frameview.frame.size.width/2, frameview.frame.size.height/2) ;
    frameview.center=CGPointMake(w/2+cx*w, (h-navheight-50)/2+navheight+cy*h) ;
    [cameraimageview setHidden:NO];
    bPreview=YES;
    [TotalImageView setBackgroundColor:[UIColor clearColor]];
    //        cameraimageview.center=CGPointMake(frameview.frame.size.width/2, frameview.frame.size.height/2) ;
    //        [self resetcameraView];
    [self performSelector:@selector(endFill) withObject:nil afterDelay:0.1f];

}
@end
