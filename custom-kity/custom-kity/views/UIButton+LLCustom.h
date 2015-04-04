//
//  UIButton+LLCustom.h
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LLCustom)

/**
 *  设置UIButton的背景颜色
 *
 *  @param backgroundColor 背景颜色
 *  @param state           UIButton状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  设置UIButton圆角
 *
 *  @param radius 圆角半径
 */
- (void)setRoundButtonWithRadius:(CGFloat)radius;

@end
