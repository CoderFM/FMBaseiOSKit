

#import "UICollectionView+FMExtension.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static char nonDataViewKey;
static char showEmptyViewKey;
static char nonDataViewClassKey;

@implementation UICollectionView (FMExtension)

+ (void)load{
    {
        Method m1 = class_getInstanceMethod(self, @selector(reloadData));
        Method m2 = class_getInstanceMethod(self, @selector(_baseReloadData));
        method_exchangeImplementations(m1, m2);
    }
    {
        Method m1 = class_getInstanceMethod(self, @selector(initWithFrame:collectionViewLayout:));
        Method m2 = class_getInstanceMethod(self, @selector(_baseInitWithFrame:collectionViewLayout:));
        method_exchangeImplementations(m1, m2);
    }
}

- (instancetype)_baseInitWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    UICollectionView *coll = [self _baseInitWithFrame:frame collectionViewLayout:layout];
    coll.showEmptyView = YES;
    return coll;
}

- (void)_baseReloadData{
    [self _baseReloadData];
    if ([self isKindOfClass:[UICollectionView class]]) {
        if (self.showEmptyView) {
            BOOL showEmpty = YES;
            for (int i = 0; i < self.numberOfSections; i++) {
                NSInteger rows = [self numberOfItemsInSection:i];
                if (rows > 0) {
                    showEmpty = NO;
                    break;
                }
            }
            self.nonDataView.hidden = !showEmpty;
        }
    }
}

- (BOOL)showEmptyView{
    NSNumber *empty = objc_getAssociatedObject(self, &showEmptyViewKey);
    if (empty == nil) {
        empty = @(YES);
        self.showEmptyView = empty;
    }
    return [empty boolValue];
}

- (void)setShowEmptyView:(BOOL)showEmptyView{
    objc_setAssociatedObject(self, &showEmptyViewKey, @(showEmptyView), OBJC_ASSOCIATION_RETAIN);
}

- (FMNoneDataView *)fmNonDataView{
    if ([self.nonDataView isKindOfClass:[FMNoneDataView class]]) {
        return (FMNoneDataView *)self.nonDataView;
    }
    return nil;
}

- (UIView *)nonDataView
{
    UIView *nonData = objc_getAssociatedObject(self, &nonDataViewKey);
    if (nonData == nil) {
        nonData = [[[self nonDataViewClass] alloc] init];
        nonData.hidden = YES;
        [self insertSubview:nonData atIndex:0];
        [nonData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);
        }];
        [self setNonDataView:nonData];
    }
    return nonData;
}
- (void)setNonDataView:(UIView *)nonDataView
{
    UIView *nonData = objc_getAssociatedObject(self, &nonDataViewKey);
    if (nonData) {
        [nonData removeFromSuperview];
    }
    objc_setAssociatedObject(self, &nonDataViewKey, nonDataView, OBJC_ASSOCIATION_RETAIN);
}

- (Class)nonDataViewClass{
    Class viewClass = objc_getAssociatedObject(self, &nonDataViewClassKey);
    if (!viewClass) {
        viewClass = [FMNoneDataView class];
        objc_setAssociatedObject(self, &nonDataViewClassKey, viewClass, OBJC_ASSOCIATION_RETAIN);
    }
    return viewClass;
}

- (void)setNonDataViewClass:(Class)nonDataViewClass{
    Class viewClass = objc_getAssociatedObject(self, &nonDataViewClassKey);
    if (viewClass != nonDataViewClass) {
        objc_setAssociatedObject(self, &nonDataViewClassKey, nonDataViewClass, OBJC_ASSOCIATION_RETAIN);
    }
}

@end
