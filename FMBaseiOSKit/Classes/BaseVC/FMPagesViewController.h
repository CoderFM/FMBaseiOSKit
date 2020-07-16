//
//  FMPagesViewController.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/16.
//

#import "FMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class FMNavBtnsView;
///可以是view和vc混合的多page页面
@interface FMPagesViewController : FMBaseViewController<UIScrollViewDelegate>

@property(nonatomic, weak)FMNavBtnsView *pageNavView;
@property(nonatomic, weak)UIScrollView *scrollView;

/// 可以是vc  也可以是view
- (void)createSubPages:(NSArray *)pages;

@end

NS_ASSUME_NONNULL_END
