//
//  CalciTax.m
//  code.ex3
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "CalciTax.h"

@implementation CalciTax

-(void)setTax:(float)ratio
{
    tax = ratio;
}

-(float)getTax
{
    return tax;
}

-(float)iTax:(int)money tax_ratio:(float)ratio
{
    return (float)money*((float)1 + ratio);
}

@end
