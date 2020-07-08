
#import "FMNoneDataView.h"
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"
#import "UIButton+FMExtension.h"

@implementation FMNoneDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"list_none_icon"];
    [self addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(@(-150));
    }];
    self.nonImageView = iv;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂无内容 ^.^";
    label.textColor = [UIColor colorWithHex:0xcccccc];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iv);
        make.top.equalTo(iv.mas_bottom).offset(15);
    }];
    self.nonTextLabel = label;

    UIButton *button = [UIButton buttonWithTitle:@"" font:[UIFont systemFontOfSize:16] color:[UIColor blackColor]];
    [button setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iv);
        make.top.equalTo(label.mas_bottom).offset(60);
        make.width.mas_equalTo(245);
        make.height.mas_equalTo(50);
    }];
    button.hidden = YES;
    self.nonButton = button ;
}

- (void)setImage:(UIImage *)image text:(NSString *)text{
    if (image) {
        self.nonImageView.image = image;
    }
    self.nonTextLabel.text = text;
}

- (void)imageOffsetCenterY:(CGFloat)offsetY{
    [self.nonImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(offsetY);
    }];
}

@end
