//
//  FMPickerDataView.h
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/6/30.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMPickerBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FMPickerLinkageType){
    /// 联动  下一级的数据从上一级的数据中获取 需实现componentItems
    FMPickerLinkageTypeNormal,
    /// 禁止联动
    FMPickerLinkageTypeForbid
};


typedef NSArray *_Nullable(^FMPickerComponentItems)(NSInteger component, id lastObj);
typedef NSString *_Nullable(^FMPickerLabelShowText)(NSInteger component, id obj);
typedef void(^FMPickerSureSelectBlock)(NSArray *selects, NSDictionary *selectRows);
typedef void(^FMPickerConfigureShowLabelBlock)(NSString *showText, UILabel *label, BOOL isSelected);
@interface FMPickerDataView : FMPickerBaseView

@property(nonatomic, weak)UIPickerView *pickerView;
///显示数据  不联动的 采用二维数组显示  最外层数组个数就是列数  每一个子数组就是列显示的数据   联动一般数组对象(再包含数组)嵌套,(类似地址三级联动)
@property(nonatomic, strong)NSArray *items;
///是否联动显示
@property(nonatomic, assign)FMPickerLinkageType linkageType;
///label需要显示的文本数据  根据当前应该选中数据  处理返回显示
@property(nonatomic, copy)FMPickerLabelShowText labelShowText;
///FMPickerLinkageTypeNormal联动状态下的列数
@property(nonatomic, assign)NSInteger  components;
///FMPickerLinkageTypeNormal联动状态每一列应当显示的数组数据 components当前列 上一列的选中数据
@property(nonatomic, copy)FMPickerComponentItems componentItems;
///确定选中结果回调
@property(nonatomic, copy)FMPickerSureSelectBlock sureBlock;
///配置是否选中的label显示样式
@property(nonatomic, copy)FMPickerConfigureShowLabelBlock configureShowLabel;

/// 联动类型显示  来源:plist文件
/// @param title 标题
/// @param components 列数
/// @param plistPath 文件路径
/// @param componentItems 列数据
/// @param showText 显示数据
/// @param sureBlock 选中回调
+ (instancetype)showLinkageTitle:(NSString *)title components:(NSInteger)components plist:(NSString *)plistPath componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock;
/// 联动类型显示   来源:数组数据
/// @param title 标题
/// @param components 列数
/// @param items 显示数据
/// @param componentItems 列数据
/// @param showText 显示数据
/// @param sureBlock 选中回调
+ (instancetype)showLinkageTitle:(NSString *)title components:(NSInteger)components items:(NSArray *)items componentItems:(FMPickerComponentItems)componentItems showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock;


/// 不联动类型显示  来源:plist文件
/// @param title 标题
/// @param plistPath 文件路径
/// @param showText 显示数据
/// @param sureBlock 选中回调
+ (instancetype)showTitle:(NSString *)title plist:(NSString *)plistPath showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock;

/// 不联动类型显示  来源:数组数据
/// @param title 标题
/// @param items 显示数据
/// @param showText 显示数据
/// @param sureBlock 选中回调
+ (instancetype)showTitle:(NSString *)title items:(NSArray *)items showText:(FMPickerLabelShowText)showText complete:(FMPickerSureSelectBlock)sureBlock;

@end

NS_ASSUME_NONNULL_END
