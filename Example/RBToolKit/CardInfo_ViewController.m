//
//  CardInfo_ViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/6.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "CardInfo_ViewController.h"

@interface CardInfo_ViewController ()<UIGestureRecognizerDelegate>

/**  */
@property (nonatomic, assign)BOOL statusHidden;

@property (nonatomic, strong) UIPanGestureRecognizer *gesturePan;

@end

@implementation CardInfo_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView animateWithDuration:1 animations:^{
        _statusHidden = NO;
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.navigationController.interactivePopGestureRecognizer removeTarget:nil action:nil];
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(actionInteractivePop:)];
    
    _gesturePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionInteractivePop:)];
    _gesturePan.delegate = self;
    [self.view addGestureRecognizer:_gesturePan];
}

- (BOOL)prefersStatusBarHidden {
    return _statusHidden;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)actionInteractivePop:(UIGestureRecognizer *)gesture {
    CGFloat percent = 0.0f;
    if ([gesture isEqual:_gesturePan]) {
        percent = [_gesturePan translationInView:self.view].y / CGRectGetHeight(self.view.frame);
    }
    else {
        percent = [gesture locationInView:self.view].x / CGRectGetWidth(self.view.frame);
    }
    
   CGFloat percentToPop = 0.4f;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            if (percent > percentToPop) {
                [_interactiveTransition finishInteractiveTransition];
            }
            else {
                [_interactiveTransition updateInteractiveTransition:percent];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (percent > percentToPop) {
                [_interactiveTransition finishInteractiveTransition];
            }
            else {
                [_interactiveTransition cancelInteractiveTransition];
            }
            //手势结束之后必须清空interactive对象！！！
            //如果没有清空，在交互式转场取消后该对象依然存在；且在非交互式转场时被返回，会导致转场动画失效！！！
            _interactiveTransition = nil;
            break;
        default:
            break;
    }
}

@end
