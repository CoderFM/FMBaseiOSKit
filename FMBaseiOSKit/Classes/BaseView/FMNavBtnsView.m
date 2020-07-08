//
//  FMNavBtnsView.m
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/24.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "FMNavBtnsView.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, FMNavBtnsLineStyle) {
    ///自动计算大小
    FMNavBtnsLineStyleAuto,
    /// 固定大小
    FMNavBtnsLineStyleFixed,
};

@interface FMNavBtnsView ()

@property(nonatomic, strong)NSMutableArray *btns;

@property(nonatomic, weak)UIScrollView *scrollView;
@property(nonatomic, weak)UIView *scrollContent;

@property(nonatomic, assign)BOOL lineLayouted;

/// 底部线条宽度方式
@property(nonatomic, assign, readonly)FMNavBtnsLineStyle lineStyle;

@end

@implementation FMNavBtnsView

- (FMNavBtnsLineStyle)lineStyle{
    return self.canScroll ? FMNavBtnsLineStyleAuto : FMNavBtnsLineStyleFixed;
}

- (NSArray *)buttons{
    return self.btns;
}

+ (instancetype)viewWithBtns:(NSArray *)titles select:(NSInteger)select{
    FMNavBtnsView *btns = [[self alloc] init];
    btns.titles = titles;
    btns.selected = select;
    [btns reCreateBtns];
    return btns;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hasBottomLine = YES;
        self.lineSize = CGSizeMake(20, 3);
        self.btns = [NSMutableArray array];
        self.duration = 0.3;
        self.lineAnimation = FMNavBtnsLineAnimationNormal;
        self.normalColor = [UIColor blackColor];
        self.selectColor = [UIColor orangeColor];
        self.normalFont = [UIFont systemFontOfSize:16];
        self.selectFont = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)setSelectBtn:(UIButton *)selectBtn{
    _selectBtn.selected = NO;
    _selectBtn = selectBtn;
    _selectBtn.selected = YES;
}

- (void)setSelected:(NSInteger)selected{
    if (_selected == selected) {
        return;
    }
    _selected = selected;
    if (selected > 0) {
        if (self.canScroll) {
            self.selectBtn = [self.scrollContent viewWithTag:selected];
        } else {
            self.selectBtn = [self viewWithTag:selected];
        }
    }
    [self updateLine];
}

- (void)setTitles:(NSArray *)titles{
    if ([_titles isEqualToArray:titles]) {
        return;
    }
    _titles = titles;
    [self reCreateBtns];
}

- (void)prepareReCreate{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    if (self.canScroll) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        self.scrollView = scrollView;
        
        UIView *view = [[UIView alloc] init];
        [self.scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
            make.height.mas_equalTo(self.scrollView.mas_height);
        }];
        self.scrollContent = view;
    } else {
        
    }
    
    UIView *line = [[UIView alloc] init];
    line.hidden = YES;
    line.backgroundColor = [UIColor orangeColor];
    !self.configureLineView?:self.configureLineView(line);
    if (self.canScroll) {
        [self.scrollContent addSubview:line];
    } else {
        [self addSubview:line];
    }
    self.lineView = line;
    self.btns = [NSMutableArray array];
}

- (void)reCreateBtns{
    [self prepareReCreate];
    if (self.titles && self.titles.count > 0) {
        if (self.selected > self.titles.count - 1) {
            self.selected = 0;
        }
        if (self.canScroll) {
            if (![self.subviews containsObject:self.scrollView]) {
                [self addSubview:self.scrollView];
            }
            [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(0);
            }];
            CGFloat selectMaxX = 0;
            UIButton *left = nil;
            for (int i = 0; i < self.titles.count; i++) {
                UIButton *btn = [self createBtnIndex:i];
                [self.scrollContent addSubview:btn];
                CGFloat width =[self titleWidthWithIndex:i forBtn:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (left) {
                        make.left.mas_equalTo(left.mas_right);
                    } else {
                        make.left.mas_equalTo(0);
                    }
                    make.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(width + self.itemMargin);
                }];
                left = btn;
                if (i == self.selected) {
                    self.selectBtn = btn;
                }
                if (i <= self.selected) {
                    selectMaxX += width + self.itemMargin;
                }
                [self.btns addObject:btn];
            }
            if (left) {
                [left mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(0);
                }];
            }
            [self updateLine];
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (selectMaxX - self.bounds.size.width > 0) {
                    [weakSelf.scrollView setContentOffset:CGPointMake(selectMaxX - weakSelf.bounds.size.width, 0)];
                }
            });
        } else {
            UIButton *left = nil;
            CGFloat multiplied = 1 / (self.titles.count * 1.0);
            for (int i = 0; i < self.titles.count; i++) {
                UIButton *btn = [self createBtnIndex:i];
                [self addSubview:btn];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (left) {
                        make.left.mas_equalTo(left.mas_right);
                    } else {
                        make.left.mas_equalTo(0);
                    }
                    make.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(self.mas_width).multipliedBy(multiplied);
                }];
                left = btn;
                if (i == self.selected) {
                    self.selectBtn = btn;
                }
                [self.btns addObject:btn];
            }
            [self updateLine];
        }
    }
}

