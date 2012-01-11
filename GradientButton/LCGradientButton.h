//
//  LCGradientButton.h
//  Rounded-rect UIButton with color gradient, shadow, and optional image
//
//  Created by Jonathan Lundell on 1/8/12.
//  Version 1.1  2012-01-10

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LCGradientButton : UIButton {}

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) UIColor *borderColor;
@property (nonatomic, assign) UIImage *image;

+ (LCGradientButton *)gradientButtonWithFrame:(CGRect)frame title:(NSString *)title;
+ (void)setDefaultLowColor:(UIColor *)lowColor highColor:(UIColor *)highColor textColor:(UIColor *)textColor;
- (void)setLowColor:(UIColor *)lowColor highColor:(UIColor *)highColor;
- (void)setColors:(NSArray *)colors;
- (void)setLowColor:(UIColor *)lowColor;
- (void)setColor:(UIColor *)color;
- (void)setShadowOpacity:(float)opacity offset:(CGSize)offset color:(UIColor *)color radius:(CGFloat)radius;

@end
