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

#define randomColor [UIColor colorWithRed:random() % 255 / 255.0 green:random() % 255 / 255.0 blue:random() % 255 / 255.0 alpha:random() % 10 / 10.0]

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
    return 70;
}

- (NSInteger)numberOfColumns
{
    return 3;
}

- (CGFloat)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView heightAtIndex:(NSUInteger)index
{
    CGFloat height = random() % 100 + 60;
    
    return height;
}

- (LLWaterflowViewCell *)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView viewOfIndex:(NSUInteger)index
{
    static NSString *cellIdentifier = @"cell01";
    LLWaterflowViewCell *cell = [waterfallFlowView dequeueReuseableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LLWaterflowViewCell alloc] initWithReuseableIdentifier:cellIdentifier];
    }
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
