//
//  JHCommentMemberTool.m
//  E-commerce
//
//  Created by 郑桂华 on 2020/8/13.
//  Copyright © 2020 DYKJ. All rights reserved.
//

#import "FMSocialTextTool.h"

@interface FMSocialTextTool ()<UITextViewDelegate>

@property(nonatomic, weak)UITextView *textView;

@end

@implementation FMSocialTextTool

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)createBindTextView:(UITextView *)textView{
    FMSocialTextTool *tool = [[self alloc] init];
    tool.textView = textView;
    [[NSNotificationCenter defaultCenter] addObserver:tool selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:textView];
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.insertItems = [NSMutableArray array];
        self.normalColor = [UIColor blackColor];
        self.highlightColor = [UIColor blueColor];
    }
    return self;
}

- (void)setTextView:(UITextView *)textView{
    _textView = textView;
    textView.delegate = self;
}

- (void)textViewTextDidChange:(NSNotification *)noti{
    UITextRange *selectedRange = self.textView.markedTextRange;
    UITextPosition *position = [self.textView positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    NSRange selectRange = self.textView.selectedRange;
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *attr = [self.textView.attributedText mutableCopy];
    [attr addAttributes:@{NSForegroundColorAttributeName:self.normalColor, NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.textView.attributedText.length)];
    for (FMSocialTextItem *item in self.insertItems) {
        NSRange range =item.range;
        [attr addAttributes:@{NSForegroundColorAttributeName:item.textColor?:self.highlightColor} range:range];
    }
    self.textView.attributedText = attr;
    if (self.textDidChange) {
        self.textDidChange(attr);
    }
    self.textView.selectedRange = selectRange;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSRange selectRange = textView.selectedRange;
    for (FMSocialTextItem *item in self.insertItems) {
        if (selectRange.length == 0) {
            if (selectRange.location > item.range.location && selectRange.location < (item.range.location + item.range.length)) {
                NSInteger resultLocation = selectRange.location;
                if (selectRange.location <= (item.range.location + item.range.length * 0.5)) {
                    resultLocation = item.range.location;
                } else {
                    resultLocation = item.range.location + item.range.length;
                }
                textView.selectedRange = NSMakeRange(resultLocation, 0);
                return;
            }
        } else {
            if (selectRange.location < item.range.location && selectRange.location + selectRange.length > item.range.location) {
                textView.selectedRange = NSMakeRange(selectRange.location, item.range.location - selectRange.location);
                return;
            }
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (self.insertItems.count > 0) {
        NSInteger index = 0;
        for (FMSocialTextItem *item in self.insertItems) {
            NSRange pRange = item.range;
            if (text.length == 0 && range.length > 0) { //删除
                if (range.location >= pRange.location && range.location < pRange.location + pRange.length) {// 在高亮后面并且删除到高亮位置  整个高亮部分删除
                    NSMutableAttributedString *attr = [self.textView.attributedText mutableCopy];
                    [attr replaceCharactersInRange:pRange withString:@""];
                    self.textView.attributedText = attr;
                    self.textView.selectedRange = NSMakeRange(pRange.location, 0);
                    [self.insertItems removeObject:item];
                    for (int i = (int)index; i < self.insertItems.count; i++) {
                        FMSocialTextItem *laterItem = self.insertItems[i];
                        NSRange laterRange = laterItem.range;
                        laterRange.location -= pRange.length;
                        laterItem.range = laterRange;
                    }
                    return NO;
                } else if (range.location < pRange.location) { //在高亮前面
                    pRange.location -= range.length;
                    item.range = pRange;
                }
            } else if (text.length > 0) {//增加或者插入 将已经存在的在插入位置后面的位置往后面挪动
                if (pRange.location > range.location) {
                    pRange.location += text.length;
                    item.range = pRange;
                }
            }
            index++;
        }
    }
    return YES;
}

- (void)insertText:(NSString *)text bindObj:(id __nullable)bindObj color:(UIColor * __nullable)color{
    NSMutableAttributedString *attr = [self.textView.attributedText mutableCopy];
    NSAttributedString *insert = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:self.textView.font, NSForegroundColorAttributeName:color?:self.highlightColor}];
    NSInteger location = self.textView.selectedRange.location;
    NSRange range = NSMakeRange(location, text.length);
    NSInteger index = 0;
    BOOL append = YES;
    NSInteger insertLocation = 0;
    for (FMSocialTextItem *item in self.insertItems) {
        NSRange pRange = item.range;
        if (pRange.location >= location) {
            pRange.location += range.length;
            item.range = pRange;
            append = NO;
            if (insertLocation == 0) {
                insertLocation = index;
            }
        }
        index++;
    }
    FMSocialTextItem *item = [FMSocialTextItem itemWithText:text bindObj:bindObj color:color];
    item.range = range;
    if (append) {
        [self.insertItems addObject:item];
    } else {
        [self.insertItems insertObject:item atIndex:insertLocation];
    }
    [attr insertAttributedString:insert atIndex:location];
    self.textView.attributedText = attr;
    self.textView.selectedRange = NSMakeRange(location+range.length, 0);
    [self textViewTextDidChange:nil];
}

@end
