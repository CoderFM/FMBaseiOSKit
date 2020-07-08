//
//  FMPickerBaseView.h
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

extern UIWindow * _Nullable FMPickerGetCurrentWindow();

NS_ASSUME_NONNULL_BEGIN
@class FMPickerConfigure;
@interface FMPickerBaseView : UIView

@property(nonatomic, strong)FMPickerConfigure *configure;

@property(nonatomic, weak)UIView *contentView;

@property(nonatomic, weak)UIView *topView;
@property(nonatomic, weak)UIView *bottomView;
@property(nonatomic, weak)UIView *pickerContentView;

@property(nonatomic, weak)UILabel *titleLabel;
@property(nonatomic, weak)UIButton *closeBtn;
@property(nonatomic, weak)UIButton *sureBtn;

- (instancetype)initWithConfigure:(FMPickerConfigure *)configure;
- (void)initUI;
- (void)updateWithConfigure:(FMPickerConfigure *)configure;
- (void)animationShow;
- (void)animationHidden;
- (void)sureBtnClick:(UIButton *)sender;

+ (instancetype)show;

@end

NS_ASSUME_NONNULL_END
