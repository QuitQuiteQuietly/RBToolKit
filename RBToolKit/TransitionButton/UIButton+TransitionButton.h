//
//  TransitionButton.h
//  Kiwi
//
//  Created by Ray on 2018/5/25.
//

#import <UIKit/UIKit.h>

#import "TransitionConfig.h"

/**
 
 * Inspire by AladinWay/TransitionButton
 
 * https://github.com/AladinWay/TransitionButton
 
 */
@interface UIButton (TransitionButton)


///开始动画
- (void)animate:(BOOL)start;

- (void)animate:(BOOL)start stop_delay:(NSInteger)delay;

- (void)start:(void (^)(TransitionConfig *config))config;

/** 是否开始 */
@property (nonatomic, assign)BOOL start;

@end
