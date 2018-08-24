//
//  RBtextView.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/7/4.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBtextView.h"

#import <Masonry/Masonry.h>

@implementation RBtextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)didMoveToSuperview {
    
    [super didMoveToSuperview];
    
//    self.layer.anchorPoint = CGPointMake(0, 0);
    
    if (self.superview) {
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
            make.height.mas_equalTo(0);
        }];
        [self.superview.superview layoutIfNeeded];
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

//            [self mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.mas_offset(UIEdgeInsetsZero);
////                make.height.mas_equalTo(200);
//            }];
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_offset(UIEdgeInsetsZero);
            }];
//            [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(200);
//            }];
            
            [self.superview.superview layoutIfNeeded];
        } completion:nil];

    }
    
    NSLog(@"%@", self.superview);
    
}

@end
