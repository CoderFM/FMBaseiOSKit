//
//  FMPickerDataView.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMPickerDataView.h"
#import "FMPickerConfigure.h"

@interface FMPickerDataView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong)NSMutableDictionary<NSNumber *, NSNumber *> *selectRows;

@end

@implementation FMPickerDataView

- (NSInteger)components{
    if (self.linkageType == FMPickerLinkageTypeForbid) {
        return self.items.count;
    } else {
        return _components;
    }
}

#pragma mark ---- 联动显示 ----
+ (instancetype)showLinkageTitle:(NSString *)title components:(NSInteger)components plist:(NSString *)plistPath componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    NSArray *items = [NSArray arrayWithContentsOfFile:plistPath];
    return [self showLinkageTitle:title components:components items:items componentItems:componentItems showText:showText complete:sureBlock];
}

- (void)showLinkageTitle:(NSString *)title components:(NSInteger)components plist:(NSString *)plistPath componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    NSArray *items = [NSArray arrayWithContentsOfFile:plistPath];
    [self showLinkageTitle:title components:components items:items componentItems:componentItems showText:showText complete:sureBlock];
}


+ (instancetype)showLinkageTitle:(NSString *)title components:(NSInteger)components items:(NSArray *)items componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    return [self _showLinkageType:FMPickerLinkageTypeNormal title:title components:components items:items componentItems:componentItems showText:showText complete:sureBlock];
}

- (void)showLinkageTitle:(NSString *)title components:(NSInteger)components items:(NSArray *)items componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    [self _showLinkageType:FMPickerLinkageTypeNormal title:title components:components items:items componentItems:componentItems showText:showText complete:sureBlock];
}

#pragma mark ---- 不联动显示 ----
+ (instancetype)showTitle:(NSString *)title plist:(NSString *)plistPath showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    NSArray *items = [NSArray arrayWithContentsOfFile:plistPath];
    return [self showTitle:title items:items showText:showText complete:sureBlock];
}

- (void)showTitle:(NSString *)title plist:(NSString *)plistPath showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    NSArray *items = [NSArray arrayWithContentsOfFile:plistPath];
    [self showTitle:title items:items showText:showText complete:sureBlock];
}

+ (instancetype)showTitle:(NSString *)title items:(NSArray *)items showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    return [self _showLinkageType:FMPickerLinkageTypeForbid title:title components:items.count items:items componentItems:nil showText:showText complete:sureBlock];
}

- (void)showTitle:(NSString *)title items:(NSArray *)items showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    [self _showLinkageType:FMPickerLinkageTypeForbid title:title components:items.count items:items componentItems:nil showText:showText complete:sureBlock];
}

#pragma mark ---- 显示 ----
+ (instancetype)_showLinkageType:(FMPickerLinkageType)type title:(NSString *)title components:(NSInteger)components items:(NSArray *)items componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    FMPickerDataView *picker = [FMPickerDataView show];
    [picker _showLinkageType:type title:title components:components items:items componentItems:componentItems showText:showText complete:sureBlock];
    return picker;
}

- (void)_showLinkageType:(FMPickerLinkageType)type title:(NSString *)title components:(NSInteger)components items:(NSArray *)items componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock{
    self.titleLabel.text = title;
    self.components = components;
    self.componentItems = componentItems;
    self.labelShowText = showText;
    self.sureBlock = sureBlock;
    self.linkageType = type;
    self.items = items;
}

- (void)showSelectRows:(NSDictionary<NSNumber *,NSNumber *> *)selectRows{
    [self resetSelectRows];
    for (int i = 0; i < self.components; i++) {
        NSNumber *row = selectRows[@(i)];
        if (row) {
            self.selectRows[@(i)] = row;
        }
    }
    [self showCurrentComponentRow];
}


- (void)initUI{
    [super initUI];
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    [self.pickerContentView addSubview:picker];
    self.linkageType = FMPickerLinkageTypeNormal;
    self.pickerView = picker;
    self.selectRows = [NSMutableDictionary dictionary];
    self.components = 1;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pickerView.frame = self.pickerContentView.bounds;
}

