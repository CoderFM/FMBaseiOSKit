//
//  UIControl+FMExtension.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/9/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UIControlFMBlock)(id sender);

@interface UIControl (FMExtension)

@property(readonly)NSMutableDictionary *fm_eventsBlock;

- (void)fm_addBlock:(UIControlFMBlock)block event:(UIControlEvents)event;
- (void)fm_setBlock:(UIControlFMBlock)block event:(UIControlEvents)event;
- (void)fm_removeBlockEvent:(UIControlEvents)event;
- (void)fm_removeAllBlock;
@end

NS_ASSUME_NONNULL_END
