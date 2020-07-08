

#import "UIBarButtonItem+FMExtension.h"
#import "FMConfig.h"
#import "UIView+FMExtension.h"
#import <Masonry/Masonry.h>

@implementation UIBarButtonItem (FMExtension)

- (instancetype)setTextBlack{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    return self;
}

- (instancetype)setTextColor:(UIColor *)color{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    return self;
}

+ (instancetype)itemWithImage:(nullable UIImage *)image style:(UIBarButtonItemStyle)style target:(nullable id)target action:(nullable SEL)action congigurationTipLabel:(void(^)(UILabel *))congiguration{

    UIButton *btn = [[UIButton alloc] init];
    btn.bounds = CGRectMake(0, 0, [FMConfig config].navHeight, [FMConfig config].navHeight);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    UILabel *label = [[UILabel alloc] init];
    label.hidden = YES;
    [label setCornerRadius:4];
    label.backgroundColor = [UIColor redColor];
    [btn addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.top.mas_equalTo(0);
        make.height.width.mas_equalTo(8);
    }];
    if (congiguration) {
        congiguration(label);
    }
    UIBarButtonItem *item = [[self alloc] initWithCustomView:btn];
    item.width = btn.bounds.size.width;
    return item;
}

+ (instancetype)itemWithAttributedString:(NSAttributedString *)attributeString target:(nullable id)target action:(nullable SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setAttributedTitle:attributeString forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[self alloc] initWithCustomView:btn];
    return item;
}


@end
