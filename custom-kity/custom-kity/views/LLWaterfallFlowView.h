//
//  LLWaterfallFlowView.h
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLWaterfallFlowViewDataSource;
@class LLWaterflowViewCell;

typedef struct {
    /**
     *  上下左右边距，cell之间上下左右边距
     */
    CGFloat top, right, bottom, left, marginHorizon, marginVertical;
}WaterfallFlowViewMargin;

@interface LLWaterfallFlowView : UIScrollView

@property (nonatomic, weak) id<LLWaterfallFlowViewDataSource> dataSource;
@property (nonatomic, assign) WaterfallFlowViewMargin marginInsets;

- (void)reload;
/**
 *  复用cell
 *
 *  @param identifier
 *
 *  @return cell
 */
- (id)dequeueReuseableCellWithIdentifier:(NSString *)identifier;

@end

@protocol LLWaterfallFlowViewDataSource <NSObject>

@required
/**
 *  多少列
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfColumns;
/**
 *  cell个数
 *
 *  @param waterfallFlowView self
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfCellsInWaterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView;

/**
 *  cell view
 *
 *  @param waterfallFlowView self
 *  @param index             cell 位置
 *
 *  @return view
 */
- (LLWaterflowViewCell *)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView viewOfIndex:(NSUInteger)index;

/**
 *  cell 高度
 *
 *  @param waterfallFlowView
 *  @param index
 *
 *  @return CGFloat
 */
- (CGFloat)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView heightAtIndex:(NSUInteger)index;
/**
 *  cell 边距
 *
 *  @param waterfallFlowView
 *  @param marginType
 *
 *  @return CGFloat
 */
//- (CGFloat)waterfallFlowView:(LLWaterfallFlowView *)waterfallFlowView marginFotType:(WaterfallFlowViewMarginType)marginType;

@end
