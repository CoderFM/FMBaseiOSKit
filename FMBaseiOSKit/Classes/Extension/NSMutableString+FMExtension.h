//
//  NSMutableString+FMExtension.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (FMExtension)

- (instancetype)append:(NSString *)text;
- (instancetype)inset:(NSString *)text index:(NSInteger)index;
- (instancetype)replace:(NSString *)text forRange:(NSRange)range;
- (instancetype)replace:(NSString *)text forText:(NSString *)forText;

@end

NS_ASSUME_NONNULL_END
