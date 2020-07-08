

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBasePopupView : UIView

@property(nonatomic, assign)CGFloat showAlpha;

@property(nonatomic, assign)CGFloat animationDuration;
@property(nonatomic, assign)CGFloat animationDamping;
@property(nonatomic, assign)CGFloat animationVelocity;
@property(nonatomic, assign)UIViewAnimationOptions animationOptions;

@property(nonatomic, weak)UIView *contentView;
@property(nonatomic, assign)BOOL hiddenSaveSelf;
@property(nonatomic, assign)CGAffineTransform animationTransform;
+ (instancetype)showToView:(UIView *)view;
- (void)animationShow;
- (void)animationHidden:(void(^)(void))complete;
@end

NS_ASSUME_NONNULL_END
