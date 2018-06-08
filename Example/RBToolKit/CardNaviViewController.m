//
//  CardNaviViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/6.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "CardNaviViewController.h"

@interface CardNaviViewController ()

@end

@implementation CardNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)prefersStatusBarHidden {
    
    UIViewController *c = self.viewControllers.lastObject;
    
    BOOL f = [c prefersStatusBarHidden];
    
    return f;
    
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return [self.viewControllers.lastObject preferredStatusBarUpdateAnimation];
    
}

@end
