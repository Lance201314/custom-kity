//
//  LLWaterflowViewCell.h
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLWaterflowViewCell : UIView

@property (nonatomic, strong) NSString *identifier;

- (id)initWithReuseableIdentifier:(NSString *)identifer;

@end
