//
//  FMPresentStyleViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2021/4/10.
//  Copyright © 2021 zhoufaming251@163.com. All rights reserved.
//

#import "FMPresentStyleViewController.h"
#import "FMTestViewController.h"
#import "FMNavigationController.h"

@interface FMPresentStyleViewController ()

@end

@implementation FMPresentStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.models = [NSMutableArray array];
    
    
//    UIPresentationController *present = [[UIPresentationController alloc] initWithPresentedViewController:self presentingViewController:<#(nullable UIViewController *)#>]
    
    /*
     UIModalPresentationFullScreen = 0,
     UIModalPresentationPageSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
     UIModalPresentationFormSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
     UIModalPresentationCurrentContext API_AVAILABLE(ios(3.2)),
     UIModalPresentationCustom API_AVAILABLE(ios(7.0)),
     UIModalPresentationOverFullScreen API_AVAILABLE(ios(8.0)),
     UIModalPresentationOverCurrentContext API_AVAILABLE(ios(8.0)),
     UIModalPresentationPopover API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(tvos),
     UIModalPresentationBlurOverFullScreen API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios) API_UNAVAILABLE(watchos),
     UIModalPresentationNone API_AVAILABLE(ios(7.0)) = -1,
     UIModalPresentationAutomatic API_AVAILABLE(ios(13.0)) = -2,
     */
    [self.models addObject:@{@(UIModalPresentationFullScreen): @"UIModalPresentationFullScreen"}];
    [self.models addObject:@{@(UIModalPresentationPageSheet): @"UIModalPresentationPageSheet"}];
    [self.models addObject:@{@(UIModalPresentationFormSheet): @"UIModalPresentationFormSheet"}];
    [self.models addObject:@{@(UIModalPresentationCurrentContext): @"UIModalPresentationCurrentContext"}];
    [self.models addObject:@{@(UIModalPresentationCustom): @"UIModalPresentationCustom"}];
    [self.models addObject:@{@(UIModalPresentationOverFullScreen): @"UIModalPresentationOverFullScreen"}];
    [self.models addObject:@{@(UIModalPresentationOverCurrentContext): @"UIModalPresentationOverCurrentContext"}];
    [self.models addObject:@{@(UIModalPresentationPopover): @"UIModalPresentationPopover"}];
    [self.tableView reloadData];
}

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict = self.models[indexPath.row];
    cell.textLabel.text = dict.allValues.firstObject;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict = self.models[indexPath.row];
    FMTestViewController *vc = [[FMTestViewController alloc] init];
    vc.isBack = YES;
    FMNavigationController *nav = [[FMNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = [dict.allKeys.firstObject integerValue];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
