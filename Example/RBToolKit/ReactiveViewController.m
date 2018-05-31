//
//  ReactiveViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/30.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "ReactiveViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ReactiveViewController ()

@end

@implementation ReactiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *numbers = @[@(0), @(1), @(2)].rac_sequence.signal;
    
    RACSignal *letters1 = @[@"A", @"B", @"C"].rac_sequence.signal;
    RACSignal *letters2 = @[@"X", @"Y", @"Z"].rac_sequence.signal;
    RACSignal *letters3 = @[@"M", @"N"].rac_sequence.signal;
    NSArray *arrayOfSignal = @[letters1, letters2, letters3]; //2
    
    
//    [[[numbers map:^id(NSNumber *n) {
//        //3
//        return arrayOfSignal[n.integerValue];
//    }] collect] subscribeNext:^(NSArray *array) {
//        NSLog(@"%@, %@", [array class], array);
//    } completed:^{
//        NSLog(@"completed");
//    }];
    
    [[[[numbers
        map:^id(NSNumber *n) {
            return arrayOfSignal[n.integerValue];
        }] collect] flattenMap:^RACSignal *(NSArray *arrayOfSignal) {
          //1
          return [RACSignal combineLatest:arrayOfSignal
                                   reduce:^(NSString *first, NSString *second, NSString *third) {
                                       return [NSString stringWithFormat:@"%@-%@-%@", first, second, third];
                                   }];
      }]
     subscribeNext:^(NSString *x) {
         NSLog(@"%@, %@", [x class], x);
     } completed:^{
         NSLog(@"completed");
     }];
    
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