- (void)sureBtnClick:(UIButton *)sender{
    if (self.sureBlock) {
        if (self.linkageType == FMPickerLinkageTypeForbid) {
            NSMutableArray *selects = [NSMutableArray array];
            for (int i = 0; i < self.items.count; i++) {
                NSArray *items = self.items[i];
                NSInteger index = [self.selectRows[@(i)] integerValue];
                [selects addObject:items[index]];
            }
            self.sureBlock(selects, self.selectRows);
        } else {
            NSMutableArray *selects = [NSMutableArray array];
            id item = self.items[[self.selectRows[@(0)] integerValue]];
            [selects addObject:item];
            for (int i = 1; i < self.components; i++) {
                NSArray *items = self.componentItems?self.componentItems(i, item):[NSArray array];
                NSInteger index = [self.selectRows[@(i)] integerValue];
                if (index < items.count) {
                    item = items[index];
                    [selects addObject:item];
                } else {
                    break;
                }
            }
            self.sureBlock(selects, self.selectRows);
        }
    }
    [super sureBtnClick:sender];
}

- (void)setItems:(NSMutableArray *)items{
    _items = items;
    [self resetSelectRows];
    [self.pickerView reloadAllComponents];
}

- (void)resetSelectRows{
    [self.selectRows removeAllObjects];
    for (int i = 0; i<self.components; i++) {
        self.selectRows[@(i)] = @0;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.linkageType == FMPickerLinkageTypeForbid) {
        return self.items.count;
    }
    return self.components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.linkageType == FMPickerLinkageTypeForbid) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            return arr.count;
        } else {
            return 0;
        }
    }
    if (component == 0) {
        return self.items.count;
    }
    NSArray *items;
    id item = self.items[[self.selectRows[@0] integerValue]];
    for (int i = 1; i <= component; i++) {
        items = !self.componentItems?[NSArray array]:self.componentItems(i, item);
        item = items[[self.selectRows[@(i)] integerValue]];
    }
    return items.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UILabel alloc] init];
    }
    NSString *name = @"";
    if (self.linkageType == FMPickerLinkageTypeForbid) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            if (row < arr.count) {
                id item = arr[row];
                name = !self.labelShowText?@"":self.labelShowText(component,item);
            }
        } else {
            name = @"";
        }
    } else {
        if (component == 0) {
            id item = self.items[row];
            name = !self.labelShowText?@"":self.labelShowText(0,item);
        } else {
            id item = self.items[[self.selectRows[@0] integerValue]];
            for (NSInteger i = 1; i <= component; i++) {
                NSArray *items = !self.componentItems?[NSArray array]:self.componentItems(i,item);
                NSInteger showRow;
                if (i == component) {
                    showRow = row;
                } else {
                    showRow = [self.selectRows[@(i)] integerValue];
                }
                if (showRow < items.count) {
                    item = items[showRow];
                }
            }
            name = !self.labelShowText?@"":self.labelShowText(component,item);
        }
    }
    UILabel *label = (UILabel *)view;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = name;
    label.font = [UIFont systemFontOfSize:16];
    if (self.configureShowLabel) {
        BOOL select = [self.selectRows[@(component)] integerValue] == row;
        self.configureShowLabel(name, label, select);
    }
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.configure.pickerDataRowWidth) {
        return self.configure.pickerDataRowWidth(component);
    }
    return self.bounds.size.width / self.components;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.configure.pickerDataRowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.linkageType == FMPickerLinkageTypeForbid) {
        self.selectRows[@(component)] = @(row);
        return;
    }
    self.selectRows[@(component)] = @(row);
    for (int i = (int)component + 1; i < self.components; i++) {
        self.selectRows[@(i)] = @0;
    }
    [self showCurrentComponentRow];
}

- (void)showCurrentComponentRow{
    for (int component = 0; component < self.components; component++) {
        NSInteger row = [self.selectRows[@(component)] integerValue];
        [self.pickerView selectRow:row inComponent:component animated:YES];
        if (component < self.components) {
            [self.pickerView reloadComponent:component];
        }
    }
}

@end
