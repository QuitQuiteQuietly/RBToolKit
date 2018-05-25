
//  RBViewController.m
//  RBToolKit
//
//  Created by wzc5670594 on 12/13/2017.
//  Copyright (c) 2017 wzc5670594. All rights reserved.
//

#import "RBViewController.h"
#import "AViewController.h"

#import <RBToolKit/RBToolKit.h>

#import <RBToolKit/RBLocalize.h>

#import <ReactiveObjC/ReactiveObjC.h>

#import <RBToolKit/RBFileManager.h>



@interface RBViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *imageView;
/**  */
@property (nonatomic, weak)RBFileManager *f;

/**  */
@property (nonatomic, weak)RACSignal *s;
@property (nonatomic, weak)RACSignal *sS;


@end

@implementation RBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self safeString];
    
    [self checkFilePath];
    
    NSLog(@"当前语言 %lu", (unsigned long)[RBLocalize checkLocalizeStatus]);
    
    NSLog(@"%@", self.s);
    
    [self then];
    
    NSLog(@"%@", self.s);
}


- (void)then {
    
    RACSignal *s = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        //        [subscriber sendError:nil];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"第1个信号disposable");
        }];
    }];
    
    [s.rac_willDeallocSignal subscribeCompleted:^{
        NSLog(@"s dealloc");
    }];
    
    [s subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
    } completed:^{
        NSLog(@"s completed");
    }];
//
//    RACSubject *subject = [RACSubject subject]; //1
//    [subject.rac_willDeallocSignal subscribeCompleted:^{ //2
//        NSLog(@"subject dealloc");
//    }];
//    [subject subscribeNext:^(id x) { //3
//        NSLog(@"next = %@", x);
//    }];
//    [subject sendNext:@1]; //4
//
    self.sS = [s then:^RACSignal * _Nonnull{
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@2];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"第2个信号disposable");
            }];
        }];
    }];
    
    [self.sS subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } completed:^{
        NSLog(@"then completed");
    }];
    
    self.s = s;

    NSLog(@"%@", self.s);
    
    
}

- (IBAction)isSStillThere {
     NSLog(@"%@", self.s);
    NSLog(@"%@", self.sS);
}


- (void)safeString {
    NSNumber *k = nil;
    
    if (k == NULL) {
        NSLog(@"k is NULL");
    }
    NSString *x = @"<null>";
    
    if (x == NULL) {
        NSLog(@"x is NULL");
    }
    
    NSLog(@"safe(k)%@----safe(x)%@", NSString.safe(k), NSString.safe(x));
}

//测试组件。filemanager
- (void)checkFilePath {
    
    NSLog(@"%@", self.f);
    
    NSData *d = [@"13213" dataUsingEncoding:NSUTF8StringEncoding];
    
    RBFileManager *f = [RBFileManager new];
    NSLog(@"写文件成功：%d", f.documents.user.write(d));
    NSLog(@"临时文件夹地址：%@", f.tmp.path);
    self.f = f;
    
}

- (IBAction)toAVc:(id)sender {

    AViewController *a = [AViewController new];
    
    @weakify(self)
    a.callBack = ^{
        @strongify(self)
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self presentViewController:a animated:YES completion:^{
        NSLog(@"%@", self);
    }];
    NSLog(@"presentedViewController %@", self.presentedViewController);
    NSLog(@"presentingViewController %@", self.presentingViewController);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
