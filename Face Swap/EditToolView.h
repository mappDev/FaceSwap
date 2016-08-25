//
//  UIView+EditToolView.h
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditToolView;

@protocol EditToolViewDelegate
- (void)editbrightness:(EditToolView *)sender brightnessDidChange:(float)value;
- (void)editcontrast:(EditToolView *)sender contrastDidChange:(float)value;
- (void)edithue:(EditToolView *)sender hueDidChange:(float)value;
- (void)editsaturation:(EditToolView *)sender saturationDidChange:(float)value;
- (void)editColor:(EditToolView *)sender Brightness:(float)value1 Contrast:(float)value2 Hue:(float)value3 Saturation:(float)value4;
- (void)doneButtonAction: (EditToolView *) sender;  //define delegate method to be implemented within another class
- (void)resetButtonAction: (EditToolView *) sender;  //define delegate method to be implemented within another class
@end

@interface EditToolView:UIView
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIButton *resetButton;
@property (strong, nonatomic) UISlider *brightnessSlider;
@property (strong, nonatomic) UISlider *contrastSlider;
@property (strong, nonatomic) UISlider *hueSlider;
@property (strong, nonatomic) UISlider *saturationSlider;
@property (assign, nonatomic) float brightness, contrast, hue, saturation;
@property (assign) BOOL blReset;
@property (assign, nonatomic) float maxSlider;
@property (assign) int midMargin;
@property (assign) int leftMargin;
@property (assign) CGSize minViewSize;
@property (assign) CGRect screensize;
@property (assign) id <EditToolViewDelegate> delegate;
@end
