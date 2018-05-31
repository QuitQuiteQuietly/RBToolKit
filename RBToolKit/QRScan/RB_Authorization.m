//
//  RB_Authorization.m
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import "RB_Authorization.h"

#import <Photos/Photos.h>

typedef void(^decision)(BOOL decision);

@implementation RB_Authorization


+ (void)authorize:(pass)process option:(eAuthorizeOption)option {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device) { return; }

    
    BOOL camera = option & eAuthorizeOptionCamera;
    

    if (camera) {
        [RB_Authorization checkCamera:^(BOOL decision) {
            if (process) {
                process(eAuthorizeOptionCamera, decision);
            }
            if (option & eAuthorizeOptionAlbum) {
                [RB_Authorization aboutAlbum:option process:process];
            }
        }];
    }
    else {
        
        [RB_Authorization aboutAlbum:option process:process];
        
    }
}

+ (void)checkCamera:(decision)decision {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    BOOL success = NO;
    
    switch (status) {
            
        case PHAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                [RB_Authorization finalDecision:decision success:granted];
            }];
            
            return;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            break;
        case PHAuthorizationStatusAuthorized:
            success = YES;
            break;
    }
    
    [RB_Authorization finalDecision:decision success:success];
}

+ (void)aboutAlbum:(eAuthorizeOption)option process:(pass)process {

    BOOL album = option & eAuthorizeOptionAlbum;

    if (album) {

        [RB_Authorization checkAlbum:^(BOOL decision) {
            if (process) {
                process(eAuthorizeOptionAlbum, decision);
            }
        }];

    }
    else {
        if (process) {
            process(eAuthorizeOptionAlbum, NO);
        }
    }
}

+ (void)checkAlbum:(decision)decision  {
    PHAuthorizationStatus checkStatus = [PHPhotoLibrary authorizationStatus];
    __block BOOL success = NO;

    switch (checkStatus) {
            
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                switch (status) {
                    case PHAuthorizationStatusNotDetermined:
                    case PHAuthorizationStatusRestricted:
                    case PHAuthorizationStatusDenied:
                        break;
                    case PHAuthorizationStatusAuthorized:
                        success = YES;
                        break;
                }
                
                [RB_Authorization finalDecision:decision success:success];
                
                return;
            }];
            
            ///禁止 在未决定的时候 走到 [RB_Authorization finalDecision:decision success:success]; 上
            return;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            break;
        case PHAuthorizationStatusAuthorized:
            success = YES;
            break;
            
    }
    
    [RB_Authorization finalDecision:decision success:success];
   
}


+ (void)finalDecision:(decision)decision success:(BOOL)success {
    
    if (decision) {
        dispatch_async(dispatch_get_main_queue(), ^{
            decision(success);
        });
    }
    
}



@end
