//
//  FMLayoutListViewController.m
//  FMBaseiOSKit_Example
//
//  Created by 郑桂华 on 2020/7/14.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMLayoutListViewController.h"

@interface FMLayoutListViewController ()

@end

@implementation FMLayoutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseNavItem.title = @"layout布局案例";
    [self.models addObject:@{@"title":@"电商首页", @"class":@"FMTaoBaoHomeViewController"}];
    [self.models addObject:@{@"title":@"外卖店铺详情", @"class":@"FMStoreDetailViewController"}];
    [self.tableView reloadData];
}

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.models.count) {
        NSDictionary *dict = self.models[indexPath.row];
        cell.textLabel.text = dict[@"title"];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.models.count) {
        NSDictionary *dict = self.models[indexPath.row];
        NSString *className = dict[@"class"];
        Class vcClass = NSClassFromString(className);
        UIViewController *vc = [[vcClass alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
