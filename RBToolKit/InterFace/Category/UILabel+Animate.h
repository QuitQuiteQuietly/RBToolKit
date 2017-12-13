//
//  UILabel+Animate.h
//  KXInterFace
//
//  Created by Ray on 2017/10/12.
//

#import <UIKit/UIKit.h>

@interface UILabel (Animate)<CAAnimationDelegate>

- (void (^)(NSString *text, CGFloat duration))animateText;

- (void (^)(NSAttributedString *text, CGFloat duration))animateAttText;

@end
