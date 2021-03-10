//
//  FMDatePickerView.h
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMPickerBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FMDatePickerSureBlock)(NSDate *date);

@interface FMDatePickerView : FMPickerBaseView

@property(nonatomic, weak)UIDatePicker *datePicker;

@property(nonatomic, copy)FMDatePickerSureBlock sureBlock;

+ (instancetype)showTitle:(NSString *)title dateMode:(UIDatePickerMode)mode date:(NSDate  * _Nullable )date maxDate:(NSDate * _Nullable)maxDate minDate:(NSDate * _Nullable)minDate complete:(FMDatePickerSureBlock)sureBlock;

- (void)showTitle:(NSString *)title dateMode:(UIDatePickerMode)mode date:(NSDate  * _Nullable )date maxDate:(NSDate * _Nullable)maxDate minDate:(NSDate * _Nullable)minDate complete:(FMDatePickerSureBlock)sureBlock;

@end

NS_ASSUME_NONNULL_END
