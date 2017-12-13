//
//  UILabel+Animate.m
//  KXInterFace
//
//  Created by Ray on 2017/10/12.
//

#import "UILabel+Animate.h"

@implementation UILabel (Animate)

- (void (^)(NSString *, CGFloat))animateText {
    return ^(NSString *text, CGFloat duration) {
        self.text = text;
        CATransition *animation=[CATransition animation];
        
        animation.delegate = self;
        
        animation.duration = duration;
        //        animation.removedOnCompletion = YES;
        
        animation.fillMode = kCAFillModeRemoved;
        
        animation.type = kCATransitionFade;
        
        [self.layer addAnimation:animation forKey:nil];
    };
}

- (void (^)(NSAttributedString *, CGFloat))animateAttText {
    return ^(NSAttributedString *text, CGFloat duration) {
        self.attributedText = text;
        CATransition *animation=[CATransition animation];
        
        animation.delegate = self;
        
        animation.duration = duration;
        //        animation.removedOnCompletion = YES;
        
        animation.fillMode = kCAFillModeRemoved;
        
        animation.type = kCATransitionFade;
        
        [self.layer addAnimation:animation forKey:nil];
    };
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //    NSLog(@"%@", anim);
}

@end
