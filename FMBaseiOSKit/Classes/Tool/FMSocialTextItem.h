//
//  FMSocialTextItem.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMSocialTextItem : NSObject
///插入后的范围
@property(nonatomic, assign)NSRange range;
///绑定需要传输的参数
@property(nonatomic, strong)id bindObj;
///插入的文本(全部包含@ # 等等)
@property(nonatomic, copy)NSString *insertText;
///插入文本颜色
@property(nonatomic, strong)UIColor *textColor;

+ (instancetype)itemWithText:(NSString *)text bindObj:(id __nullable)obj color:(UIColor * __nullable)color;

@end

NS_ASSUME_NONNULL_END
