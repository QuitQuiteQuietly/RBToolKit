//
//  RBLayerTestViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/7/16.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBLayerTestViewController.h"

@interface RBLayerTestViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIView *nonView;

@end

@implementation RBLayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    
    CATextLayer *t = [CATextLayer layer];
    
    [layer addSublayer:t];
   
    
    t.string = @"4123";
    

    t.foregroundColor = [UIColor whiteColor].CGColor;
    t.alignmentMode = kCAAlignmentCenter;
    //        _status_display.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:12];
    t.contentsScale = [UIScreen mainScreen].scale;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    t.font = fontRef;
    t.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    [self.nonView.layer addSublayer:layer];
    layer.frame = CGRectMake(0, 0, 100, 30);
     t.frame = layer.bounds;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
