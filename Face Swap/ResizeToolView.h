//
//  UIView+EditToolView.h
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResizeToolView;

@protocol ResizeToolViewDelegate
- (void)resizeview:(ResizeToolView *)sender widthDidChange:(float)value;
- (void)resizeview:(ResizeToolView *)sender heightDidChange:(float)value;
- (void)resizedoneButtonAction: (ResizeToolView *) sender;  //define delegate method to be implemented within another class
- (void)resizeresetButtonAction: (ResizeToolView *) sender;  //define delegate method to be implemented within another class
@end

@interface ResizeToolView:UIView
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIButton *resetButton;
@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UISlider *heightSlider;
@property (assign, nonatomic) float widthscale, heightscale;
@property (assign) BOOL blReset;
@property (assign, nonatomic) float maxSlider;
@property (assign) int midMargin;
@property (assign) int leftMargin;
@property (assign) CGSize minViewSize;
@property (assign) CGRect screensize;
@property (assign) id <ResizeToolViewDelegate> delegate;
@end
