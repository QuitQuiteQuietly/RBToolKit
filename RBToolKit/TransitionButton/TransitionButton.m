//
//  TransitionButton.m
//  Kiwi
//
//  Created by Ray on 2018/5/25.
//

#import "TransitionButton.h"

#import "Indicator.h"

@interface TransitionButton ()

/**  */
@property (nonatomic, strong)Indicator *indicator;

/**  */
@property (nonatomic, strong)UIImage *cacheImage;

/**  */
@property (nonatomic, strong)NSString *cacheTitle;

@end


@implementation TransitionButton

- (void)start {
    
    self.userInteractionEnabled = NO;
    
    [self storgeOriginState:YES];
    
    [self setTitle:@"" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.layer.cornerRadius = self.frame.size.height / 2;
    } completion:^(BOOL finished) {
        [self shrink:YES];
    }];
    
}


- (void)storgeOriginState:(BOOL)storge {
    
    if (storge) {
        self.cacheImage = [self imageForState:UIControlStateNormal];
        self.cacheTitle = [self titleForState:UIControlStateNormal];
    }
    else {
        [self setTitle:self.cacheTitle forState:UIControlStateNormal];
        [self setImage:self.cacheImage forState:UIControlStateNormal];
    }
    
}

- (void)stop {
    
    [self backOriginState];
}

- (void)backOriginState {
    
    [self shrink:NO];
    
}
/**
 缩放

 @param small 缩小/还原
 */
- (void)shrink:(BOOL)small {
    
    CGFloat from = small ? self.frame.size.width : self.bounds.size.height;
    CGFloat to = small ? self.frame.size.height : self.bounds.size.width;
    
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue             = @(from);
    shrinkAnim.toValue               = @(to);
    shrinkAnim.duration              = 0.1;
    
    CAMediaTimingFunction *shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shrinkAnim.timingFunction        = shrinkCurve;
    shrinkAnim.fillMode              = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = NO;
    
    self.userInteractionEnabled = !small;
    
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    
    [self storgeOriginState:NO];
    
    if (small) {
        [self.indicator animation];
    }
    else {
        [self.indicator stop];
    }
    
}


//- (void)expand {
//    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    expandAnim.fromValue            = @1;
//    expandAnim.toValue              = @(26);
//
//    CAMediaTimingFunction *expandCurve = [CAMediaTimingFunction functionWithControlPoints:.95 :.02 :1 :.05];
//    expandAnim.timingFunction = expandCurve;
//    expandAnim.duration = 0.4;
//    expandAnim.fillMode = kCAFillModeForwards;
//    expandAnim.removedOnCompletion  = NO;
//
//    [CATransaction setCompletionBlock:^{
//
//
//        [self.indicator stop];
//
//    }];
//
//    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
//
//    [CATransaction commit];
//}

- (Indicator *)indicator {
    if (!_indicator) {
        _indicator = [[Indicator alloc]initWithFrame:self.frame];
        [self.layer addSublayer:_indicator];
    }
    return _indicator;
}
@end
