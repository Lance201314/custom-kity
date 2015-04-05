//
//  WaterFlowCell.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/5.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "WaterFlowCell.h"

@implementation WaterFlowCell

- (id)initWithFrame:(CGRect)frame reuseableIdentifier:(NSString *)identifer
{
    self = [super initWithFrame:frame reuseableIdentifier:identifer];
    if (self) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        imageView.backgroundColor = randomColor;
//        imageView.userInteractionEnabled = YES;
//        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(test)];
//        [imageView addGestureRecognizer:tapGesture];
//        
//        [self addSubview:imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.contentMode = UIViewContentModeCenter;
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)test
{
    NSLog(@"test");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
