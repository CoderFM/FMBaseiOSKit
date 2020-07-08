//
//  FMFormListSubmitVC.h
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FMBaseViewController.h"
#import <FMFormSubmitKit/FMFormSubmitKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FMFormListSubmitVC : FMBaseViewController
@property(nonatomic, assign, readonly)UITableViewStyle tableStyle;
@property(nonatomic, weak)FormListSubmitView *tableView;
@property (nonatomic, strong)NSMutableArray<FormListBaseModel *> *dataSource;
- (void)addData;
- (void)configurationTable;

- (BOOL)verifyDataSource;
- (BOOL)verifyDataSource:(BOOL)alert;
@end

NS_ASSUME_NONNULL_END
