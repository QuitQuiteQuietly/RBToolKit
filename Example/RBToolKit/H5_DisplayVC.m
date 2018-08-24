//
//  H5_DisplayVC.m
//  ZLWallet
//
//  Created by Ray on 2018/6/19.
//  Copyright © 2018年 Great Technologies. All rights reserved.
//

#import "H5_DisplayVC.h"

#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>

#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Weverything"
@interface H5_DisplayVC ()<WKNavigationDelegate, WKScriptMessageHandler>
#pragma clang diagnostic pop


/**  */
@property (nonatomic, strong)WKWebView *webView;

/**  */
@property (nonatomic, weak)IBOutlet UIView *webHolderView;

/**  */
@property (nonatomic, weak)IBOutlet UIProgressView *progressView;


@end

@implementation H5_DisplayVC


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupWebView];
    
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"BCBPay"];

    NSURL *filePath = [[NSBundle mainBundle] URLForResource:@"test-BCBPay-ios5.html" withExtension:nil];
    
    NSURLRequest *r = [NSURLRequest requestWithURL:filePath];
    
    [self.webView loadRequest:r];
    
}

- (void)setupWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //     根据需要去设置对应的属性
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:config];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.webView.navigationDelegate = self;
    
    [self.webHolderView addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *url = message.body;
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:url]]) {
        /**
         iOS9 以后需要加入info.plist
         <key>LSApplicationQueriesSchemes</key>
         <array>
         <string>weixin</string>
         </array>
         */
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        if ([object isKindOfClass:[WKWebView class]]) {
            WKWebView *webView = (WKWebView *)object;
            self.progressView.hidden = (webView.estimatedProgress == 1.0);
            [self.progressView setProgress:webView.estimatedProgress animated:YES];
        }
        
    }
    
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.progressView.progress = 1.f;
}

@end
