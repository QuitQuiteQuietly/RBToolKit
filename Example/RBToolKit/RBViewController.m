//
//  RBViewController.m
//  RBToolKit
//
//  Created by wzc5670594 on 12/13/2017.
//  Copyright (c) 2017 wzc5670594. All rights reserved.
//

#import "RBViewController.h"


#import <RBToolKit/RBToolKit.h>

#import <RBToolKit/RBLocalize.h>
@interface RBViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *imageView;

@end

@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *k = nil;
    
    if (k == NULL) {
        NSLog(@"1f3");
    }
    
    
    
   UIImage *i = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] duration:2];
    
    self.imageView.image = i;
    
    NSLog(@"当前语言 %lu", (unsigned long)[RBLocalize checkLocalizeStatus]);
    
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
