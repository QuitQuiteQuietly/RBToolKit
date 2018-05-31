//
//  QRViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/31.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "QRViewController.h"

#import <RBToolKit/QRGenerate.h>

#import <RBToolKit/RB_Authorization.h>

@interface QRViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *qr_imageView;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _qr_imageView.image = [QRGenerate qr_info:@"wzc5670594" width:CGRectGetWidth(_qr_imageView.frame)];
    
    
    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {
        
        NSString *f = op == eAuthorizeOptionCamera ? @"camera" : @"album";
        
        NSLog(@"%@ %d %@", f, pass, [NSThread currentThread]);
        
    } option:eAuthorizeOptionCamera | eAuthorizeOptionAlbum];
    
    
    
}


@end
