//
//  BlockLearn.m
//  custom-kity
//
//  Created by lance on 15/4/7.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "BlockLearn.h"

@implementation BlockLearn

- (void)test
{
    __block id obj = [NSObject new];
    
    void (^block)(void) = ^{
        NSLog(@"%@", obj);
    };
    
    block();
}

@end
