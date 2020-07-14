//
//  FMNavBtnsView.h
//  LiangXinApp
//
//  Created by 郑桂华 on 2020/3/24.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMNavBtnsLineAnimation) {
    ///没有动画
    FMNavBtnsLineAnimationNone,
    ///根据滚动进度来的
    FMNavBtnsLineAnimationProgress,
    ///直接移动至最终位置
    FMNavBtnsLineAnimationNormal,
    ///先放大再缩小至最终位置
    FMNavBtnsLineAnimationZoom,
};

@interface FMNavBtnsView : UIView
///创建好的所有buttons
@property(nonatomic, readonly)NSArray<UIButton *> *buttons;
///是否可以滚动   YES将插入ScrollView上
@property(nonatomic, assign)BOOL canScroll;
/// 可以滚动时  标签文字间距
@property(nonatomic, assign)CGFloat itemMargin;
///是否有底部线条
@property(nonatomic, assign)BOOL hasBottomLine;
///底部线动画方式  默认FMNavBtnsLineAnimationNormal
@property(nonatomic, assign)FMNavBtnsLineAnimation lineAnimation;
/// 动画市场 默认0.3
@property(nonatomic, assign)NSTimeInterval duration;
///底部的线条指示器
@property(nonatomic, weak)UIView *lineView;
///底部线的大小
@property(nonatomic, assign)CGSize lineSize;
///底部线距离底部的间距
@property(nonatomic, assign)CGFloat lineBottomMargin;
///底部线与文字垂直对齐间距 仅在FMNavBtnsLineStyleAuto生效
@property(nonatomic, assign)CGFloat lineTitleMargin;
///主要使用左右边距  来调节边上的空隙
@property(nonatomic, assign)UIEdgeInsets inset;
///创建按钮时  可配置样式
@property(nonatomic, copy)void(^configurationBtn)(UIButton *btn, id title, NSInteger index);
///是否可以选中该按钮
@property(nonatomic, copy)BOOL(^canSelectBtn)(UIButton *btn);
///显示的标签文本  可以支持文本与富文本穿插
@property(nonatomic, copy)NSArray *titles;
///选中的index
@property(nonatomic, assign)NSInteger selected;
///选中的按钮
@property(nonatomic, weak)UIButton *selectBtn;
///按钮选中的颜色   默认Orange
@property(nonatomic, strong)UIColor *selectColor;
///按钮正常的颜色  默认black
@property(nonatomic, strong)UIColor *normalColor;
///按钮选中的字体大小  默认16
@property(nonatomic, strong)UIFont *selectFont;
///按钮正常的字体大小  默认16
@property(nonatomic, strong)UIFont *normalFont;
///选中的tag回调
@property(nonatomic, copy)void(^clickBlock)(NSInteger tag);
///选中的sender回调
@property(nonatomic, copy)void(^clickSenderBlock)(UIButton *sender);
///配置下方线条
@property(nonatomic, copy)void(^configureLineView)(UIView *line);
+ (instancetype)viewWithBtns:(NSArray *)titles select:(NSInteger)select;
- (void)reCreateBtns;
- (void)updateLine;
- (void)scrollNextProgress:(CGFloat)progress;
- (void)scrollPrevProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
