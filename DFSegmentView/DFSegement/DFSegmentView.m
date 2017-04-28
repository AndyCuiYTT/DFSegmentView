//
//  DFSegmentView.m
//  SinoCommunity
//
//  Created by df on 2017/4/28.
//  Copyright © 2017年 df. All rights reserved.
//

#import "DFSegmentView.h"
#import "DFSegmentHeadView.h"
#import "DFSegmentBaseController.h"

@interface DFSegmentView ()<DFSegmentHeadViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) DFSegmentHeadView *dfSegmentHead;

@property (nonatomic, strong) UIScrollView *scrollBg;

@end

@implementation DFSegmentView

-(void)setDelegate:(id<DFSegmentViewDelegate>)delegate {
    _delegate = delegate;
    [self prepareLayout];
}

- (void)prepareLayout {
    
    self.dfSegmentHead = [[DFSegmentHeadView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.dfSegmentHead];
    
    [self.dfSegmentHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    self.dfSegmentHead.delegate = self;
    
    UIScrollView *scrollBg = [UIScrollView new];
    
    self.scrollBg = scrollBg;
    
    scrollBg.delegate = self;
    
    [self addSubview:scrollBg];
    
    scrollBg.pagingEnabled = YES;
    scrollBg.bounces = NO;
    scrollBg.showsHorizontalScrollIndicator = NO;
    
    [scrollBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.dfSegmentHead.mas_bottom);
    }];
    
    UIView *container = [UIView new];
    
    [scrollBg addSubview:container];
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollBg);
        make.height.equalTo(scrollBg);
    }];
    
    UIView *lastView = nil;
    for (int i = 0 ; i < [[self.delegate titlesForDFSegmentViewHeadView] count]; i++) {
        
//        DFSegmentBaseController *baseVC = [DFSegmentBaseController new];
        UIViewController *baseVC = [self.delegate subViewControllerWithIndex:i];
        
        [[self.delegate superViewController] addChildViewController:baseVC];
        
        [container addSubview:baseVC.view];
        
        [baseVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.top.equalTo(container);
            make.width.mas_equalTo(ScreenWidth);
        }];
        
        lastView = baseVC.view;
        
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lastView == nil) {
            
            make.right.equalTo(self.mas_right);
            
        }else {
            
            make.right.equalTo(lastView.mas_right);
        }
    }];
    
    if (container.subviews.count > 1) {
        
        [container.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    }


}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self.dfSegmentHead setSelectItemWithIndex:scrollView.contentOffset.x / ScreenWidth];
    
}

#pragma mark - HeadView Delegate

- (NSInteger)dfSegmentNumber {
    
    return [[self.delegate titlesForDFSegmentViewHeadView] count];
}

- (CGSize)dfSegmentItemSimeWithIndex:(NSInteger)index {
    
    NSString *str = [[self.delegate titlesForDFSegmentViewHeadView] objectAtIndex:index];
    
    UIFont * font = [UIFont systemFontOfSize:13];
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    return CGSizeMake(size.width + 25, 30);
}

- (NSString *)textForCellWithIndex:(NSInteger)index {
    
    return [[self.delegate titlesForDFSegmentViewHeadView] objectAtIndex:index];
}

- (void)selectWithIndex:(NSInteger)index {
    
    [self.scrollBg setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:NO];

}

#pragma mark - property Set Mothed

- (void)setHeadViewHeight:(CGFloat)headViewHeight {
    
    _headViewHeight = headViewHeight;
    
    [self.dfSegmentHead mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(headViewHeight);
    }];
}

- (void)setHeadViewTextLabelColor:(UIColor *)headViewTextLabelColor {
    
    _headViewTextLabelColor = headViewTextLabelColor;
    
    self.dfSegmentHead.textLabelColor = headViewTextLabelColor;
}

- (void)setHeadViewLinelColor:(UIColor *)headViewLinelColor {
    
    _headViewLinelColor = headViewLinelColor;
    
    self.dfSegmentHead.linelColor = headViewLinelColor;
}

@end
