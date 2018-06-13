//
//  Card_ViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/6.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "Card_ViewController.h"

#import "CardInfo_ViewController.h"

#import "AnimatorShowDetail.h"
#import "AnimatorShowImage.h"

@interface Card_ViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) CardInfo_ViewController *destinationVC;
@property (nonatomic, assign) CGFloat imageTappedY;
@property (nonatomic, strong) UIView *viewToTransition;

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *card;

@end

@implementation Card_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCard:)];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    _card.userInteractionEnabled = YES;
    [_card addGestureRecognizer:tap];
}

- (void)tapCard:(UITapGestureRecognizer *)gesture {
    
    _imageTappedY = 25.0f+CGRectGetMinY(gesture.view.superview.superview.frame);
    _viewToTransition = gesture.view;
    
    [self performSegueWithIdentifier:[CardInfo_ViewController description] sender:nil];
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        AnimatorShowDetail *animator = [[AnimatorShowDetail alloc] init];
        animator.viewYFrom = _imageTappedY;
        return animator;
    }
//    else if (operation == UINavigationControllerOperationPop) {
//        AnimatorShowImage *animator = [[AnimatorShowImage alloc] init];
//        NSLog(@"%@", animator);
//        animator.isClosed = NO;
//        animator.viewYTo = _imageTappedY;
//        animator.viewToTransition = _viewToTransition;
//        return animator;
//    }
//    else {
        return [AnimatorShowDetail new];
//    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _destinationVC = segue.destinationViewController;
}
@end
