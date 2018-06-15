//
//  UIWebViewController.m
//  JavascriptBridge
//
//  Created by linkiing on 2018/1/30.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "UIWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface UIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

@end

@implementation UIWebViewController

#pragma mark - Initialize
- (void)renderButtons:(UIWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"传数据" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(0, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"刷新网页" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(90, 400, 100, 35);
    reloadButton.titleLabel.font = font;
    
    UIButton* safetyTimeoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [safetyTimeoutButton setTitle:@"禁用安全超时" forState:UIControlStateNormal];
    [safetyTimeoutButton addTarget:self action:@selector(disableSafetyTimeout) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:safetyTimeoutButton aboveSubview:webView];
    safetyTimeoutButton.frame = CGRectMake(190, 400, 120, 35);
    safetyTimeoutButton.titleLabel.font = font;
}
- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_bridge) {
        return;
    }
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    //js调oc方法（可以通过data给oc方法传值，使用responseCallback将值再返回给js）
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"OC从JS网页按钮收到的数据: %@", data);
        responseCallback(@"OC发给JS的响应");
    }];
    
    [self renderButtons:webView];
    [self loadExamplePage:webView];
}
#pragma mark - UIButton
- (void)disableSafetyTimeout {
    //安全禁用弹框
    [self.bridge disableJavscriptAlertBoxSafetyTimeout];
}
- (void)callHandler:(id)sender {
    id data = @{ @"greetingFromObjC": @"Hi there, JS!" };
    //oc按钮调js方法（通过data可以传值，通过 response可以接受js那边的返回值 ）
    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id response) {
        NSLog(@"获取到JS返回的响应: %@", response);
    }];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

@end
