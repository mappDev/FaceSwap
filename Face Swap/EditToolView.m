//
//  UIView+EditToolView.m
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import "EditToolView.h"

@implementation EditToolView
@synthesize doneButton;
@synthesize resetButton;
@synthesize brightnessSlider;
@synthesize contrastSlider;
@synthesize hueSlider;
@synthesize saturationSlider;
@synthesize brightness, contrast, hue, saturation;
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
        [self setFrame:CGRectMake(0, screensize.size.height-150, screensize.size.width, 150)];
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
    
    UIImageView *lblbrightness = [[UIImageView alloc] initWithFrame:CGRectMake(3, 30, sliderheight, sliderheight)];
    [lblbrightness setImage:[UIImage imageNamed:@"btbrightness"]];
    [self addSubview:lblbrightness];
    UIImageView *lblcontrast = [[UIImageView alloc] initWithFrame:CGRectMake(3, 60, sliderheight, sliderheight)];
    [lblcontrast setImage:[UIImage imageNamed:@"btcontrast"]];
    [self addSubview:lblcontrast];
    UIImageView *lblhue = [[UIImageView alloc] initWithFrame:CGRectMake(3, 90, sliderheight, sliderheight)];
    [lblhue setImage:[UIImage imageNamed:@"bthue"]];
    [self addSubview:lblhue];
    UIImageView *lblsaturation = [[UIImageView alloc] initWithFrame:CGRectMake(3, 120, sliderheight, sliderheight)];
    [lblsaturation setImage:[UIImage imageNamed:@"btsaturation"]];
    [self addSubview:lblsaturation];
    
    
    brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 30, sliderlength, sliderheight)];
    [brightnessSlider addTarget:self action:@selector(brightnessSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [brightnessSlider setBackgroundColor:[UIColor clearColor]];
    brightnessSlider.minimumValue = 0.0;
    brightnessSlider.maximumValue = 100.0;
    brightnessSlider.continuous = YES;
    brightnessSlider.value = 50.0;
    [self addSubview:brightnessSlider];
    contrastSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 60, sliderlength, sliderheight)];
    [contrastSlider addTarget:self action:@selector(contrastSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [contrastSlider setBackgroundColor:[UIColor clearColor]];
    contrastSlider.minimumValue = 0.0;
    contrastSlider.maximumValue = 100.0;
    contrastSlider.continuous = YES;
    contrastSlider.value = 50.0;
    [self addSubview:contrastSlider];
    hueSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 90, sliderlength, sliderheight)];
    [hueSlider addTarget:self action:@selector(hueSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [hueSlider setBackgroundColor:[UIColor clearColor]];
    hueSlider.minimumValue = 0.0;
    hueSlider.maximumValue = 100.0;
    hueSlider.continuous = YES;
    hueSlider.value = 50.0;
    [self addSubview:hueSlider];
    saturationSlider = [[UISlider alloc] initWithFrame:CGRectMake(sliderheight+5, 120, sliderlength, sliderheight)];
    [saturationSlider addTarget:self action:@selector(saturationSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [saturationSlider setBackgroundColor:[UIColor clearColor]];
    saturationSlider.minimumValue = 0.0;
    saturationSlider.maximumValue = 100.0;
    saturationSlider.continuous = YES;
    saturationSlider.value = 50.0;
    [self addSubview:saturationSlider];
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
-(void)brightnessSliderAction:(id)sender{
    [self.delegate editColor:self Brightness:brightnessSlider.value Contrast:contrastSlider.value Hue:hueSlider.value Saturation:saturationSlider.value];
//    [self.delegate editbrightness:sender brightnessDidChange:brightnessSlider.value];
}
-(void)contrastSliderAction:(id)sender{
//    [self.delegate editcontrast:sender contrastDidChange:contrastSlider.value];
    [self.delegate editColor:self Brightness:brightnessSlider.value Contrast:contrastSlider.value Hue:hueSlider.value Saturation:saturationSlider.value];
   
}
-(void)hueSliderAction:(id)sender{
//    [self.delegate edithue:sender hueDidChange:hueSlider.value];
    [self.delegate editColor:self Brightness:brightnessSlider.value Contrast:contrastSlider.value Hue:hueSlider.value Saturation:saturationSlider.value];
    
}
-(void)saturationSliderAction:(id)sender{
//    [self.delegate editsaturation:sender saturationDidChange:saturationSlider.value];
    [self.delegate editColor:self Brightness:brightnessSlider.value Contrast:contrastSlider.value Hue:hueSlider.value Saturation:saturationSlider.value];
    
}
-(void)resetButtonAction:(id)sender{
    brightnessSlider.value=50;
    contrastSlider.value=50;
    hueSlider.value=50;
    saturationSlider.value=50;
    [self.delegate editColor:self Brightness:brightnessSlider.value Contrast:contrastSlider.value Hue:hueSlider.value Saturation:saturationSlider.value];
    
//    [self.delegate resetButtonAction:self];
}
-(void)doneButtonAction:(id)sender{
    [self.delegate doneButtonAction:self];
}
@end
