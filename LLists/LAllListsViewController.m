//
//  LAllListsViewController.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewController.h"
#import "LAllListsViewCell.h"
#import "LAddListView.h"
#import "LSingleListViewController.h"


@interface LAllListsViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate, LShadowViewDelegate, LSwipeCellDelegate>

@property (nonatomic) NSFetchedResultsController<List *> *lists;

@property (nonatomic) LAddListView *addListView;

@property (nonatomic) List *movingList;

@property (nonatomic) LSwipeCell *swipedCell;

@property (nonatomic) UIAlertController *deleteListAlert;

@end


@implementation LAllListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Header
    [self.header.addButton addTarget:self action:@selector(didPressAddButton)];
    self.header.backButton.hidden = YES;
    
    // Fetch Results Controller
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntity:[List class]];
    request.sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    self.lists = [NSFetchedResultsController fetchedResultsControllerWithFetchRequest:request];
    [self.lists performFetch];
    self.lists.delegate = self;
    
    // Table View
    self.tableView.rowHeight = kAllListsViewCellHeight;
    [self.tableView registerClass:[LAllListsViewCell class] forCellReuseIdentifier:[LAllListsViewCell reuseIdentifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Shadow View
    self.shadowView.delegate = self;
    
    // Empty View
    self.emptyView.text = @"List of Lists is empty";
    
    // Add List View
    self.addListView = [[LAddListView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsViewCellHeight insets:inset_top(LLists.statusBarHeight)];
    self.addListView.hidden = YES;
    self.addListView.textField.delegate = self;
    
    // Delete List Alert
    self.deleteListAlert = [UIAlertController alertControllerWithTitle:@"Delete List" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self unswipeCell];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [ListsManager deleteList:((LAllListsViewCell *)self.swipedCell).list completion:nil];
        [self unswipeCell];
    }];
    [self.deleteListAlert addAction:cancelAction];
    [self.deleteListAlert addAction:deleteAction];
    
    
    [self.view bringSubviewToFront:self.header];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.lists.numberOfObjects) {
        self.emptyView.hidden = NO;
    }
    [self.tableView reloadData];
}

#pragma mark - Actions

- (void)unswipeCell {
    if (self.swipedCell) {
        self.swipedCell.swiped = NO;
        self.swipedCell = nil;
    }
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
    cell.backgroundColor = C_CLEAR;
    cell.list = [self.lists objectAtIndexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide keyboard
    [self.tableView endEditing:YES];
    
    // Hide swiped view
    [self unswipeCell];
    
    // Open Add List view if scrolled at the top
    if (scrollView.contentOffset.y < -kPaddingSmall && self.header.showingAddButton) {
        [self showAddListView];
    }
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - Add List

- (void)didPressAddButton {
    [self showAddListView];
}

- (void)showAddListView {
    // Hide Add Button
    [self.header setShowingAddButton:NO];
    
    // Show Add List View
    self.addListView.hidden = NO;

    [UIView animateWithDuration:addViewAnimationDuration animations:^{
        self.addListView.top = self.header.bottom;
        self.shadowView.hidden = NO;
        
    } completion:^(BOOL finished) {
        
        [self.addListView animateColorTagShowing:YES completion:^{
            // Show keyboard
            run_main(^{
                [self.addListView.textField becomeFirstResponder];
            });
        }];
    }];
}

- (void)hideAddListView:(void (^)())completion {
    // Hide keyboard
    [self.addListView.textField resignFirstResponder];
    
    // Hide Add List View
    [self.addListView animateColorTagShowing:NO completion:^{
        
        [UIView animateWithDuration:addViewAnimationDuration animations:^{
            self.addListView.bottom = self.header.bottom;
            self.shadowView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self.addListView.hidden = YES;
            
            if (completion) {
                completion();
            }
        }];
        
        // Show Add button
        [self.header setShowingAddButton:YES];
    }];
}

- (void)addNewList {
    if (!self.addListView.textField.text.isEmpty) {
        // Save new list
        NSInteger position = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
        [ListsManager saveListWithTitle:self.addListView.textField.text onPosition:position];
        
        // Hide and clear Add List View
        [self hideAddListView:^{
            self.addListView.textField.text = @"";
        }];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.addListView.textField) {
        // Add List
        [self addNewList];
    }
    
    return YES;
}


#pragma mark - LShadowViewDelegate

- (void)shadowViewDidSwipeUp {
    [self hideAddListView:nil];
}

- (void)shadowViewDidTap {
    if (self.addListView.textField.text.isEmpty) {
        [self hideAddListView:nil];
    }
    else {
        [self addNewList];
    }
}

- (void)shadowViewDidSwipeDown {
    if (self.addListView.textField.text.isEmpty) {
        [self hideAddListView:nil];
    }
    else {
        [self addNewList];
    }
}


#pragma mark - LSwipeCellDelegate

- (void)didSwipeCell:(LSwipeCell *)cell {
    // Hide previously swiped cell
    [self unswipeCell];
    self.swipedCell = cell.swiped ? cell : nil;
}

- (void)didPressDeleteButtonForCell:(LSwipeCell *)cell {
    // Show alert
    self.deleteListAlert.message = string(@"Are you sure you want to delete list '%@'?", ((LAllListsViewCell *)self.swipedCell).list.title);
    [self presentViewController:self.deleteListAlert animated:YES completion:nil];
}

- (void)didTapCell:(LSwipeCell *)cell {
    cell.backgroundColor = C_SELECTED;
    
    // Open Single List screen
    LSingleListViewController *vc = [[LSingleListViewController alloc] initWithList:((LAllListsViewCell *)cell).list];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress cell:(LSwipeCell *)cell {
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

@end
