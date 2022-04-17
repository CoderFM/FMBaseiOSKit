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
#import "FMFloadPageTestViewController.h"

#import <Masonry/Masonry.h>

#import <WebKit/WebKit.h>

@interface FMViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet FMLabel *label;

@property(nonatomic, copy)void(^circleBlock)(void);

@property(nonatomic, strong)FMDataPublisher *dataPublisher;

@property(nonatomic, strong)FMTransitionAnimator *transtionAnimator;

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transtionAnimator = [FMTransitionAnimatorFactory translateAnimationWithType:FMTransitionTranslateBTT];
    
    UIButton *btn = [UIButton buttonWithTitle:@"弹窗" font:[UIFont systemFontOfSize:15] color:[UIColor purpleColor]];
    [btn addTarget:self action:@selector(navRightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn fm_addBlock:^(id  _Nonnull sender) {
        
    } event:UIControlEventTouchUpInside];
//    [btn fm_removeBlockEvent:UIControlEventTouchUpInside];
    [btn fm_removeAllBlock];
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
//            [FMBaseAlertView showToView:self.view.window from:sender contentSize:CGSizeMake(100, 100) type:sender.tag % 4];
            [FMBaseAlertView showToView:self.view];
        }];
    }
    
    self.imageView.image = [UIImage imageWithAttributes:[@"测试" toAttrWithAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}] inset:UIEdgeInsetsMake(10, 10, 10, 10) borderWidth:1 borderColor:[UIColor blackColor] cornerRadius:10 backgroundColor:[UIColor cyanColor]];
    
    UIFont *font = [UIFont systemFontOfSize:12];
    self.label.font = font;
    
    self.label.attributedText = [[[NSString stringWithFormat:@"测试用户40498371 回复 GG : yi"] toAttr] appendImage:[UIImage imageWithAttributes:[[NSString stringWithFormat:@"%@回复", @"1"] toAttrWithAttr:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]}] inset:UIEdgeInsetsMake(4, 6, 4, 6) borderWidth:0 borderColor:[UIColor lightGrayColor] cornerRadius:10 backgroundColor:[UIColor cyanColor]] font:font];
//    [self.label addClickRange:NSMakeRange(0, 5) block:^{
//
//    }];
    self.label.userInteractionEnabled = YES;
    [self.label addClickRange:NSMakeRange(0, 5) bindObj:@"1" block:^(id  _Nullable bindObj) {
        
    }];
    
//    self.label.attributedText = [[@"06-08 16:15" toAttr] insertImage:[UIImage imageWithAttributes:[@"求职" toAttrWithAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor whiteColor]}] inset:UIEdgeInsetsMake(2, 8, 2, 8) borderWidth:0 borderColor:nil cornerRadius:4 backgroundColor:[UIColor blueColor]] font:font atIndex:0];
//    self.label.attributedText = [insertImage: font:font atIndex:0];
//    self.label.attributedText = [[@"06-08 16:15" toAttr] appendImage:[UIImage imageNamed:@"base_down_max"] font:font];
//    self.label.attributedText = [[@"06-08 16:15" toAttr] appendImage:[UIImage imageNamed:@"base_comments"] font:font];
//    self.label.attributedText = [@"埃里克基多拉可接受的拉可视角度" toAttrWithAttr:@{NSFontAttributeName:self.label.font}];
//    self.label.attributedText = [[[[@"埃里克基多拉可接受的拉可视角度" toAttrWithAttr:@{NSFontAttributeName:self.label.font}] addAttr:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(1, 4)] appendImage:[UIImage imageNamed:@"base_min_share"] font:self.label.font] setLineSpace:20];
//    self.label.userInteractionEnabled = YES;
//    NSInteger lines = [self.label.attributedText getNumberOfLinesWithWidth:100];
//    NSLog(@"lines:%ld", (long)lines);
//    [self.label addClickRange:NSMakeRange(3, 4) block:^{
//        NSLog(@"addClickRangeNSMakeRange(3, 4) clickblock");
//    }];
//    [self.label addClickRange:NSMakeRange(14, 2) block:^{
//        NSLog(@"addClickRangeNSMakeRange(14, 2) clickblock ");
//    }];
    
