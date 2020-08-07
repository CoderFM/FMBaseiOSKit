//
//  FMTeslaPageModel.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/7.
//

#import "FMTeslaPageModel.h"

@implementation FMTeslaPageModel

- (UIScrollView *)customCreateScrollViewWithShareHeight:(CGFloat)shareHeight{
    return nil;
}
- (void)didCreateScrollView:(UIScrollView *)scrollView{
    self.scrollView = scrollView;
}
- (void)didShow{
    
}

@end
