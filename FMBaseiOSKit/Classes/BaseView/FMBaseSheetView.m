

#import "FMBaseSheetView.h"
#import "UITableView+FMExtension.h"
#import "FMBaseTableView.h"
#import "FMConfig.h"
#import <Masonry/Masonry.h>
#import "UIColor+FMExtension.h"

@interface FMBaseSheetView ()

@end

@implementation FMBaseSheetView

- (CGSize)contentViewSize{
    switch (self.type) {
        case FMSheetTypeBottom:
        case FMSheetTypeTop:
            return CGSizeMake([FMConfig config].screenWidth, [FMConfig config].screenHeight * 0.5);
        case FMSheetTypeLeft:
        case FMSheetTypeRight:
            return CGSizeMake([FMConfig config].screenWidth * 0.5, [FMConfig config].screenHeight);
        default:
            break;
    }
}

- (CGAffineTransform)animationTransform{
    switch (self.type) {
        case FMSheetTypeBottom:
            return CGAffineTransformMakeTranslation(0, self.contentViewSize.height);
        case FMSheetTypeTop:
            return CGAffineTransformMakeTranslation(0, -self.contentViewSize.height);
        case FMSheetTypeLeft:
            return CGAffineTransformMakeTranslation(-self.contentViewSize.width, 0);
        case FMSheetTypeRight:
            return CGAffineTransformMakeTranslation(self.contentViewSize.width, 0);
    }
}

- (Class)cellClass{
    return [UITableViewCell class];
}

- (void)setType:(FMSheetType)type{
    _type = type;
    switch (type) {
        case FMSheetTypeBottom:
        {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(0);
                make.height.mas_equalTo(self.contentViewSize.height);
            }];
        }
            break;
        case FMSheetTypeTop:
        {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(0);
                make.height.mas_equalTo(self.contentViewSize.height);
            }];
        }
            break;
        case FMSheetTypeLeft:
        {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(self.contentViewSize.width);
            }];
        }
            break;
        case FMSheetTypeRight:
        {
            [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.top.mas_equalTo(0);
                make.width.mas_equalTo(self.contentViewSize.width);
            }];
        }
            break;
        default:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo([FMConfig config].screenHeight * 0.5);
        }];
        self.type = FMSheetTypeBottom;
        self.animationDamping = 1;
//        CAShapeLayer *layer = [CAShapeLayer layer];
//        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
//        layer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, [FMConfig config].screenWidth, [FMConfig config].screenHeight) byRoundingCorners:corner cornerRadii:CGSizeMake(BaseSize(16), BaseSize(16))].CGPath;
//        self.contentView.layer.mask = layer;
         
        FMBaseTableView *tableView = [[FMBaseTableView alloc] init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:self.cellClass forCellReuseIdentifier:NSStringFromClass(self.cellClass)];
        tableView.showEmptyView = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.contentView addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(56);
        }];
        self.tableView = tableView;
        
        UIView *line = [[UIView alloc] init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(tableView.mas_top);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"标题";
        title.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(0);
            make.height.mas_equalTo(56);
        }];
        self.titleLabel = title;
        
        UIButton *close = [[UIButton alloc] init];
        close.titleLabel.font = [UIFont systemFontOfSize:14];
        [close setTitleColor:[UIColor colorWithHex:0x999999] forState:UIControlStateNormal];
        [close setImage:[UIImage imageNamed:@"base_close"] forState:UIControlStateNormal];
        [self.contentView addSubview:close];
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.height.width.mas_equalTo(56);
        }];
        [close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn = close;
    }
    return self;
}

- (void)closeClick{
    [self removeFromSuperview];
}

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellClass)];
    [self configurationCell:cell indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
