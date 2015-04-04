//
//  WaterfallFlowView.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "LLWaterfallFlowView.h"
#import "LLWaterflowViewCell.h"

#define LLWaterflowDefaultNumberOfColumn 3 // 默认列数
#define LLWaterflowDefaultCellHeight 80 // 默认高度

@interface LLWaterfallFlowView ()

/**
 *  cell 的frame数组
 */
@property (nonatomic, strong) NSMutableArray *cellFrames;
/**
 *  要显示的cell字典
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;
/**
 *  需要复用的cell集合
 */
@property (nonatomic, strong) NSMutableSet *resuableCells;

@end

@implementation LLWaterfallFlowView

#pragma mark -- 懒加载
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        _cellFrames = [NSMutableArray array];
    }
    
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        _displayingCells = [NSMutableDictionary dictionary];
    }
    
    return _displayingCells;
}

- (NSMutableSet *)resuableCells
{
    if (_resuableCells == nil) {
        _resuableCells = [NSMutableSet set];
    }
    
    return _resuableCells;
}

- (WaterfallFlowViewMargin)marginInsets
{
    if (WaterfallFlowViewMarginEqualToInsets(_marginInsets, WaterfallFlowViewMarginMake(0, 0, 0, 0, 0, 0))) {
        _marginInsets = WaterfallFlowViewMarginMake(10, 10, 10, 10, 10, 10);
    }
    
    return _marginInsets;
}

#pragma mark private method

UIKIT_STATIC_INLINE BOOL WaterfallFlowViewMarginEqualToInsets(WaterfallFlowViewMargin insets1, WaterfallFlowViewMargin insets2) {
    return insets1.top == insets2.top && insets1.left == insets2.left && insets1.right == insets2.right && insets1.bottom == insets2.bottom && insets1.marginHorizon == insets2.marginHorizon && insets1.marginVertical == insets2.marginVertical;
}

UIKIT_STATIC_INLINE WaterfallFlowViewMargin WaterfallFlowViewMarginMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left, CGFloat horizon, CGFloat vertical) {
    
    WaterfallFlowViewMargin margin = {top, right, bottom, left, horizon, vertical};

    return margin;
}

/**
 *  处理columns数据
 *
 *  @return NSUInteger
 */
- (NSUInteger)numberOfColumn
{
    NSUInteger colums = LLWaterflowDefaultNumberOfColumn;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfColumns)]) {
        colums = [self.dataSource numberOfColumns];
        if (colums < 3) {
            colums = LLWaterflowDefaultNumberOfColumn;
        }
    }
    
    return colums;
}

/**
 *  处理高度
 *
 *  @param index
 *
 *  @return CGFloat
 */
- (CGFloat)heightAtIndex:(NSUInteger)index
{
    CGFloat height = LLWaterflowDefaultCellHeight;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfCellsInWaterfallFlowView:)]) {
        height = [self.dataSource waterfallFlowView:self heightAtIndex:index];
        if (height < 0) {
            height = LLWaterflowDefaultCellHeight;
        }
    }
    
    return height;
}

/**
 *  判断当前的frame是否在屏幕内
 *
 *  @param frame
 *
 *  @return YES-在，NO-不在
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return (CGRectGetMaxY(frame) > self.contentOffset.y) && (CGRectGetMinY(frame) < self.contentOffset.y + CGRectGetHeight(self.frame));
}

#pragma mark public method

- (id)dequeueReuseableCellWithIdentifier:(NSString *)identifier
{
    __block LLWaterflowViewCell *resuableCell = nil;
    [self.resuableCells enumerateObjectsUsingBlock:^(LLWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            resuableCell = cell;
            
            *stop = YES;
        }
    }];
    
    if (resuableCell) {
        [self.resuableCells removeObject:resuableCell];
    }
    
    return resuableCell;
}

- (void)reload
{
    // 多少cell，多少列数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterfallFlowView:self];
    NSUInteger numberOfColumns = [self numberOfColumn];
    
    // cell 宽度
    CGFloat cellWidth = (CGRectGetWidth(self.frame) - self.marginInsets.left - self.marginInsets.right - (numberOfColumns - 1) * self.marginInsets.marginHorizon) / numberOfColumns;
    
    // 初始化列的信息
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i < numberOfColumns; i ++) {
        maxYOfColumns[i] = 0;
    }
    
    for (int i = 0; i < numberOfCells; i ++) {
        CGFloat cellHeight = [self heightAtIndex:i];
        NSUInteger cellAtColumn = 0;
        
        // 判断当前Y最小的是那一列
        CGFloat maxYOfCellAtColumn = maxYOfColumns[cellAtColumn];
        for (int j = 0; j < numberOfColumns; j ++) {
            if (maxYOfCellAtColumn > maxYOfColumns[j]) {
                cellAtColumn = j;
                
                maxYOfCellAtColumn = maxYOfColumns[j];
            }
        }
        // 计算X和Y的位置信息
        CGFloat cellX = self.marginInsets.left + cellAtColumn * (cellWidth + self.marginInsets.marginHorizon);
        CGFloat cellY = 0;
        if (maxYOfCellAtColumn == 0.0) {
            cellY = self.marginInsets.top;
        } else {
            cellY = maxYOfCellAtColumn + self.marginInsets.marginVertical;
        }
        
        // 把frame添加到cellFrame中缓存
        CGRect frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
        [self.cellFrames addObject:[NSValue valueWithCGRect:frame]];
        
        maxYOfColumns[cellAtColumn] = CGRectGetMaxY(frame);
    }
    
    // 计算contentSize的高度
    CGFloat contentHeight = maxYOfColumns[0];
    for (int i = 0; i < numberOfColumns; i ++) {
        if (maxYOfColumns[i] > contentHeight) {
            contentHeight = maxYOfColumns[i];
        }
    }
    contentHeight += self.marginInsets.bottom;
    self.contentSize = CGSizeMake(CGRectGetWidth(self.frame), contentHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger numberOfCells = self.cellFrames.count;
    
    for (int i = 0; i < numberOfCells; i ++) {
        CGRect frame = [[self.cellFrames objectAtIndex:i] CGRectValue];
        
        LLWaterflowViewCell *cell = [self.displayingCells objectForKey:@(i)];
        if ([self isInScreen:frame]) {
            if (cell == nil) {
                cell = [self.dataSource waterfallFlowView:self viewOfIndex:i];
                cell.frame = frame;
                [self addSubview:cell];
                
                [self.displayingCells setObject:cell forKey:@(i)];
            }
        } else {
            if (cell) {
                
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                [self.resuableCells addObject:cell];
            }
        }
    }
}

@end
