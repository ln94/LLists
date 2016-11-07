//
//  LAllListsViewController.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewController.h"
#import "LAllListsViewCell.h"
#import "LTableFooterView.h"
#import "LSingleListViewController.h"

@interface LAllListsViewController () <LTableViewCellDelegate, LAllListsViewCellDelegate>

@property (nonatomic) NSFetchedResultsController *lists;

@property (nonatomic) LTableFooterView *tableFooter;

@property (nonatomic) List *movingList;

@end

@implementation LAllListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Fetch Results Controller
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[List class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    self.lists = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:request];
    [self.lists performFetch];
    
    // Table View
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = kAllListsViewCellHeight;
    
    self.tableFooter = [[LTableFooterView alloc] initWithSize:s(self.tableView.width, kAllListsViewCellHeight - kSeparatorHeight)];
    self.tableFooter.textField.font = F_TITLE;
    self.tableView.tableFooterView = self.tableFooter;
    
    [self.tableView registerClass:[LAllListsViewCell class] forCellReuseIdentifier:[LAllListsViewCell reuseIdentifier]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LAllListsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LAllListsViewCell reuseIdentifier]];
    cell.list = [self.lists objectAtIndexPath:indexPath];
    cell.delegate = self;
    
    if (cell.list == self.movingList) {
        cell.alpha = 0.5;
    }
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - LTableViewCellDelegate

- (void)tableViewCell:(LTableViewCell *)cell didPressSeparator:(LSeparatorButton *)separator {
    // Add empty cell between
}

- (void)tableViewCell:(LTableViewCell *)cell longPressed:(UILongPressGestureRecognizer *)longPress {
    // Move cell in the list
//    switch (longPress.state) {
//            
//        case UIGestureRecognizerStateBegan: {
//            // Update cell
//            self.movingList = ((LAllListsViewCell *)cell).list;
//            [self.tableView reloadRowsAtIndexPaths:@[[self.lists indexPathForObject:self.movingList]] withRowAnimation:UITableViewRowAnimationFade];
//        }
//            break;
//            
//        case UIGestureRecognizerStateChanged: {
//            
//            LOG(@"Move");
//            // Move cell within the table
//            CGFloat y = [longPress locationInView:self.tableView].y;
//            for (LAllListsViewCell *otherCell in self.tableView.visibleCells) {
//                if (otherCell.list != self.movingList && y == otherCell.frame.origin.y) {
//                    // Swipe cells
//                    LOG(@"Swipe");
//                    NSArray *indexPaths = @[[self.tableView indexPathForCell:cell], [self.tableView indexPathForCell:otherCell]];
//                    
//                    NSNumber *movingListIndex = self.movingList.index;
//                    self.movingList.index = otherCell.list.index;
//                    otherCell.list.index = movingListIndex;
//                    
//                    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//                }
//            }
//        }
//            break;
//            
//        case UIGestureRecognizerStateEnded: {
//            // Save cell's position
//            LOG(@"End");
//            [DataStore save];
//        }
//            break;
//            
//        default:
//            break;
//    }
}


#pragma mark - LAllListsViewCellDelegate

- (void)didSelectTableViewCell:(LAllListsViewCell *)cell {
    
    // Open Single List screen
    LSingleListViewController *vc = [[LSingleListViewController alloc] initWithList:cell.list];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