//    WKWebView *web = [[WKWebView alloc] init];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mrs.chinaums.com/nmrs/interface/autoH5Reg?json_data=470D4DDD7F7771CB34C6D33F94D660525E6BB13E8117BA66D050E6B55D193A9D3570D8BD935D1E9EE37577856B1EB4FBA57DF94800EA1350AC7D817C635C15B1BD786D19136CAFE4BE0A080DB8DA2B7841D1BE5F0E109E2E2E2656B345F68D0D83D179C975013EF8C52E3976B762081859DD556EF4734D27073A628885E9F97C9DB176DBE3F5532418544BE82AB4051CFC4F88F4B2C82E6A91C5F5002D1568BA60EE2E00D3AC64985859002F555D480B2889E157C4B8309BF9AAA40F27CE8B5B13706353CD1BD21BF0EF629E5BB6012D&sign_data=7383dc5bc15824404058fb5fa986c4e78fedd30a690936832549293f77452ef0&accesser_id=2d9081bc6d70720b016dbead29023079"]]];
//    [web loadHTMLString:@"<!DOCTYPE html><html><head><meta charset=utf-8><meta name=apple-mobile-web-app-capable content=yes><meta name=viewport content=\"initial-scale=1,maximum-scale=1,user-scalable=no,width=device-width\"><meta name=screen-orientation content=portrait><meta name=format-detection content=\"telephone=no\"><meta http-equiv=Cache-Control content=\"no-cache, no-store, must-revalidate\"><meta http-equiv=Pragma content=no-cache><meta http-equiv=Expires content=0><meta http-equiv=X-UA-Compatible content=\"IE=edge\"><title>联合信签</title><link href=../css/portalsilver.9760a7d479a2b5a30d83dfe44208d0d0.css rel=stylesheet></head><body><div id=app style=height:100%;></div><script type=text/javascript src=../js/portalsilver.b3bd57e50359f35f1db6.js></script></body></html>" baseURL:nil];
//    [self.view addSubview:web];
//    [web mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(0);
//    }];
    
    NSLog(@"长度:%ld", @"😁".length);
    
    self.dataPublisher = [[FMDataPublisher<NSString *> alloc] init];
    [self.dataPublisher addObserve:^(NSString *data) {
        
    }];
    [self.dataPublisher publish:@"111111"];
    
//    self.interceptor = [FMProtocolInterceptor initWithTarget:self realTarget:self.navigationController.delegate];
//    self.navigationController.delegate = self.interceptor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    FMBaseViewController *vc = [[FMBaseViewController alloc] init];
    vc.baseNavItem.title = @"测试view";
//    vc.isBack = YES;
//    vc.modalPresentationStyle = 0;
////    [vc setDidAppearBlock:^{
////
////    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)sheetClick:(UIButton *)sender {
//    [FMBaseSheetView showToView:self.view.window];
//    [FMBaseSheetTableView showToView:self.view.window];
//    [FMBaseSheetLayoutView showToView:self.view.window];
    
    [FMFloatContainerController showWithInViewController:self contentViewController:[UIViewController new] contentSize:300 contentInset:UIEdgeInsetsMake(0, 10, 20, 10) completion:^{
        
    }];
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    vc.preferredContentSize = CGSizeMake(100, 100);
//    vc.modalPresentationStyle = UIModalPresentationPopover;
//    vc.popoverPresentationController.sourceView = self.view;
//    vc.popoverPresentationController.sourceRect = CGRectMake(20, self.view.bounds.size.height - 100, 100, 40);
//    [self presentViewController:vc animated:YES completion:nil];
//    FMFloadPageTestViewController *floatPage = [[FMFloadPageTestViewController alloc] init];
//    [self presentViewController:floatPage animated:YES completion:nil];
}
- (IBAction)alertClick:(id)sender {
//    [FMBaseAlertView showToView:self.view.window];
    [FMBaseAlertView showToView:self.view.window from:sender contentSize:CGSizeMake(100, 100) type:FMAlertTypeBottom];
}

- (IBAction)layoutClick:(id)sender {
    FMLayoutListViewController *vc = [[FMLayoutListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [self setCircleBlock:^{
        vc.navigationItem.title = @"asdlkajsldk";
    }];
}

- (IBAction)formClick:(id)sender {
    FMFormViewController *vc = [[FMFormViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)inButtonClick:(UIButton *)sender {
//    UIWindow *window = [FMConfig config].window;
//    CGRect frame0 = [window convertRect:sender.frame toView:window];
//    CGRect frame1 = [sender convertRect:sender.frame toView:window];
//    NSLog(@"frame: %@", [NSValue valueWithCGRect:sender.globalFrame]);
//    NSLog(@"origin: %@", [NSValue valueWithCGPoint:sender.globalOrigin]);
//    NSLog(@"center: %@", [NSValue valueWithCGPoint:sender.globalCenter]);
    
    [FMBaseAlertView showToView:self.view.window from:sender contentSize:CGSizeMake(100, 100) type:FMAlertTypeTop];
}

- (void)navRightClick:(UIButton *)sender{
    
//    [FMBaseAlertView showToView:self.view.window from:sender contentSize:CGSizeMake(100, 100) type:FMAlertTypeBottom];
    
//    [FMBaseAlertView showToView:self.view.window fromPoint:CGPointMake([FMConfig config].screenWidth - 10, [FMConfig config].statusHeight) contentSize:CGSizeMake(100, 100) type:FMAlertTypeBottom];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    return [super keyPathsForValuesAffectingValueForKey:key];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  API_AVAILABLE(ios(7.0)){
    switch (operation) {
        case UINavigationControllerOperationPush:
            return [self.transtionAnimator open];
            break;
        case UINavigationControllerOperationPop:
            return [self.transtionAnimator close];
            break;
        default:
            break;
    }
    return self.transtionAnimator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController API_AVAILABLE(ios(7.0)){
    
//    return [ui];
    return nil;
}

@end
