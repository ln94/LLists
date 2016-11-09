//
//  LAllListsViewController.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewController.h"
#import "LListTableViewCell.h"
#import "LSingleListViewController.h"
#import "LHeaderView.h"
#import "LAddListView.h"

@interface LAllListsViewController () <UITableViewDataSource, UITableViewDelegate, LHeaderViewDelegate>

@property (nonatomic) NSFetchedResultsController<List *> *lists;

@property (nonatomic) UITableView *tableView;

@property (nonatomic) LHeaderView *header;

@property (nonatomic) LAddListView *addListView;

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
    
    // Header
    self.header = [[LHeaderView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsViewCellHeight - kSeparatorHeight insets:inset_top(LLists.statusBarHeight)];
    self.header.delegate = self;
    
    // Table View
    self.tableView = [[UITableView alloc] initFullInSuperview:self.view insets:inset_top(self.header.bottom)];
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = kAllListsViewCellHeight;
    
    [self.tableView registerClass:[LListTableViewCell class] forCellReuseIdentifier:[LListTableViewCell reuseIdentifier]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Add List View
    self.addListView = [[LAddListView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsViewCellHeight insets:inset_top(self.header.top)];
    self.addListView.hidden = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LListTableViewCell reuseIdentifier]];
    cell.list = [self.lists objectAtIndexPath:indexPath];
//    cell.delegate = self;
    
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

//- (void)tableViewCell:(LTableViewCell *)cell didPressSeparator:(LSeparatorButton *)separator {
//    // Add empty cell between
//}
//
//- (void)tableViewCell:(LTableViewCell *)cell longPressed:(UILongPressGestureRecognizer *)longPress {
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
//}

#pragma mark - LAllListsViewCellDelegate

//- (void)didSelectTableViewCell:(LAllListsViewCell *)cell {
//    
//    // Open Single List screen
//    LSingleListViewController *vc = [[LSingleListViewController alloc] initWithList:cell.list];
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - LHeaderViewDelegate

- (void)didPressAddButton {
    
}

@end
