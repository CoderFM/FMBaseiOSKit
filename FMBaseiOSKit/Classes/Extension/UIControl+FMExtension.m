//
//  UIControl+FMExtension.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/9/1.
//

#import "UIControl+FMExtension.h"
#import <objc/runtime.h>

@interface __UIControlFMExtensionItem : NSObject

@property(nonatomic, copy)UIControlFMBlock block;

@end

@implementation __UIControlFMExtensionItem

- (void)dealloc{
    
}

- (void)invoke:(id)sender{
    !self.block?:self.block(sender);
}

@end

@implementation UIControl (FMExtension)

- (NSMutableDictionary *)fm_eventsBlock{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (NSMutableArray *)itemsWithEvents:(UIControlEvents)events{
    NSMutableArray *items = self.fm_eventsBlock[@(events)];
    if (items == nil) {
        items = [NSMutableArray array];
        self.fm_eventsBlock[@(events)] = items;
    }
    return items;
}

- (void)fm_addBlock:(UIControlFMBlock)block event:(UIControlEvents)event{
    if (!block) {
        return;
    }
    [[self itemsWithEvents:event] addObject:[self __itemWithBlock:block event:event]];
}

- (void)fm_setBlock:(UIControlFMBlock)block event:(UIControlEvents)event{
    if (!block) {
        return;
    }
    NSMutableArray *arrM = [self itemsWithEvents:event];
    [arrM removeAllObjects];
    [arrM addObject:[self __itemWithBlock:block event:event]];
}

- (__UIControlFMExtensionItem *)__itemWithBlock:(UIControlFMBlock)block event:(UIControlEvents)event{
    __UIControlFMExtensionItem *item = [[__UIControlFMExtensionItem alloc] init];
    item.block = block;
    [self addTarget:item action:@selector(invoke:) forControlEvents:event];
    return item;
}

- (void)fm_removeBlockEvent:(UIControlEvents)event{
    [[self itemsWithEvents:event] removeAllObjects];
}

- (void)fm_removeAllBlock{
    [self.fm_eventsBlock removeAllObjects];
}

@end
