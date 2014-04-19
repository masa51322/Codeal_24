//
//  ViewController.m
//  code.ex2
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    Score *score = [[Score alloc] init];
    float average3 = [score average:80 eScore:90 jScore:70];
    NSLog(@"三科目の合計は%.2f点です",average3);
    
                 
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
