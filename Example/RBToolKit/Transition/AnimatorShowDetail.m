//
//  AnimatorShowDetail.m
//  appstore_transition
//
//  Created by 周希 on 2018/1/19.
//

#import "AnimatorShowDetail.h"

@implementation AnimatorShowDetail

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
////    _transitionContext = transitionContext;//首先记录transitionContext，下面的方法会用到
//    //我们主要通过这个transitionContext来获取需要做动画的fromViewController和toViewController,fromView和toView
//    //通过viewControllerForKey:这个方法来获取，有两个key来获取相应的Controller
//    // Currently only two keys are defined by the system:
//    //   UITransitionContextToViewControllerKey  获取要出现的Controller
//    //   UITransitionContextFromViewControllerKey 获取要消失的Controller
//    // Currently only two keys are defined by the system:
//    //   UITransitionContextToViewKey //获取要出现的view即上面toViewController的View
//    //   UITransitionContextFromViewKey //获取要出现的view即fromViewController的View
//    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    //拿到ContainerView
//    UIView *containerView = [transitionContext containerView];
//    //把fromView和toView都加到containerView中，在容器中是完成动画
//    [containerView addSubview:toView];
//    [containerView addSubview:fromView];
//
//    //CATransform3D类型的四维仿射变换矩阵，并且提供预置好的进行旋转、变形之后的仿射变换矩阵，m34来控制透视效果,有兴趣的话可以在自己了解一下
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1/500.0;
//    fromView.layer.transform = transform;
//    fromView.layer.anchorPoint = CGPointMake(0, 0.5);
//    fromView.layer.position = CGPointMake(0, CGRectGetMidY(fromView.frame));
//
//    //动画变化
//    [UIView animateWithDuration:2 animations:^{
//
//        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
//
//    } completion:^(BOOL finished) {
//        // This must be called whenever a transition completes (or is cancelled.)
//        // Typically this is called by the object conforming to the
//        // UIViewControllerAnimatedTransitioning protocol that was vended by the transitioning
//        // delegate.  For purely interactive transitions it should be called by the
//        // interaction controller. This method effectively updates internal view
//        // controller state at the end of the transition.
//        //动画完成后必须调用
        [transitionContext finishInteractiveTransition];
        [transitionContext completeTransition:YES];
//    }];

}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
//    UIVisualEffectView *vev = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent]];
//    vev.frame = CGRectMake(0.0f, _viewYFrom, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds));
//    [transitionContext.containerView addSubview:vev];
//
//    UIView *viewTo = [transitionContext viewForKey:UITransitionContextToViewKey];
//    CGRect r = CGRectMake(CGRectGetMinX(viewTo.frame), _viewYFrom,
//                        CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
//    viewTo.frame = CGRectMake(CGRectGetMinX(viewTo.frame), _viewYFrom,
//                              CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
//    [transitionContext.containerView addSubview:viewTo];
////
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
//    v.backgroundColor = [UIColor whiteColor];
//    v.layer.cornerRadius = imageMaskCornerRadius;
//    viewTo.maskView = v;
////
//    [UIView animateWithDuration:transitionDuration
//                          delay:0.0f
//         usingSpringWithDamping:springDamping
//          initialSpringVelocity:0.0f
//                        options:0
//                     animations:^{
//                         viewTo.frame = UIScreen.mainScreen.bounds;
//                         viewTo.maskView.frame = CGRectMake(0.0f, -imageOriginHeight, CGRectGetWidth(viewTo.frame), CGRectGetHeight(viewTo.frame));
//                         viewTo.maskView.layer.cornerRadius = 0.0f;
//                     }
//                     completion:^(BOOL finished) {
//                         vev.frame = UIScreen.mainScreen.bounds;
//                         viewTo.maskView = nil;
//                         [transitionContext completeTransition:YES];
//                     }];
//}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return transitionDuration;
}

@end
