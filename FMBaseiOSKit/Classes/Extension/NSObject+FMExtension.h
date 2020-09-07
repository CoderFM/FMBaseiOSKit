//
//  NSObject+FMExtension.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/9/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FMExtension)

@property(readonly)NSMapTable *weakTable;
@property(readonly)NSMapTable *strongTable;

+ (void)fm_exchangeOriginalSel:(SEL)original replaceSel:(SEL)replace;

@end

NS_ASSUME_NONNULL_END
