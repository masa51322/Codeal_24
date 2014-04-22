//
//  MyUIFavApplication.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/21/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "MyUIFavApplication.h"

@implementation MyUIFavApplication

-(BOOL)openURL:(NSURL *)url
{
    if (!url) {
        return NO;
    }
    
    self.myOpenURL = url;
    AppDelegate *appDelegate = (AppDelegate *)[self delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    WebViewController *webViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"FavoriteWebViewController"];
    webViewController.openURL = self.myOpenURL;
    webViewController.title = @"Web View";
    [appDelegate.navigationController pushViewController:webViewController animated:YES];
    self.myOpenURL = nil;
    
    return YES;
}


@end
