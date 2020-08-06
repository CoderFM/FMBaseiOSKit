//
//  FMLabel.m
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/8/5.
//

#import "FMLabel.h"
#import "NSAttributedString+FMExtension.h"

NSString *__GetKeyFromRange(NSRange range){
    return [NSString stringWithFormat:@"location:%ld length:%ld", range.location, range.length];
}

@interface __FMLabelClickObj : NSObject

@property(nonatomic, copy)FMLabelTouchBlock block;
@property(nonatomic, assign)NSRange range;
@property(nonatomic, strong)NSArray *rects;

@end

@implementation __FMLabelClickObj

@end

@interface FMLabel ()

@property(nonatomic, strong)NSMutableDictionary<NSString *,__FMLabelClickObj *> *clicks;

@property(nonatomic, assign)BOOL handleClickFinished;

@end

@implementation FMLabel

- (NSMutableDictionary<NSString *,__FMLabelClickObj *> *)clicks{
    if (_clicks == nil) {
        _clicks = [NSMutableDictionary dictionary];
    }
    return _clicks;
}

- (CGFloat)attributeMaxHeight{
    if (_attributeMaxHeight == 0) {
        _attributeMaxHeight = 2000;
    }
    return _attributeMaxHeight;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.handleClickFinished) {
        [self __handleAllClickRange];
        self.handleClickFinished = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    // 遍历所有的点击事件
    [self.clicks.allValues enumerateObjectsUsingBlock:^(__FMLabelClickObj *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 遍历点击事件里的点击范围
        [obj.rects enumerateObjectsUsingBlock:^(NSValue *rectValue, NSUInteger idx, BOOL * _Nonnull stop1) {
            if (CGRectContainsPoint([rectValue CGRectValue], point)) {
                if (obj.block) {
                    obj.block();
                    *stop = YES;
                    *stop1 = YES;
                }
            }
        }];
    }];
}

- (void)addClickRange:(NSRange)range block:(FMLabelTouchBlock)block{
    NSString *key = __GetKeyFromRange(range);
    __FMLabelClickObj *obj = [self.clicks objectForKey:key];
    if (obj) {
        obj.block = block;
    } else {
        obj = [[__FMLabelClickObj alloc] init];
        obj.range = range;
        obj.block = block;
        [self.clicks setObject:obj forKey:key];
    }
    if (self.handleClickFinished) {
        [self __handleAllClickRange];
    }
}

- (void)__handleAllClickRange{
    for (__FMLabelClickObj *obj in self.clicks.allValues) {
        if (obj.rects == nil) {
            NSAttributedString *attributes = self.attributedText ?: [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName:self.font}];
            __weak typeof(obj) weakObj = obj;
            [attributes asyncGetRectsWithWidth:self.bounds.size.width maxHeight:self.attributeMaxHeight limitLine:NSIntegerMax fromRange:obj.range complete:^(NSArray * _Nonnull rects) {
                weakObj.rects = rects;
            }];
        }
    }
}

@end
