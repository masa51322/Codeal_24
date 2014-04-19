//
//  WebViewController.h
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/19/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>//補完させるために。
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property NSURL *openURL;

@end
