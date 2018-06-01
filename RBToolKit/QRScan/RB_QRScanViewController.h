//
//  RB_QRScanViewController.h
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import <UIKit/UIKit.h>

#import "RB_QRScanConfig.h"

#import "RB_QRScan.h"

#import "RB_Authorization.h"

typedef RB_QRScanConfig *(^config)(RB_QRScanConfig *config);

typedef void(^manageItem)(UIBarButtonItem *item);

@interface RB_QRScanViewController : UIViewController


/**
 权限失败

 @param option 权限
 @return （NSString *info, NSString *confirm）
 
 子类复写
 
 */
- (RACTuple *)authorizationFailedInfo:(eAuthorizeOption)option;

/** 扫描结果 */
@property (nonatomic, strong)scanSomething scanSomething;

+ (instancetype)scan:(config)config;

+ (instancetype)scan:(config)config album:(manageItem)album;


@end
