//
//  FMTeslaPageModel.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTeslaPageModel : NSObject
@property(nonatomic, weak)UIScrollView *scrollView;
- (UIScrollView *)customCreateScrollViewWithShareHeight:(CGFloat)shareHeight;
- (void)didCreateScrollView:(UIScrollView *)scrollView;
- (void)didShow;
@end

NS_ASSUME_NONNULL_END
