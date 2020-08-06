//
//  FMViewController.m
//  FMBaseKit
//
//  Created by zhoufaming251@163.com on 05/16/2020.
//  Copyright (c) 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMViewController.h"
#import <FMBaseiOSKit/FMBaseiOSKit.h>
#import "FMTestViewController.h"

#import "FMLayoutViewController.h"
#import "FMFormViewController.h"
#import "FMLayoutListViewController.h"

#import <Masonry/Masonry.h>

@interface FMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet FMLabel *label;

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    {
        FMNavBtnsView *nav1 = [[FMNavBtnsView alloc] init];
        nav1.inset = UIEdgeInsetsMake(3, 10, 3, 10);
        nav1.titles = @[@"标签1", @"标签1", @"标签1", @"标签1", @"标签1"];
        [self.view addSubview:nav1];
        [nav1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
        
    }
    {
        FMNavBtnsView *nav1 = [[FMNavBtnsView alloc] init];
        nav1.canScroll = YES;
        nav1.itemMargin = 40;
        nav1.lineAnimation = FMNavBtnsLineAnimationZoom;
        nav1.lineBottomMargin = 10;
        nav1.lineTitleMargin = 4;
        nav1.inset = UIEdgeInsetsMake(3, 20, 3, 20);
        nav1.titles = @[@"标签1", @"标签标签11", @"标", @"标签1标签标签11", @"标签221", @"标签1asdasdadasd", @"标222签1", @"标s签1", @"标223434签1", @"标签1", @"标签标签11"];
        [self.view addSubview:nav1];
        [nav1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(140);
            make.height.mas_equalTo(40);
        }];
        [nav1 setClickSenderBlock:^(UIButton * _Nonnull sender) {
            
        }];
    }
    
    self.imageView.image = [UIImage imageWithAttributes:[@"测试" toAttrWithAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}] inset:UIEdgeInsetsMake(10, 10, 10, 10) borderWidth:1 borderColor:[UIColor blackColor] cornerRadius:10 backgroundColor:[UIColor cyanColor]];
    
    UIFont *font = [UIFont systemFontOfSize:20];
    self.label.font = font;
    
//    self.label.attributedText = [[@"06-08 16:15" toAttr] insertImage:[UIImage imageWithAttributes:[@"求职" toAttrWithAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]}] inset:UIEdgeInsetsMake(2, 8, 2, 8) borderWidth:0 borderColor:nil cornerRadius:4 backgroundColor:[UIColor blueColor]] font:font atIndex:0];
//    self.label.attributedText = [insertImage: font:font atIndex:0];
//    self.label.attributedText = [[@"06-08 16:15" toAttr] appendImage:[UIImage imageNamed:@"base_down_max"] font:font];
//    self.label.attributedText = [[@"06-08 16:15" toAttr] appendImage:[UIImage imageNamed:@"base_comments"] font:font];
    self.label.attributedText = [@"埃里克基多拉可接受的拉可视角度" toAttrWithAttr:@{NSFontAttributeName:self.label.font}];
//    self.label.attributedText = [[[[@"埃里克基多拉可接受的拉可视角度" toAttrWithAttr:@{NSFontAttributeName:self.label.font}] addAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(1, 4)] appendImage:[UIImage imageNamed:@"base_min_share"] font:self.label.font] setLineSpace:20];
    self.label.userInteractionEnabled = YES;
    NSInteger lines = [self.label.attributedText getNumberOfLinesWithWidth:100];
    NSLog(@"lines:%ld", (long)lines);
    [self.label addClickRange:NSMakeRange(3, 4) block:^{
        NSLog(@"addClickRangeNSMakeRange(3, 4) clickblock");
    }];
    [self.label addClickRange:NSMakeRange(14, 2) block:^{
        NSLog(@"addClickRangeNSMakeRange(14, 2) clickblock ");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    FMTestViewController *vc = [[FMTestViewController alloc] init];
//    vc.modalPresentationStyle = 0;
////    [vc setDidAppearBlock:^{
////
////    }];
//    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)sheetClick:(UIButton *)sender {
//    [FMBaseSheetView showToView:self.view.window];
//    [FMBaseSheetTableView showToView:self.view.window];
    [FMBaseSheetLayoutView showToView:self.view.window];
}
- (IBAction)alertClick:(id)sender {
    [FMBaseAlertView showToView:self.view.window];
}

- (IBAction)layoutClick:(id)sender {
    FMLayoutListViewController *vc = [[FMLayoutListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)formClick:(id)sender {
    FMFormViewController *vc = [[FMFormViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)inButtonClick:(UIButton *)sender {
//    UIWindow *window = [FMConfig config].window;
//    CGRect frame0 = [window convertRect:sender.frame toView:window];
//    CGRect frame1 = [sender convertRect:sender.frame toView:window];
    NSLog(@"frame: %@", [NSValue valueWithCGRect:sender.globalFrame]);
    NSLog(@"origin: %@", [NSValue valueWithCGPoint:sender.globalOrigin]);
    NSLog(@"center: %@", [NSValue valueWithCGPoint:sender.globalCenter]);
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end
