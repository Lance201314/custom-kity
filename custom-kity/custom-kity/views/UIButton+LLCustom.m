//
//  UIButton+LLCustom.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "UIButton+LLCustom.h"

@implementation UIButton (LLCustom)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[self getImageFromColor:backgroundColor] forState:state];
}

- (void)setRoundButtonWithRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

/**
 *  通过UIColor绘制UIImage
 *
 *  @param color
 *
 *  @return UIImage
 */
- (UIImage *)getImageFromColor:(UIColor *)color
{
    UIImage *image = nil;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillRect(contextRef, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
