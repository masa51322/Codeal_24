//
//  TweetSheetViewController.h
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/20/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TweetSheetViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property NSString *identifier;

- (IBAction)tweetAction:(id)sender;
- (IBAction)editEndAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
