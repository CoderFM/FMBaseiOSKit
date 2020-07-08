//
//  FMDatePickerView.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMDatePickerView.h"

@implementation FMDatePickerView

+ (instancetype)showTitle:(NSString *)title dateMode:(UIDatePickerMode)mode date:(NSDate *)date maxDate:(NSDate *)maxDate minDate:(NSDate *)minDate complete:(FMDatePickerSureBlock)sureBlock{
    FMDatePickerView *show = [self show];
    show.titleLabel.text = title;
    show.datePicker.datePickerMode = mode;
    show.datePicker.maximumDate = maxDate;
    show.datePicker.minimumDate = minDate;
    show.datePicker.date = date;
    show.sureBlock = sureBlock;
    return show;
}

- (void)initUI{
    [super initUI];
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    picker.datePickerMode = UIDatePickerModeDate;
    [self.pickerContentView addSubview:picker];
    self.datePicker = picker;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.datePicker.frame = self.pickerContentView.bounds;
}

- (void)sureBtnClick:(UIButton *)sender{
    if (self.sureBlock) {
        self.sureBlock(self.datePicker.date);
    }
    [super sureBtnClick:sender];
}

@end
