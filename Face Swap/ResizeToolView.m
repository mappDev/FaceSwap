//
//  UIView+EditToolView.m
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import "ResizeToolView.h"

@implementation ResizeToolView
@synthesize doneButton;
@synthesize resetButton;
@synthesize widthSlider;
@synthesize heightSlider;
@synthesize widthscale, heightscale;
@synthesize blReset;
@synthesize maxSlider;
@synthesize midMargin;
@synthesize leftMargin;
@synthesize minViewSize;
@synthesize screensize;
@synthesize delegate;

- (void)baseInit {
    delegate = nil;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
        screensize=[UIScreen mainScreen].bounds;
        [self setFrame:CGRectMake(0, screensize.size.height-100, screensize.size.width, 100)];
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.7f];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}
- (void)refresh {
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    float labelwidth = 0.3f*screensize.size.width;
    float sliderheight = 28.0f;
    float sliderlength = screensize.size.width-2*sliderheight;
    
    UIImageView *lblwidth = [[UIImageView alloc] initWithFrame:CGRectMake(3, 30, sliderheight, sliderheight)];
    [lblwidth setImage:[UIImage imageNamed:@"szwidth"]];
    [self addSubview:lblwidth];
    UIImageView *lblheight = [[UIImageView alloc] initWithFrame:CGRectMake(3, 60, sliderheight, sliderheight)];
    [lblheight setImage:[UIImage imageNamed:@"szheight"]];
    [self addSubview:lblheight];
    
    widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 30, sliderlength, sliderheight)];
    [widthSlider addTarget:self action:@selector(widthSliderAction:) forControlEvents:UIControlEventValueChanged];
    [widthSlider setBackgroundColor:[UIColor clearColor]];
    widthSlider.minimumValue = 0.0;
    widthSlider.maximumValue = 100.0;
    widthSlider.continuous = YES;
    widthSlider.value = 50.0;
    [self addSubview:widthSlider];
    heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 60, sliderlength, sliderheight)];
    [heightSlider addTarget:self action:@selector(heightSliderAction:) forControlEvents:UIControlEventValueChanged];
    [heightSlider setBackgroundColor:[UIColor clearColor]];
    heightSlider.minimumValue = 0.0;
    heightSlider.maximumValue = 100.0;
    heightSlider.continuous = YES;
    heightSlider.value = 50.0;
    [self addSubview:heightSlider];
    resetButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 3, labelwidth, sliderheight)];
    [resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setBackgroundColor:[UIColor clearColor]];
    [resetButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [self addSubview:resetButton];
    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(screensize.size.width-labelwidth-3, 3, labelwidth, sliderheight)];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundColor:[UIColor clearColor]];
    [doneButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [self addSubview:doneButton];
    
}
-(void)widthSliderAction:(id)sender{
    [self.delegate resizeview:self widthDidChange:widthSlider.value];
}
-(void)heightSliderAction:(id)sender{
    [self.delegate resizeview:self heightDidChange:heightSlider.value];
}
-(void)resetButtonAction:(id)sender{
    widthSlider.value =50;
    heightSlider.value=50;
    [self.delegate resizeview:self heightDidChange:heightSlider.value];
    [self.delegate resizeview:self widthDidChange:widthSlider.value];
}
-(void)doneButtonAction:(id)sender{
    [self.delegate resizedoneButtonAction:self];
}
@end
