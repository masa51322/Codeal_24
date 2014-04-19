//
//  CalciTax.h
//  code.ex3
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalciTax : NSObject
{
    float tax;
}

-(void)setTax:(float)ratio;
-(float)getTax;
-(float)iTax:(int)money tax_ratio:(float)ratio;


@end
