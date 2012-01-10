//
//  LCViewController.h
//  GradientButton
//
//  Created by Jonathan Lundell on 1/10/12.
//  Copyright (c) 2012 LobitosCreek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCGradientButton;

@interface LCViewController : UIViewController

@property (nonatomic, retain) IBOutlet LCGradientButton *blueButton;
@property (nonatomic, retain) IBOutlet LCGradientButton *solidButton;

@end
