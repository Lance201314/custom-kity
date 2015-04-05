//
//  LLWaterflowViewCell.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "LLWaterflowViewCell.h"

@implementation LLWaterflowViewCell

- (id)initWithFrame:(CGRect)frame reuseableIdentifier:(NSString *)identifer
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifer;
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@~~~~%@", touches, event);
}

@end
