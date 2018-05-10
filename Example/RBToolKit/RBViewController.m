
//  RBViewController.m
//  RBToolKit
//
//  Created by wzc5670594 on 12/13/2017.
//  Copyright (c) 2017 wzc5670594. All rights reserved.
//

#import "RBViewController.h"
#import "AViewController.h"

#import <RBToolKit/RBToolKit.h>

#import <RBToolKit/RBLocalize.h>

#import <ReactiveObjC/ReactiveObjC.h>

#import <RBToolKit/RBFileManager.h>

@interface RBViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *imageView;
/**  */
@property (nonatomic, weak)RBFileManager *f;
@end

@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSNumber *k = nil;
    
    if (k == NULL) {
        NSLog(@"1f3");
    }
    
  
    
    [self checkFilePath];
    
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

//测试组件。filemanager
- (void)checkFilePath {
    
    NSLog(@"%@", self.f);
    
    NSData *d = [@"13213" dataUsingEncoding:NSUTF8StringEncoding];
    
    RBFileManager *f = [RBFileManager new];
    NSLog(@"%d", f.documents.user.write(d));
    NSLog(@"%@", f.tmp.path);
    self.f = f;
    
}

- (IBAction)toAVc:(id)sender {

    AViewController *a = [AViewController new];
    
    @weakify(self)
    a.callBack = ^{
        @strongify(self)
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:a animated:YES completion:^{
        NSLog(@"%@", self);
    }];
    NSLog(@"presentedViewController %@", self.presentedViewController);
    NSLog(@"presentingViewController %@", self.presentingViewController);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
