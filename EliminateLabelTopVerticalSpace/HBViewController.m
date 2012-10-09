//
//  HBViewController.m
//  EliminateLabelTopVerticalSpace
//
//  Created by Heath Borders on 10/7/12.
//  Copyright (c) 2012 Heath Borders. All rights reserved.
//

#import "HBViewController.h"
#import <CoreText/CoreText.h>

@interface HBViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *fontNames;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UILabel *labelHeightLabel;
@property (nonatomic, strong) UILabel *fontSizeLabel;
@property (nonatomic, strong) UILabel *fontLineHeightLabel;
@property (nonatomic, strong) UILabel *fontLeadingLabel;
@property (nonatomic, strong) UILabel *fontAscentLabel;
@property (nonatomic, strong) UILabel *fontDescentLabel;
@property (nonatomic, strong) UILabel *fontBaselineAdjustLabel;

@end

@implementation HBViewController

- (void) loadView {
    [super loadView];
    
    NSMutableArray *fontNames = [NSMutableArray array];
    for (NSString *familyName in [UIFont familyNames]) {
        [fontNames addObjectsFromArray:[UIFont fontNamesForFamilyName:familyName]];
    }
    [fontNames sortUsingSelector:@selector(caseInsensitiveCompare:)];
    self.fontNames = fontNames;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self.label.autoresizingMask =
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth;
    self.label.backgroundColor = [UIColor orangeColor];
    self.label.text = @"(\"'Text";
    [self.view addSubview:self.label];
    
    CGFloat debugWidth = 200;
    CGFloat debugHeight = 20;
    CGFloat debugAlpha = .5;
    self.labelHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                      CGRectGetMinY(self.view.bounds),
                                                                      debugWidth,
                                                                      debugHeight)];
    self.labelHeightLabel.alpha = debugAlpha;
    self.labelHeightLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.labelHeightLabel];
    
    self.fontSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                   CGRectGetMaxY(self.labelHeightLabel.frame),
                                                                   debugWidth,
                                                                   debugHeight)];
    self.fontSizeLabel.alpha = debugAlpha;
    self.fontSizeLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontSizeLabel];
    
    self.fontLineHeightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                         CGRectGetMaxY(self.fontSizeLabel.frame),
                                                                         debugWidth,
                                                                         debugHeight)];
    self.fontLineHeightLabel.alpha = debugAlpha;
    self.fontLineHeightLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontLineHeightLabel];
    
    self.fontLeadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                      CGRectGetMaxY(self.fontLineHeightLabel.frame),
                                                                      debugWidth,
                                                                      debugHeight)];
    self.fontLeadingLabel.alpha = debugAlpha;
    self.fontLeadingLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontLeadingLabel];
    
    self.fontAscentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                     CGRectGetMaxY(self.fontLeadingLabel.frame),
                                                                     debugWidth,
                                                                     debugHeight)];
    self.fontAscentLabel.alpha = debugAlpha;
    self.fontAscentLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontAscentLabel];
    
    self.fontDescentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                      CGRectGetMaxY(self.fontAscentLabel.frame),
                                                                      debugWidth,
                                                                      debugHeight)];
    self.fontDescentLabel.alpha = debugAlpha;
    self.fontDescentLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontDescentLabel];
    
    self.fontBaselineAdjustLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) - debugWidth,
                                                                                 CGRectGetMaxY(self.fontDescentLabel.frame),
                                                                                 debugWidth,
                                                                             debugHeight)];
    self.fontBaselineAdjustLabel.alpha = debugAlpha;
    self.fontBaselineAdjustLabel.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.fontBaselineAdjustLabel];
    
    UIPickerView *fontPickerView = [[UIPickerView alloc] initWithFrame:self.view.bounds];
    [fontPickerView sizeToFit];
    fontPickerView.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleWidth;
    fontPickerView.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                                      CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(fontPickerView.frame),
                                      CGRectGetWidth(self.view.bounds),
                                      CGRectGetHeight(fontPickerView.frame));
    fontPickerView.dataSource = self;
    fontPickerView.delegate = self;
    fontPickerView.showsSelectionIndicator = YES;
    
    UISlider *sizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.bounds),
                                                                      CGRectGetMinY(fontPickerView.frame) - 25,
                                                                      CGRectGetWidth(self.view.bounds),
                                                                      25)];
    [sizeSlider addTarget:self
                   action:@selector(sizeSliderValueChanged:)
         forControlEvents:UIControlEventValueChanged];
    sizeSlider.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleWidth;
    sizeSlider.minimumValue = 0;
    sizeSlider.maximumValue = 50;
    
    UIFont *system17Font = [UIFont systemFontOfSize:17];
    sizeSlider.value = 17;
    NSUInteger system17FontIndex = [self.fontNames indexOfObject:system17Font.fontName];
    [fontPickerView selectRow:system17FontIndex
                  inComponent:0
                     animated:NO];
    [self layoutLabelWithFont:system17Font];
    
    [self.view addSubview:sizeSlider];
    [self.view addSubview:fontPickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.fontNames count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *fontName = [self.fontNames objectAtIndex:row];
    return fontName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *fontName = [self.fontNames objectAtIndex:row];
    UIFont *font = [UIFont fontWithName:fontName
                                   size:self.label.font.pointSize];
    [self layoutLabelWithFont:font];
}

