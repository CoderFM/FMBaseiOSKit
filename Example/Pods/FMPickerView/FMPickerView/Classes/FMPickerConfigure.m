//
//  FMPickerConfigure.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMPickerConfigure.h"

@implementation FMPickerConfigure

+ (instancetype)defaultConfigure{
    static FMPickerConfigure *_defaultConfigure;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FMPickerConfigure *con = [[self alloc] init];
        
        con.bottomHeight = 49;
        con.topHeight = 40;
        con.pickerHeight = 300;
        
        con.bgBlackAlpha = 0.7;
        
        con.sureBtnWidth = 60;
        con.closeBtnWidth = 60;
        
        con.hiddenRemovePicker = YES;
        
        con.pickerDataRowHeight = 40;
        
        _defaultConfigure = con;
    });
    return _defaultConfigure;
}

@end
