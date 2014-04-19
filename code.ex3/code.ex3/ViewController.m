//
//  ViewController.m
//  code.ex3
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
    
    CalciTax *calciTax = [[CalciTax alloc]init];
    int money_view = 500;
    float ratio_view = 0.08;
    [calciTax setTax:ratio_view];
    float result = [calciTax iTax:money_view tax_ratio:[calciTax getTax]];
    NSLog(@"価格 %d 円の税込み価格は %.0f円で、税率は %.2f%%です。",money_view,result,ratio_view);
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
