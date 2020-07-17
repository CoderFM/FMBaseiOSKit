//
//  FMBaseSheetLayoutView.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/17.
//

#import "FMBaseSheetView.h"

NS_ASSUME_NONNULL_BEGIN
@class FMLayoutView;
@interface FMBaseSheetLayoutView : FMBaseSheetView

@property(nonatomic, weak)FMLayoutView *layoutView;

@end

NS_ASSUME_NONNULL_END
