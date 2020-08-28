//
//  JHCommentMemberTool.h
//  E-commerce
//
//  Created by 郑桂华 on 2020/8/13.
//  Copyright © 2020 DYKJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMSocialTextItem.h"

NS_ASSUME_NONNULL_BEGIN
///社交类型发布评论等@某人.话题等插入工具
@interface FMSocialTextTool : NSObject

@property(nonatomic, strong)NSMutableArray<FMSocialTextItem *> *insertItems;

@property(nonatomic, copy)void(^textDidChange)(NSAttributedString *attributeText);

///除去高亮文本显示的颜色  默认黑色
@property(nonatomic, strong)UIColor *normalColor;
///高亮显示的颜色 默认蓝色  可插入不同的颜色
@property(nonatomic, strong)UIColor *highlightColor;

+ (instancetype)createBindTextView:(UITextView *)textView;

- (void)insertText:(NSString *)text bindObj:(id __nullable)bindObj color:(UIColor * __nullable)color;

@end

NS_ASSUME_NONNULL_END
