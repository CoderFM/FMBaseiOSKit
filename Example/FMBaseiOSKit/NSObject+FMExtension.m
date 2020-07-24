//
//  NSObject+FMExtension.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/24.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "NSObject+FMExtension.h"
#import <objc/runtime.h>




@implementation NSObject (FMExtension)

- (void)hookSelector:(SEL)sel{
    // 1.创建一个子类
//    NSString *oldName = NSStringFromClass([self class]);
//    Method method = class_getInstanceMethod([self class], sel);
//    const char * type = method_getTypeEncoding(method);
//    
//    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@", oldName];
//    Class customClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
//    objc_registerClassPair(customClass);
//    // 2.修改修改isa指针
//    object_setClass(self, customClass);
    // 3.重写set方法
    
//    NSString *selectorName = [NSString stringWithFormat:@"set%@:", keyPath.capitalizedString];
//    SEL sel = NSSelectorFromString(selectorName);
//    class_addMethod(customClass, sel, (IMP)_MySetObjectValueAndNotify, "v@:@");

}

@end
