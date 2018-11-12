//
//  noViewController.m
//  DynamicAndStaticLib
//
//  Created by JJCSoftDeveloper on 11/12/2018.
//  Copyright (c) 2018 JJCSoftDeveloper. All rights reserved.
//

#import "noViewController.h"
#import <AMapFoundationKit/AMapServices.h>
@interface noViewController ()

@end

@implementation noViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AMapServices sharedServices].apiKey = @"xxxx";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
