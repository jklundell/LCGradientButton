//
//  LCGradientButton.m
//  Rounded-rect UIButton with color gradient, shadow, and optional image
//
//  Created by Jonathan Lundell on 1/8/12.
//
#import "LCGradientButton.h"

#define ZPOSITION_GRADIENT  -1.0
#define ZPOSITION_IMAGE 1.0

@interface LCGradientButton ()

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;
@property (nonatomic, readonly) CALayer *imageLayer;

@end

@implementation LCGradientButton

static UIColor *defaultLowColor;
static UIColor *defaultHighColor;
static UIColor *defaultTextColor;

- (void)awakeFromNib {
    CGFloat radius = self.bounds.size.height / 2.0;
    
    // Initialize the gradient layer
    CAGradientLayer *gradient_layer = [[CAGradientLayer alloc] init];
    gradient_layer.frame = self.bounds;
    
    gradient_layer.zPosition = ZPOSITION_GRADIENT;
    [self.layer addSublayer:gradient_layer];
    
    // Set the layers' corner radius
    self.layer.cornerRadius = radius;
    gradient_layer.cornerRadius = radius;
    gradient_layer.masksToBounds = YES;
    
    self.layer.borderWidth = 1.0f;  // default border
    
    // Cast a shadow to the lower right
    [self setShadowOpacity:0.3 offset:CGSizeMake(3.0, 3.0) color:nil radius:2.0];
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] CGPath];
    
    if (!defaultLowColor) {
        defaultLowColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        defaultHighColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        defaultTextColor = [UIColor whiteColor];
    }
    [self setLowColor:defaultLowColor highColor:defaultHighColor];
}

+ (LCGradientButton *)gradientButtonWithFrame:(CGRect)frame title:(NSString *)title {
    
    LCGradientButton *button = [super buttonWithType:UIButtonTypeRoundedRect];
    if (button) {
        button->isa = [LCGradientButton class];
        button.frame = frame;
        [button setTitle:title forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted = YES;
        [button awakeFromNib];
        [button setTitleColor:defaultTextColor forState:UIControlStateNormal];
        button.titleLabel.textAlignment = UITextAlignmentCenter;
    }
    return button;
}

- (CAGradientLayer *)gradientLayer {
    for (CALayer *layer in self.layer.sublayers) {
        if (layer.zPosition == ZPOSITION_GRADIENT)
            return (CAGradientLayer *)layer;
    }
    return nil;
}

- (CALayer *)imageLayer {
    for (CALayer *layer in self.layer.sublayers) {
        if (layer.zPosition == ZPOSITION_IMAGE)
            return layer;
    }
    return nil;
}

//  Set gradient colors from an array of UIColor *
//  Set border color to first color in array (typically lowColor)
//
- (void)setColors:(NSArray *)colors {
    NSMutableArray *cgcolors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgcolors addObject:(id)color.CGColor];
    }
    self.gradientLayer.colors = cgcolors;
    self.layer.borderColor = (__bridge CGColorRef)[cgcolors lastObject];
    [self.layer setNeedsDisplay];
}

- (void)setLowColor:(UIColor *)lowColor highColor:(UIColor *)highColor {
    [self setColors:[NSArray arrayWithObjects:highColor, lowColor, nil]];
}

//  Given a low color, create a high color halfway to white
//
- (void)setLowColor:(UIColor *)lowColor {
    CGFloat r, g, b, a, w;
    if ([lowColor getRed:&r green:&g blue:&b alpha:&a]) {
        UIColor *highColor = [UIColor colorWithRed:0.5+r/2 green:0.5+g/2 blue:0.5+b/2 alpha:a];
        [self setColors:[NSArray arrayWithObjects:highColor, lowColor, nil]];
    } else if ([lowColor getWhite:&w alpha:&a]) {
        UIColor *highColor = [UIColor colorWithWhite:0.5+w/2 alpha:a];
        [self setColors:[NSArray arrayWithObjects:highColor, lowColor, nil]];
    }
}

//  Set a button with a solid color (no gradient)
//
- (void)setColor:(UIColor *)color {
    [self setColors:[NSArray arrayWithObjects:color, color, nil]];
}

//  Set the default gradient colors for future instances
//
+ (void)setDefaultLowColor:(UIColor *)lowColor highColor:(UIColor *)highColor textColor:(UIColor *)textColor {
    defaultLowColor = lowColor;
    defaultHighColor = highColor;
    defaultTextColor = textColor;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.gradientLayer.cornerRadius = radius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] CGPath];
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

//  Set border color, but if color == nil, omit the border
//
- (void)setBorderColor:(UIColor *)color {
    if (!color)
        self.layer.borderWidth = 0.0;
    self.layer.borderColor = color.CGColor;
    [self.layer setNeedsDisplay];
}

- (UIImage *)image {
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.layer.contents];
}

- (void)setImage:(UIImage *)image {
    if (!self.imageLayer) {
        CALayer *image_layer = [CALayer layer];
        CGFloat inset = 6.0;    // inset resized image from edges of button
        image_layer.frame = CGRectMake(inset, inset, self.bounds.size.width-inset*2, self.bounds.size.height-inset*2);
        [self.layer addSublayer:image_layer];
        image_layer.zPosition = ZPOSITION_IMAGE;
        image_layer.contentsGravity = kCAGravityResizeAspect;
    }
    self.imageLayer.contents = (id)[image CGImage];
    [self.layer setNeedsDisplay];
}

//  Set button shadow
//    ignore offset if offset == CGSizeZero
//    ignore color if color == nil
//    ignore radius if radius == 0.0
//
- (void)setShadowOpacity:(float)opacity offset:(CGSize)offset color:(UIColor *)color radius:(CGFloat)radius {
    self.layer.shadowOpacity = opacity;
    if (offset.width || offset.height)
        self.layer.shadowOffset = offset;
    if (color)
        self.layer.shadowColor = [color CGColor];
    if (radius)
        self.layer.shadowRadius = radius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius] CGPath];
}

@end
