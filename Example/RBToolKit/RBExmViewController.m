//
//  RBExmViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/7/4.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBExmViewController.h"

#import "RBtextView.h"

@interface RBExmViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIView *holder;

/**  */
@property (nonatomic, strong)RBtextView *tview;

@end

@implementation RBExmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fd:(id)sender {
    self.tview = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([RBtextView class]) owner:self options:nil].lastObject;
    [self.holder addSubview:self.tview];
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
