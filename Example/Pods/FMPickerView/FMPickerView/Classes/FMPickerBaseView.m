//
//  FMPickerBaseView.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMPickerBaseView.h"
#import "FMPickerConfigure.h"

UIWindow *FMPickerGetCurrentWindow(){
    if (@available(iOS 13.0, *)) {
        UIWindowScene *windowScene;
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                windowScene = (UIWindowScene *)scene;
            }
        }
        UIWindow *showWindow;
        for (UIWindow *window in windowScene.windows) {
            if (!window.hidden && ![window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                showWindow = window;
                break;
            }
        }
        return showWindow;
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

@interface FMPickerBaseView ()

@property(nonatomic, assign)BOOL isLayout;

@end

@implementation FMPickerBaseView

+ (instancetype)show{
    FMPickerBaseView *view = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.hidden = YES;
    [FMPickerGetCurrentWindow() addSubview:view];
    [view layoutSubviews];
    [view animationShow];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.configure = [FMPickerConfigure defaultConfigure];
        [self initUI];
    }
    return self;
}

- (instancetype)initWithConfigure:(FMPickerConfigure *)configure{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.configure = configure;
        [self initUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [self animationHidden];
    }
}

- (void)animationShow{
    self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.frame.size.height);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:self.configure.bgBlackAlpha];
    }];
}

- (void)animationHidden{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.frame.size.height);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.configure.hiddenRemovePicker) {
            [self removeFromSuperview];
        }
    }];
}

- (void)sureBtnClick:(UIButton *)sender{
    [self animationHidden];
}

- (void)initUI{
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:self.configure.bgBlackAlpha];
    
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        self.contentView = view;
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.topView = view;
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.pickerContentView = view;
    }
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.bottomView = view;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"标题";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [self.topView addSubview:label];
        self.titleLabel = label;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
        self.sureBtn = btn;
    }
    {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(animationHidden) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
        self.closeBtn = btn;
    }
}

- (void)updateWithConfigure:(FMPickerConfigure *)configure{
    self.configure = configure;
    if (self.configure.configurePicker) {
        self.configure.configurePicker(self);
    }
    self.isLayout = NO;
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.isLayout) {
        if (self.configure.layoutCustom) {
            self.configure.layoutCustom(self);
            self.isLayout = YES;
            return;
        }
        
        CGFloat selfWidth = self.bounds.size.width;
        CGFloat selfHeight = self.bounds.size.height;
        
        self.contentView.frame = CGRectMake(0, selfHeight - (self.configure.topHeight + self.configure.pickerHeight + self.configure.bottomHeight), selfWidth,(self.configure.topHeight + self.configure.pickerHeight + self.configure.bottomHeight));
        self.topView.frame = CGRectMake(0, 0, selfWidth, self.configure.topHeight);
        self.pickerContentView.frame = CGRectMake(0, self.configure.topHeight, selfWidth, self.configure.pickerHeight);
        self.bottomView.frame = CGRectMake(0, self.configure.topHeight + self.configure.pickerHeight, selfWidth, self.configure.bottomHeight);
        
        
        self.sureBtn.frame = CGRectMake(selfWidth - self.configure.sureBtnWidth, 0, self.configure.sureBtnWidth, self.configure.topHeight);
        self.closeBtn.frame = CGRectMake(0, 0, self.configure.closeBtnWidth, self.configure.topHeight);
        self.titleLabel.frame = CGRectMake(self.configure.sureBtnWidth, 0, selfWidth - self.configure.closeBtnWidth - self.configure.sureBtnWidth, self.configure.topHeight);
        
        self.isLayout = YES;
    }
}

@end
