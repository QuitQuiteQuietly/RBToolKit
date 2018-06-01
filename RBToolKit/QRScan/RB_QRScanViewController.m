//
//  RB_QRScanViewController.m
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import "RB_QRScanViewController.h"

#import "RB_QRScan.h"

#import "QRScanView.h"

#import "ReactiveObjC.h"

#import "RB_Authorization.h"

@interface RB_QRScanViewController ()

@end

@implementation RB_QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    QRScanView *view = [[QRScanView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    @weakify(self)

    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {
        @strongify(self)
        
        if (op == eAuthorizeOptionCamera && pass) {

            [[RB_QRScan scan] getReady:^(AVCaptureVideoPreviewLayer *layer) {
                [self.view.layer insertSublayer:layer atIndex:0];
            }];
            
            [[[RB_QRScan scan].flashOn takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
                NSLog(@"fasdgsafds%@", x);
            }];
            
            [RB_QRScan scan].sessionStatus = self.rac_willDeallocSignal;
            
        }
        
    } option:eAuthorizeOptionCamera | eAuthorizeOptionAlbum_read_write];
    
    
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
