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

- (void)start;


- (void)start:(void (^)(TransitionConfig *config))config;

- (void)stop;

@end
