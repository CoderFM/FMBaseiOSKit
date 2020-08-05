//
//  FMLabel.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FMLabelTouchBlock)(void);

@interface FMLabel : UILabel

- (void)addClickRange:(NSRange)range block:(FMLabelTouchBlock)block;

@end

NS_ASSUME_NONNULL_END
