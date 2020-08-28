//
//  FMSocialTextItem.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/28.
//

#import "FMSocialTextItem.h"

@implementation FMSocialTextItem

+ (instancetype)itemWithText:(NSString *)text bindObj:(id __nullable)obj color:(UIColor * __nullable)color{
    FMSocialTextItem *item = [[self alloc] init];
    item.insertText = text;
    item.bindObj = obj;
    item.textColor = color;
    return item;
}

@end
