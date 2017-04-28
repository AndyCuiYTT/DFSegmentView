//
//  DFSegmentView.h
//  SinoCommunity
//
//  Created by df on 2017/4/28.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DFSegmentViewDelegate <NSObject>

@required
/**
 *  导航栏数组
 */
- (NSArray *)titlesForDFSegmentViewHeadView;
/**
 *  指明父控制器
 */
- (UIViewController *)superViewController;
/**
 *  导航栏index 对应的子控制器
 */
- (UIViewController *)subViewControllerWithIndex:(NSInteger)index;



@end
@interface DFSegmentView : UIView

@property (nonatomic, weak) id<DFSegmentViewDelegate> delegate;

/**
 *  设置导航条高
 */
@property (nonatomic, assign) CGFloat headViewHeight;
/**
 *  设置导航条文字颜色
 */
@property (nonatomic, copy) UIColor *headViewTextLabelColor;
/**
 *  设置导航条下滑线颜色
 */
@property (nonatomic, copy) UIColor *headViewLinelColor;

@end