- (UIButton *)createBtnIndex:(NSInteger)index {
    id title = self.titles[index];
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = index;
    if (self.configurationBtn) {
        self.configurationBtn(btn, title, index);
    } else {
        if ([title isKindOfClass:[NSString class]]) {
            [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:self.normalFont, NSForegroundColorAttributeName:self.normalColor}] forState:UIControlStateNormal];
            [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:self.selectFont, NSForegroundColorAttributeName:self.selectColor}] forState:UIControlStateSelected];
        } else if ([title isKindOfClass:[NSAttributedString class]]) {
            {
                NSMutableAttributedString *attr = [title mutableCopy];
                if (self.normalFont) {
                    [attr addAttribute:NSFontAttributeName value:self.normalFont range:NSMakeRange(0, attr.length)];
                }
                if (self.normalColor) {
                    [attr addAttribute:NSForegroundColorAttributeName value:self.normalColor range:NSMakeRange(0, attr.length)];
                }
                [btn setAttributedTitle:attr forState:UIControlStateNormal];
            }
            {
                NSMutableAttributedString *attr = [title mutableCopy];
                if (self.selectFont) {
                    [attr addAttribute:NSFontAttributeName value:self.selectFont range:NSMakeRange(0, attr.length)];
                }
                if (self.selectColor) {
                    [attr addAttribute:NSForegroundColorAttributeName value:self.selectColor range:NSMakeRange(0, attr.length)];
                }
                [btn setAttributedTitle:attr forState:UIControlStateSelected];
            }
        }
    }
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (CGFloat)titleWidthWithIndex:(NSInteger)index forBtn:(UIButton *)btn{
    id title = self.titles[index];
    if ([title isKindOfClass:[NSString class]]) {
        return [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil].size.width;
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        return [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
    }
    return 0;
}

- (void)btnClick:(UIButton *)sender{
    !self.clickBlock?:self.clickBlock(sender.tag);
    !self.clickSenderBlock?:self.clickSenderBlock(sender);
    if (self.canSelectBtn) {
        if (self.canSelectBtn(sender)) {
            self.selectBtn = sender;
            self.selected = sender.tag;
        }
    } else {
        self.selectBtn = sender;
        self.selected = sender.tag;
    }
    [self updateLine];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.lineLayouted) {
        if (self.canScroll) {
            [self.scrollContent layoutIfNeeded];
        }
        [self updateLine];
    }
}

- (void)updateLine{
    if (self.selectBtn == nil) {
        return;
    }
    if (self.hasBottomLine) {
        if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
            self.lineView.hidden = YES;
            return;
        }
        self.lineView.hidden = NO;
        if (self.canScroll) {
            CGRect finalFrame = [self caculateLineFinalFrame];
            if (CGSizeEqualToSize(self.lineView.frame.size, CGSizeZero)) {
                self.lineView.frame = finalFrame;
                self.lineLayouted = YES;
            } else {
                [self lineUpdateAnimationFinalFrame:finalFrame];
                self.lineLayouted = YES;
            }
        } else {
            CGRect finalFrame = [self caculateLineFinalFrame];
            if (CGSizeEqualToSize(self.lineView.frame.size, CGSizeZero)) {
                self.lineView.frame = finalFrame;
                self.lineLayouted = YES;
            } else {
                [self lineUpdateAnimationFinalFrame:finalFrame];
                self.lineLayouted = YES;
            }
        }
    } else {
        self.lineView.hidden = YES;
    }
}

- (CGRect)caculateLineFinalFrame{
    if (self.lineStyle == FMNavBtnsLineStyleAuto) {
        CGFloat x = CGRectGetMinX(self.selectBtn.frame) + self.itemMargin*0.5 - self.lineTitleMargin;
        CGFloat y = CGRectGetHeight(self.frame) - self.lineSize.height - self.lineBottomMargin;
        CGFloat width = CGRectGetWidth(self.selectBtn.frame) - self.itemMargin - self.lineTitleMargin * 2;
        CGRect frame = CGRectMake(x, y, width, self.lineSize.height);
        return frame;
    } else {
        CGFloat x = CGRectGetMidX(self.selectBtn.frame) - self.lineSize.width * 0.5;
        CGFloat y = CGRectGetHeight(self.frame) - self.lineSize.height - self.lineBottomMargin;
        CGFloat width = self.lineSize.width;
        CGRect finalFrame = CGRectMake(x, y, width, self.lineSize.height);
        return finalFrame;
    }
}

- (void)lineUpdateAnimationFinalFrame:(CGRect)finalFrame{
    switch (self.lineAnimation) {
        case FMNavBtnsLineAnimationNone:
        {
            self.lineView.frame = finalFrame;
        }
            break;
        case FMNavBtnsLineAnimationNormal:
        {
            [UIView animateWithDuration:self.duration animations:^{
                self.lineView.frame = finalFrame;
            }];
        }
            break;
        case FMNavBtnsLineAnimationZoom:
        {
            CGFloat finalMaxX = MAX(CGRectGetMaxX(self.lineView.frame), CGRectGetMaxX(finalFrame));
            CGFloat finalMinX = MIN(CGRectGetMinX(self.lineView.frame), CGRectGetMinX(finalFrame));
            CGRect middleFrame = self.lineView.frame;
            middleFrame.size.width = finalMaxX - finalMinX;
            middleFrame.origin.x = finalMinX;
            [UIView animateWithDuration:self.duration * 0.5 animations:^{
                self.lineView.frame = middleFrame;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:self.duration * 0.5 animations:^{
                    self.lineView.frame = finalFrame;
                }];
            });
        }
            break;
        default:
            break;
    }
}

@end
