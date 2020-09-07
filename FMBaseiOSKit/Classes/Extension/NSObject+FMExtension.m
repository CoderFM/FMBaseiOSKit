//
//  NSObject+FMExtension.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/9/1.
//

#import "NSObject+FMExtension.h"
#import <objc/runtime.h>

@implementation NSObject (FMExtension)

- (NSMapTable *)weakTable{
    NSMapTable *table = objc_getAssociatedObject(self, _cmd);
    if (table == nil) {
        table = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return table;
}

- (NSMapTable *)strongTable{
    NSMapTable *table = objc_getAssociatedObject(self, _cmd);
    if (table == nil) {
        table = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory];
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return table;
}

+ (void)fm_exchangeOriginalSel:(SEL)original replaceSel:(SEL)replace{
    {
        Method m1 = class_getInstanceMethod(self, original);
        Method m2 = class_getInstanceMethod(self, replace);
        method_exchangeImplementations(m1, m2);
    }
}

@end
