//
//  AnimatorDismiss.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowImage.h"





@interface AnimatorShowImage ()

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end





@implementation AnimatorShowImage

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    _viewToTransition.hidden = YES;

    [transitionContext.containerView insertSubview:[transitionContext viewForKey:UITransitionContextToViewKey] atIndex:0];
    UIView *viewFrom = [transitionContext viewForKey:UITransitionContextFromViewKey];

    //可以使用maskView或者mask+bezierPath
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds))];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 0.0f;
    viewFrom.maskView = v;

    if (_isClosed) {
        [transitionContext.containerView.subviews[1] removeFromSuperview];
        
        [UIView animateWithDuration:transitionDuration
                              delay:0.0f
             usingSpringWithDamping:springDamping
              initialSpringVelocity:0.0f
                            options:0
                         animations:^{
                             viewFrom.frame = CGRectMake(CGRectGetMinX(viewFrom.frame), _viewYTo,
                                                         CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame));
                             viewFrom.maskView.frame = CGRectMake(imageMaskLeftRight, imageMaskTopBottom-imageOriginHeight, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight);
                             viewFrom.maskView.layer.cornerRadius = imageMaskCornerRadius;
                             if ([viewFrom isKindOfClass:[UIScrollView class]]) {
                                ((UITableView *)viewFrom).contentOffset = CGPointMake(0.0f, -imageOriginHeight);
                             }
                             
                             [viewFrom viewWithTag:2000].alpha = 0.0f;
                         }
                         completion:^(BOOL finished) {
                             _viewToTransition.hidden = NO;
                             [transitionContext completeTransition:YES];
                         }];
    }
    else {
        [UIView animateWithDuration:transitionDuration-animationEndDuration
                              delay:0.0f
             usingSpringWithDamping:springDamping
              initialSpringVelocity:0.0f
                            options:0
                         animations:^{
                             viewFrom.transform = CGAffineTransformMakeScale(transformScale, transformScale);
                             viewFrom.maskView.layer.cornerRadius = imageMaskCornerRadius;
                         }
                         completion:^(BOOL finished) {
                             [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

- (void)animationEnded:(BOOL)transitionCompleted {
    if (!_isClosed) {
        if (transitionCompleted) {
            UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
            [_transitionContext.containerView addSubview:viewFrom];
            [_transitionContext.containerView.subviews[1] removeFromSuperview];

            [UIView animateWithDuration:animationEndDuration
                                  delay:0.0f
                 usingSpringWithDamping:springDamping
                  initialSpringVelocity:0.0f
                                options:0
                             animations:^{
                                 viewFrom.transform = CGAffineTransformIdentity;
                                 viewFrom.frame = CGRectMake(CGRectGetMinX(viewFrom.frame), _viewYTo,
                                                             CGRectGetWidth(viewFrom.frame), CGRectGetHeight(viewFrom.frame));
                                 viewFrom.maskView.frame = CGRectMake(imageMaskLeftRight, imageMaskTopBottom-imageOriginHeight, CGRectGetWidth(UIScreen.mainScreen.bounds)-imageMaskLeftRight*2, imageMaskHeight);
                                 if ([viewFrom isKindOfClass:[UIScrollView class]]) {
                                     ((UITableView *)viewFrom).contentOffset = CGPointMake(0.0f, -imageOriginHeight);
                                 }
                                 [viewFrom viewWithTag:2000].alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 _viewToTransition.hidden = NO;
                                 [viewFrom removeFromSuperview];
                             }];
        }
        else {
            UIView *viewFrom = [_transitionContext viewForKey:UITransitionContextFromViewKey];
            viewFrom.maskView = nil;
        }
    }
}

@end
