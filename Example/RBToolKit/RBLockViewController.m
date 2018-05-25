//
//  RBLockViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/14.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBLockViewController.h"

@interface RBLockViewController ()

@property (strong, nonatomic) IBOutletCollection(UIControl) NSArray *lock;

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *imageView;

@end

@implementation RBLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.image = [self f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)lock:(UIButton *)sender {
    for (UIControl *c in self.lock) {
        c.enabled = NO;
    }
}
- (IBAction)unLock:(UIButton *)sender {
    for (UIControl *c in self.lock) {
        c.enabled = YES;
    }
}

- (UIImage *)f {
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale, 64);
    
    UIImage *image = [UIImage imageNamed:@"背景"];
    
    CGImageRef sourceImageRef = [image CGImage];
//    image imafro
     CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
     UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    ///绘制文字 到 图片上
//    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, 0.0);
//
//    CGFloat canvasCenterX = canvasSize.width / 2;
//    CGFloat canvasCenterY = canvasSize.height / 2;
//    CGFloat imageTopY =  canvasCenterY - (image.size.height / 2);
//
//    [image drawAtPoint:CGPointMake(canvasCenterX - (image.size.width / 2), imageTopY)];
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawPath(context, kCGPathStroke);
//
//    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
//
//    UIGraphicsEndImageContext ();
    return newImage;
}


@end
