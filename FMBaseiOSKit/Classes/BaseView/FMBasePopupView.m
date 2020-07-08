
#import "FMBasePopupView.h"

@implementation FMBasePopupView

+ (instancetype)showToView:(UIView *)view{
    FMBasePopupView *pop = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view addSubview:pop];
    pop.hidden = YES;
    [pop animationShow];
    return pop;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showAlpha = 0.6;
        self.animationDuration = 0.25;
        self.animationDamping = 0.8;
        self.animationVelocity = 20;
        self.animationOptions = UIViewAnimationOptionCurveEaseIn;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:self.showAlpha];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        self.contentView = view;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        
    } else {
        [self animationHidden:^{
            if (!self.hiddenSaveSelf) {
                [self removeFromSuperview];
            }
        }];
    }
}

- (void)animationShow{
    self.contentView.transform = self.animationTransform;
    self.backgroundColor = [UIColor clearColor];
    self.hidden = NO;
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDamping initialSpringVelocity:self.animationVelocity options:self.animationOptions animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:self.showAlpha];
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)animationHidden:(void (^)(void))complete{
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:self.animationDamping initialSpringVelocity:self.animationVelocity options:self.animationOptions animations:^{
        self.contentView.transform = self.animationTransform;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        !complete?:complete();
    }];
}

@end
