//
//  Indicator.h
//  Kiwi
//
//  Created by Ray on 2018/5/25.
//

#import <QuartzCore/QuartzCore.h>

@interface Indicator : CAShapeLayer

///开始动画
- (void)animation;

///结束
- (void)stop;

- (instancetype)initWithFrame:(CGRect)frame;

@end
