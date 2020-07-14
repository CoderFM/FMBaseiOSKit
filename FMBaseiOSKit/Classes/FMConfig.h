//
//  FMConfig.h
//  FMBaseKit
//
//  Created by 郑桂华 on 2020/3/11.
//  Copyright © 2020 ZhouFaMing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define FMWeakSelf __weak typeof(self) weakSelf = self

NS_ASSUME_NONNULL_BEGIN
@class FMBaseViewController, FMBaseListController, FMBaseTableController, FMCollectionLayoutController;
@interface FMConfig : NSObject

extern NSInteger FMGetRandomIntegerFromRange(NSRange range);

@property(nonatomic, copy)void(^configurationBaseVC)(FMBaseViewController *base);
@property(nonatomic, copy)void(^configurationListVC)(FMBaseListController *list);
@property(nonatomic, copy)void(^configurationTableVC)(FMBaseTableController *table);
@property(nonatomic, copy)void(^configurationCollVC)(FMCollectionLayoutController *coll);

@property(nonatomic, weak)UIWindowScene *windowScene API_AVAILABLE(ios(13.0));
@property(nonatomic, weak)UIWindow *window;

@property(nonatomic, assign)BOOL isIPhoneX;
@property(nonatomic, assign)CGFloat screenWidth;
@property(nonatomic, assign)CGFloat screenHeight;
@property(nonatomic, assign)CGFloat navHeight;
@property(nonatomic, assign)CGFloat statusHeight;
@property(nonatomic, assign)CGFloat navStatusHeight;
@property(nonatomic, assign)CGFloat tabBarHeight;
@property(nonatomic, assign)CGFloat safeBottomHeight;

+ (instancetype)config;

@end

NS_ASSUME_NONNULL_END
