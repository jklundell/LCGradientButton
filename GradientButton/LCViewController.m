//
//  LCViewController.m
//  GradientButton
//
//  Created by Jonathan Lundell on 1/10/12.
//  Copyright (c) 2012 LobitosCreek. All rights reserved.
//

#import "LCViewController.h"
#import "LCGradientButton.h"

@implementation LCViewController

@synthesize blueButton, solidButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.blueButton setLowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0]];  // automatic gradient
    [self.solidButton setColor:[UIColor blueColor]];    // no gradient
    //
    //  create a button with a tighter corner radius
    //
    LCGradientButton *button = [LCGradientButton gradientButtonWithFrame:CGRectMake(100.0, 200.0, 120.0, 37.0) 
                                                                   title:@"Programmatic"];
    [button setLowColor:[UIColor redColor] highColor:[UIColor whiteColor]];
    button.cornerRadius = 37.0/3;   // 1/3 of button height
    [self.view addSubview:button];
    //
    //  create a button with no shadow
    //
    button = [LCGradientButton gradientButtonWithFrame:CGRectMake(100.0, 250.0, 120.0, 37.0) 
                                                                   title:@"Shadowless"];
    [button setLowColor:[UIColor redColor]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setShadowOpacity:0.0 offset:CGSizeZero color:nil radius:0.0];
    [self.view addSubview:button];
    //
    //  create a button with a dark gray border
    //
    button = [LCGradientButton gradientButtonWithFrame:CGRectMake(100.0, 300.0, 120.0, 37.0) 
                                                 title:@"Bordered"];
    [button setLowColor:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0]];
    button.cornerRadius = 37.0/4;   // 1/4 of button height
    button.borderColor = [UIColor darkGrayColor];
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
