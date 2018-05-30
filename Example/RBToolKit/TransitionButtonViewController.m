//
//  TransitionButtonViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/25.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "TransitionButtonViewController.h"

#import <RBToolKit/UIButton+TransitionButton.h>

@interface TransitionButtonViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tButtons;

@end

@implementation TransitionButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)transition_0:(UIButton *)sender {
    
    [sender start:^(TransitionConfig *config) {
        config.style.position = eIndicatorPositionLeading;
    }];
    
}

- (IBAction)transition:(UIButton *)sender {
    
    [sender start:nil];
    
}

- (IBAction)transition_1:(UIButton *)sender {
    
    [sender start:^(TransitionConfig *config) {
        config.style.style = eTransitionTypeShrik;
    }];
    
}

- (IBAction)transition_2:(UIButton *)sender {
    
    [sender start:^(TransitionConfig *config) {
        config.style.position = eIndicatorPositionTrailing;
    }];
    
}

- (IBAction)transition_3:(UIButton *)sender {
    
    [sender start:^(TransitionConfig *config) {
        config.afterDone = eTransitionDoneExpand;
    }];
    
}

- (IBAction)stop:(UIButton *)sender {
    
    for (UIButton *b in _tButtons) {
        [b stop];
    }
    
}

@end
