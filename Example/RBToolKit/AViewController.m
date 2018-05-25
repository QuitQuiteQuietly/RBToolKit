//
//  AViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/4.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"presentedViewController %@", self.presentedViewController);
    NSLog(@"presentingViewController %p", self.presentingViewController);
    
    NSArray *array = @[@3,@4,@5,@1,@245,@13];
   RACSequence *r = [[array.rac_sequence filter:^BOOL(NSNumber*  _Nullable value) {
        return value.integerValue > 1;
    }] map:^id _Nullable(NSNumber*  _Nullable value) {
        return [NSString stringWithFormat:@"123RR%@", value];
    }];
    
    RACSignal *s = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        return nil;
    }];
    
    NSArray *d = [r array];
    
    NSLog(@"%@", d);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
//    if (self.callBack) {
//        self.callBack();
//    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)toB:(id)sender {
    [self presentViewController:[BViewController new] animated:YES completion:nil];
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
