//
//  NSAttributedString+FMExtension.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (FMExtension)
///获取文本行数
- (NSInteger)getNumberOfLinesWithWidth:(CGFloat)width;
///获取某个返回内富文本的rect
- (NSArray *)getRectsWithWidth:(CGFloat)width limitLine:(NSInteger)limitLine fromRange:(NSRange)fromRange;
@end

NS_ASSUME_NONNULL_END
