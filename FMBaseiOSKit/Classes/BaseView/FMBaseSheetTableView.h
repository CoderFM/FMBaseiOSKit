//
//  FMBaseSheetTableView.h
//  FMBaseiOSKit
//
//  Created by 郑桂华 on 2020/7/17.
//

#import "FMBaseSheetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMBaseSheetTableView : FMBaseSheetView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, assign, readonly)Class cellClass;
@property(nonatomic, weak)UITableView *tableView;

- (void)configurationCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
