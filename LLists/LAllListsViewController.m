//
//  LAllListsViewController.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewController.h"
#import "LAllListsViewCell.h"
#import "LSingleListViewController.h"
#import "LHeaderView.h"
#import "LAddListView.h"

static const CGFloat duration = 0.25;

@interface LAllListsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic) LHeaderView *header;

@property (nonatomic) NSFetchedResultsController<List *> *lists;
@property (nonatomic) UITableView *tableView;

@property (nonatomic) UIView *shadowView;

@property (nonatomic) LAddListView *addListView;

@property (nonatomic) List *movingList;

@end

@implementation LAllListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = C_WHITE;
    
    // Header
    self.header = [[LHeaderView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsViewCellHeight - kSeparatorHeight insets:inset_top(LLists.statusBarHeight)];
    [self.header.addButton addTarget:self action:@selector(didPressAddButton)];
    
    // Fetch Results Controller
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[List class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    self.lists = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:request];
    [self.lists performFetch];
    
    // Table View
    self.tableView = [[UITableView alloc] initFullInSuperview:self.view insets:inset_top(self.header.bottom)];
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = kAllListsViewCellHeight;
    
    [self.tableView registerClass:[LAllListsViewCell class] forCellReuseIdentifier:[LAllListsViewCell reuseIdentifier]];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Shadow View
    self.shadowView = [[UIView alloc] initFullInSuperview:self.view insets:inset_top(self.tableView.top)];
    self.shadowView.backgroundColor = C_SHADOW;
    self.shadowView.hidden = YES;
    
    // Add List View
    self.addListView = [[LAddListView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsViewCellHeight insets:inset_top(self.header.top - kSeparatorHeight)];
    self.addListView.textField.delegate = self;
    
    UISwipeGestureRecognizer *addListViewSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hideAddListView)];
    addListViewSwipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.addListView addGestureRecognizer:addListViewSwipeUp];
    [self.shadowView addGestureRecognizer:addListViewSwipeUp];
    
    [self.view bringSubviewToFront:self.header];
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

    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView endEditing:YES];
    
    if (scrollView.contentOffset.y <= 0 &&![self isAddListViewShown]) {
        [self showAddListView];
    }
}


#pragma mark - Add List View

- (void)didPressAddButton {
    [self showAddListView];
}

- (void)didTapShadowView {
    [self hideAddListView];
}

- (void)showAddListView {
    // Hide Add Button
    [UIView transitionWithView:self.header.addButton duration:0.4 options:showingAnimation animations:^{
        self.header.addButton.hidden = YES;
    } completion:nil];
    
    // Show Add List View
    self.addListView.hidden = NO;
    
    [UIView animateWithDuration:duration animations:^{
        self.addListView.top = self.header.bottom;
        self.shadowView.hidden = NO;
        
    } completion:^(BOOL finished) {
        [self.addListView setShowingColorTag:YES completion:^{
            
            // Show keyboard
            [self.addListView.textField becomeFirstResponder];
        }];
    }];
}

- (void)hideAddListView {
    // Hide keyboard
    [self.addListView.textField resignFirstResponder];
    
    // Hide Add List View
    [self.addListView setShowingColorTag:NO completion:^{
        
        [UIView animateWithDuration:duration animations:^{
            self.addListView.bottom = self.header.bottom;
            self.shadowView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self.addListView.hidden = YES;
        }];
        
        // Show Add button
        [UIView transitionWithView:self.header.addButton duration:0.4 options:hidingAnimation animations:^{
            self.header.addButton.hidden = NO;
        } completion:nil];
    }];
}

- (BOOL)isAddListViewShown {
    return self.header.addButton.hidden;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.addListView.textField) {
        // Add List View text field
        
        if (textField.text.isEmpty) {
            // Hide Add List View
            [self hideAddListView];
        }
        else {
            // Save new list
            [ListsManager saveListWithTitle:textField.text onPosition:[self.tableView.indexPathsForVisibleRows firstObject].row];
            
            // Hide and clear Add List View
            [self hideAddListView];
            self.addListView.textField.text = @"";
            
            // Update table view
            [self.lists performFetch];
            [self.tableView reloadData];
        }
    }
    return YES;
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

@end
