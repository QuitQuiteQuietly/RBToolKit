//
//  RBLines.m
//  Kiwi
//
//  Created by Ray on 2018/4/27.
//

#import "RBLines.h"

@implementation RBLines


- (void)drawRect:(CGRect)rect {

//    CGFloat lineSpacing = 2;
//
//    CGSize size = self.frame.size;
//
//    CGSize lineSize = CGSizeMake((size.width - 4 * lineSpacing) / 5, (size.height - 2 * lineSpacing) / 3);
//
//    CGFloat x = (self.layer.bounds.size.width - size.width) / 2;
//    CGFloat y = (self.layer.bounds.size.height - size.height) / 2;
//
//    for (int i = 0; i < 8; i ++) {
//
//        CALayer *line = [self lines:M_PI_4 * i size:lineSize origin:CGPointMake(x, y) containerSize:size color:[UIColor blueColor]];
//
//        [self.layer addSublayer:line];
//
//    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CGFloat lineSpacing = 2;
    
    CGSize size = self.frame.size;
    
    CGSize lineSize = CGSizeMake((size.width - 4 * lineSpacing) / 5, (size.height - 2 * lineSpacing) / 3);
    
    
    CFTimeInterval duration = 1.2;
    CFTimeInterval beginTime = CACurrentMediaTime();
    NSArray *beginTimes = @[@(0.12), @(0.24), @0.36, @0.48, @0.6, @0.72, @0.84, @0.96];
    CAMediaTimingFunction* timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];

    animation.keyTimes = @[@0, @0.5, @1];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.values = @[@1, @0.3, @1];
    animation.duration = duration;
    animation.repeatCount = CGFLOAT_MAX;
//    animation.isRemovedOnCompletion = NO;
    
    
    for (int i = 0; i < 8; i ++) {
        
        CALayer *line = [self lines:M_PI / 4 * i size:lineSize origin:CGPointMake(0, 0) containerSize:size color:[UIColor blueColor]];
        
        animation.beginTime = beginTime + [beginTimes[i] floatValue];
        
        [line addAnimation:animation forKey:@"animation"];
        
        [self.layer addSublayer:line];
        
    }
}



- (CALayer *)lines:(CGFloat)angle size:(CGSize)size origin:(CGPoint)origin containerSize:(CGSize)containerSize color:(UIColor *)color {
    
    CGFloat radius = containerSize.width / 2 - MAX(size.width, size.height) / 2;
    CGSize lineContainerSize = CGSizeMake(MAX(size.width, size.height), MAX(size.width, size.height));
    CALayer *lineContainer = [CALayer new];
    
    CGRect lineContainerFrame = CGRectMake(origin.x + radius * (cos(angle) + 1),
                                           origin.y + radius * (sinf(angle) + 1),
                                           lineContainerSize.width,
                                           lineContainerSize.height);
    CAShapeLayer * line = [CAShapeLayer layer];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width / 2];

    line.fillColor = color.CGColor;
    
    line.path = path.CGPath;
    
    line.lineWidth = 2;
    
    CGRect lineFrame = CGRectMake((lineContainerSize.width - size.width) / 2, (lineContainerSize.height - size.height) / 2, size.width,  size.height);
    
    lineContainer.frame = lineContainerFrame;
    
    line.frame = lineFrame;
    
    [lineContainer addSublayer:line];
    
    lineContainer.sublayerTransform = CATransform3DMakeRotation((M_PI / 2 + angle), 0, 0, 1);
 
    return lineContainer;
}



@end
