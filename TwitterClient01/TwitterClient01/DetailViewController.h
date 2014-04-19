//
//  DetailViewController.h
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/19/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface DetailViewController : UIViewController

@property NSString *name; //受け取り口。
@property NSString *text; //受け取るための箱が必要になってくる。
@property UIImage *image; //外からみるので、.hに書き込む
@property NSString *identifier;
@property NSString *idStr;

@end
