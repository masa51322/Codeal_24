//
//  XYZViewController.m
//  code.ex1
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "XYZViewController.h"

@interface XYZViewController ()

@end

@implementation XYZViewController


void display2()
{
    NSLog(@"2 times.");
}

int always()
{
    return 2;
}

int twice(int value)
{
    return 2*value;
}

int multily(int value1,int value2)
{
    return value1*value2;
}

float iTAX(int money,float tax_ratio)
{
    float result = (float)money*((float)1 + tax_ratio);
    return result;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Hello World");
    
    for (int i=1;i<10;i++)
    {
        for (int j=1; j<10; j++) {
            NSLog(@"%d * %d = %d",i,j,(i*j));
        }
    }
    
    int data = 20;
    
    if(data >= 20)
    {
        NSLog(@"成人以上");
    }else{
        NSLog(@"未成年");
    }
    
    display2();
    NSLog(@"%d",always());
    NSLog(@"%d",twice(3)); //代入してもよし。
    
    int money_view = 100;
    float ratio_view = 0.08;
    float result_view = iTAX(money_view, ratio_view);
    NSLog(@"%d円の税込み%.2f%%の価格は、%.0fです。",money_view,ratio_view,result_view);
    
    NSNumber *mynumber = @1;
    NSLog(@"%@",mynumber);
    
    NSString *name_value = @"fancy";
    NSLog(@"%@",name_value);
    
    NSArray *array_example =@[@"sa",@"shi",@"su"];
    NSLog(@"%@ %@ %@",array_example[0],array_example[1],array_example[2]);
    
    NSDictionary *dict_example = @{@"sashimi":@"icchio", @"hamachi":@"umaiyo"};
    NSLog(@" %@ %@ ",dict_example[@"sashimi"],dict_example[@"a"]);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
