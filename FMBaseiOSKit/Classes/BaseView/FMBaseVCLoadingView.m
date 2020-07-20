//
//  FMBaseVCLoadingView.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/17.
//

#import "FMBaseVCLoadingView.h"
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"

@interface FMBaseVCLoadingView ()

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)CAGradientLayer *gradientLayer;

@property(nonatomic, copy)NSString *animationKey;

@end

@implementation FMBaseVCLoadingView

- (void)dealloc{
    NSLog(@"FMBaseVCLoadingView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:40];
        label.textColor = [UIColor colorWithHex:0xe5e5e5];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = name;
        [label sizeToFit];
        self.nameLabel = label;
        
        CAGradientLayer *layer = [[CAGradientLayer alloc] init];
        layer.colors = @[(__bridge id)[UIColor lightGrayColor].CGColor, (__bridge id)[UIColor grayColor].CGColor, (__bridge id)[UIColor grayColor].CGColor, (__bridge id)[UIColor lightGrayColor].CGColor];
        layer.locations = @[@(-0.4), @(-0.39), @(-0.24), @(-0.23)];
        layer.startPoint = CGPointMake(0.0, 0.6);
        layer.endPoint = CGPointMake(1.0, 0.4);
        self.gradientLayer = layer;
        
        self.animationKey = @"FMBaseVCLoadingViewAnimationKey";
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.mask = self.nameLabel.layer;
    self.nameLabel.center = CGPointMake(self.center.x, self.center.y - 100);
}

- (void)setHidden:(BOOL)hidden{
    [super setHidden:hidden];
    if (hidden) {
        [self.gradientLayer removeAnimationForKey:self.animationKey];
    } else {
        CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
        gradientAnimation.fromValue = @[@(-0.8),@(-0.79),@(-0.64),@(-0.63)];
        gradientAnimation.toValue = @[@1.5,@1.51,@1.76,@1.77];
        gradientAnimation.duration = 2.0;
        gradientAnimation.repeatCount = MAXFLOAT;
        [self.gradientLayer addAnimation:gradientAnimation forKey:self.animationKey];
    }
}

- (void)didMoveToWindow{
    [super didMoveToWindow];
    [self.layer addSublayer:self.gradientLayer];
}

@end