#pragma mark - actions

- (void) sizeSliderValueChanged:(UISlider *)sizeSlider {
    [self layoutLabelWithFont:[UIFont fontWithName:self.label.font.fontName
                                              size:sizeSlider.value]];
}

#pragma mark - private API

- (void) layoutLabelWithFont:(UIFont *)font {
    self.label.font = font;
    self.label.frame = self.view.bounds;
    [self.label sizeToFit];
    
    self.labelHeightLabel.text = [NSString stringWithFormat:@"Label Height: %.1f",
                                  CGRectGetHeight(self.label.frame)];
    self.fontSizeLabel.text = [NSString stringWithFormat:@"Font Size: %.1f",
                               font.pointSize];
    self.fontLineHeightLabel.text = [NSString stringWithFormat:@"Line Height: %.1f",
                                     font.lineHeight];
    
    CTFontRef coreTextFont = CTFontCreateWithName((__bridge CFStringRef) font.fontName,
                                                  font.pointSize,
                                                  NULL);
    if (coreTextFont) {
        self.fontLeadingLabel.text = [NSString stringWithFormat:@"Font Leading: %.1f",
                                      CTFontGetLeading(coreTextFont)];
        self.fontAscentLabel.text = [NSString stringWithFormat:@"Font Ascent: %.1f",
                                     CTFontGetAscent(coreTextFont)];
        self.fontDescentLabel.text = [NSString stringWithFormat:@"Font Descent: %.1f",
                                      CTFontGetDescent(coreTextFont)];
        
        CTFontDescriptorRef fontDescriptor = CTFontCopyFontDescriptor(coreTextFont);
        if (fontDescriptor) {
            CFNumberRef baselineAdjustNumber = CTFontDescriptorCopyAttribute(fontDescriptor,
                                                                             kCTFontBaselineAdjustAttribute);
            if (baselineAdjustNumber) {
                self.fontBaselineAdjustLabel.text = [NSString stringWithFormat:@"Font base adjust: %.1f",
                                                     [(__bridge NSNumber *) baselineAdjustNumber floatValue]];
                
                CFRelease(baselineAdjustNumber);
            } else {
                self.fontBaselineAdjustLabel.text = @"Font base adjust: NULL";
            }
            
            CFRelease(fontDescriptor);
        } else {
            self.fontBaselineAdjustLabel.text = @"Font base adjust: NULL";
        }
        
        CFRelease(coreTextFont);
    } else {
        self.fontLeadingLabel.text = @"Font Leading: NULL";
        self.fontAscentLabel.text = @"Font Ascent: NULL";
        self.fontDescentLabel.text = @"Font Descent: NULL";
        self.fontBaselineAdjustLabel.text = @"Font base adjust: NULL";
    }
}

@end
