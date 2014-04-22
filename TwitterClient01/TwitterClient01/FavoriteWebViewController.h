//
//  FavoriteWebViewController.h
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/21/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteWebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property NSURL *openURL;
@end
