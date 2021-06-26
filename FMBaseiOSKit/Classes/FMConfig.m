//
//  FMConfig.m
//  FMBaseKit
//
//  Created by 郑桂华 on 2020/3/11.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import "FMConfig.h"

NSInteger FMGetRandomIntegerFromRange(NSRange range) {
    NSInteger fm = range.location;
    NSInteger to = range.location + range.length;
    return (arc4random() % (to - fm + 1)) + fm;
}

@implementation FMConfig

+ (instancetype)config{
    static FMConfig *_FMConfigInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FMConfigInstance = [[FMConfig alloc] init];
    });
    return _FMConfigInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        self.screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    }
    return self;
}

- (UIWindow *)window{
    if (@available(iOS 13.0, *)) {
        UIWindow *showWindow;
        for (UIWindow *window in self.windowScene.windows) {
            if (!window.hidden && ![window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                showWindow = window;
                break;
            }
        }
        return showWindow;
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

- (UIWindowScene *)windowScene API_AVAILABLE(ios(13.0)){
    if (_windowScene == nil) {
        UIWindowScene *windowScene;
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                windowScene = (UIWindowScene *)scene;
            }
        }
        _windowScene = windowScene;
    }
    return _windowScene;
}

- (CGFloat)statusHeight{
    if (_statusHeight == 0) {
        if (@available(iOS 13.0, *)) {
            _statusHeight = self.windowScene.statusBarManager.statusBarFrame.size.height;
        } else {
            _statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    return _statusHeight;
}

- (CGFloat)navStatusHeight{
    return self.statusHeight + self.navHeight;
}

- (BOOL)isIPhoneX{
    return self.statusHeight > 20;
}

- (CGFloat)safeBottomHeight{
    return self.isIPhoneX ? 34 : 0;
}

- (CGFloat)tabBarHeight{
    return self.isIPhoneX ? 83 : 49;
}

@end
