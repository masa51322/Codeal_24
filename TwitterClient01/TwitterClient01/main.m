//
//  main.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "MyUIApplication.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {//第三引数 nil = 通常のアプリケーション。　今回は nil >> NSStringFromClass([MyUIApplication class])変えたもの。
        return UIApplicationMain(argc, argv, NSStringFromClass([MyUIApplication class]), NSStringFromClass([AppDelegate class]));
    }
}
