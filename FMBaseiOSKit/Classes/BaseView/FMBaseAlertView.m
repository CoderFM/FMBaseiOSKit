//
//  FMBaseAlertView.m
//  FMBaseKit
//
//  Created by 郑桂华 on 2020/6/15.
//

#import "FMBaseAlertView.h"
#import <Masonry/Masonry.h>

@implementation FMBaseAlertView

- (CGAffineTransform)animationTransform{
    return CGAffineTransformMakeScale(0.1, 0.1);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.animationDamping = 0.7;
        self.animationVelocity = 20;
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(400);
        }];
    }
    return self;
}

- (void)animationHidden:(void (^)(void))complete{
    self.hidden = YES;
    !complete?:complete();
}

@end
