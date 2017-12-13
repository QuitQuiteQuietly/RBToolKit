//
//  RBViewController.m
//  RBToolKit
//
//  Created by wzc5670594 on 12/13/2017.
//  Copyright (c) 2017 wzc5670594. All rights reserved.
//

#import "RBViewController.h"


#import <RBToolKit/RBToolKit.h>


@interface RBViewController ()

@end

@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *k = nil;
    
    if (k == NULL) {
        NSLog(@"13");
    }
    
    NSString *x = @"<null>";

    if (x == NULL) {
        NSLog(@"13");
    }
    
    NSLog(@"33%@----%@", NSString.safe(k), NSString.safe(x));
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
