//
//  WaterfallFlowViewController.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "WaterfallFlowViewController.h"
#import "LLWaterflowViewCell.h"
#import "LLWaterfallFlowView.h"
#import "WaterFlowCell.h"

@interface WaterfallFlowViewController () <LLWaterfallFlowViewDataSource, UIScrollViewDelegate>
{
    LLWaterfallFlowView *_waterfallFlowView;
}

@end

@implementation WaterfallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _waterfallFlowView = [[LLWaterfallFlowView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _waterfallFlowView.dataSource = self;
    _waterfallFlowView.backgroundColor = randomColor;
    _waterfallFlowView.delegate = self;
    [self.view addSubview:_waterfallFlowView];
    
    [_waterfallFlowView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LLWaterfallFlowViewDataSource
- (NSInteger)numberOfCellsInWaterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView
{
    return 40;
}

- (NSInteger)numberOfColumns
{
    return 3;
}

- (CGFloat)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView heightAtIndex:(NSUInteger)index
{
    CGFloat height = 50;
    
    NSUInteger temp = index % 4;
    switch (temp) {
        case 0:
        {
            height = 100;
        }
            break;
        case 1:
        {
            height = 140;
        }
            break;
        case 2:
        {
            height = 70;
        }
            break;
        case 3:
        {
            height = 90;
        }
            break;
            
        default:
            height = 50;
            break;
    }
    
    return height;
}

- (LLWaterflowViewCell *)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView frame:(CGRect)frame viewOfIndex:(NSUInteger)index
{
    static NSString *cellIdentifier = @"cell01";
    WaterFlowCell *cell = [waterfallFlowView dequeueReuseableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WaterFlowCell alloc] initWithFrame:frame reuseableIdentifier:cellIdentifier];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"~~~@##%ld", index];
    cell.backgroundColor = randomColor;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
