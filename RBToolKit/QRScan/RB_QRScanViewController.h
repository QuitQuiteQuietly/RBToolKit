//
//  RB_QRScanViewController.h
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import <UIKit/UIKit.h>

#import "RB_QRScanConfig.h"


typedef RB_QRScanConfig *(^config)(RB_QRScanConfig *config);

typedef void(^manageItem)(UIBarButtonItem *item);

@interface RB_QRScanViewController : UIViewController


+ (RB_QRScanViewController *)scan:(config)config;

+ (RB_QRScanViewController *)scan:(config)config album:(manageItem)album;


@end
