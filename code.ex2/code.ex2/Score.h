//
//  Score.h
//  code.ex2
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
{
    int idNumber;
    int math;
    int english;
    int japanese;
}

-(float)average:(int)score1 eScore:(int)score2 jScore:(int)score3;


@end
