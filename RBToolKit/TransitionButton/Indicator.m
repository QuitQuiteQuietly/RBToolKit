//
//  Indicator.m
//  Kiwi
//
//  Created by Ray on 2018/5/25.
//

#import "Indicator.h"

@implementation Indicator

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    
    self = [super init];
    
    if (self) {
        
        [self drawPath:frame];
        
        self.hidden = YES;
        
        self.fillColor = nil;
        self.strokeColor = color.CGColor;
        self.lineWidth = 1;
        
        self.strokeEnd = 0.4;
        
    }
    
    return self;
    
}

- (void)animation {
    self.hidden = NO;
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @0;
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 0.6;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    rotate.repeatCount = MAXFLOAT;
    
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    
    [self addAnimation:rotate forKey:rotate.keyPath];
    
}

- (void)stop {
    self.hidden = YES;
    [self removeAllAnimations];
}

- (void)drawPath:(CGRect)frame {
    
    CGFloat radius = (frame.size.height / 2) * 0.5;
    
    self.frame = CGRectMake(0, 0, frame.size.height, frame.size.height);
    
    CGPoint center = CGPointMake(frame.size.height / 2, self.bounds.size.height / 2);
    CGFloat startAngle = 0 - M_PI_2;
    CGFloat endAngle = M_PI * 2 - M_PI_2;
    BOOL clockwise = YES;
    self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise].CGPath;
    
}

@end
