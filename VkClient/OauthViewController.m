//
// Created by 1 1 on 04.08.14.
// Copyright (c) 2014 Anton. All rights reserved.
//

#import "OauthViewController.h"
#import "User.h"
#import "AccountsManager.h"
#import <AFNetworking.h>

@interface OauthViewController ()

@property(nonatomic, weak) IBOutlet UIWebView *loginWebView;

@end

@implementation OauthViewController

static NSString *const appID = @"4445164";
static NSString *const oauthURL = @"http://oauth.vk.com/authorize?client_id=%@&scope=wall,friends,offline&redirect_uri=oauth.vk.com/blank.html&display=touch&response_type=token&v=5.24";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearCookies];
    NSString *authLink = [NSString stringWithFormat:oauthURL, appID];
    NSURL *url = [NSURL URLWithString:authLink];
    [_loginWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *response = [webView.request.URL absoluteString];
    if ([response rangeOfString:@"access_token"].location != NSNotFound) {
        NSArray *data = [response componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [_accountsManager addUserWithId:[data[5] integerValue] andAccessToken:data[1]];
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

- (void)clearCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end