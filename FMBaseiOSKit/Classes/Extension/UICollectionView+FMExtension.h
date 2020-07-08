

#import <UIKit/UIKit.h>
#import "FMNoneDataView.h"

NS_ASSUME_NONNULL_BEGIN
@interface UICollectionView (FMExtension)
@property(nonatomic, assign)BOOL showEmptyView;
@property(nonatomic, weak)FMNoneDataView *nonDataView;
@end

NS_ASSUME_NONNULL_END
