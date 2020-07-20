

#import <UIKit/UIKit.h>
#import "FMNoneDataView.h"

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (FMExtension)
@property(nonatomic, weak)Class nonDataViewClass;
@property(nonatomic, assign)BOOL showEmptyView;
@property(nonatomic, weak)UIView *nonDataView;
@property(nonatomic, weak, readonly)FMNoneDataView * __nullable fmNonDataView;
@end

NS_ASSUME_NONNULL_END
