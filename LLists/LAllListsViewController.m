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
#import "LScrollTimer.h"


@interface LAllListsViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate, LShadowViewDelegate, LSwipeCellDelegate>

@property (nonatomic) NSFetchedResultsController<List *> *lists;

@property (nonatomic) LAddListView *addListView;

@property (nonatomic) LTableViewCell *swipedCell;

@property (nonatomic) UIAlertController *deleteListAlert;

@property (nonatomic) List *movingList;
@property (nonatomic) UIView *movingCellSnapshot;
@property (nonatomic) LScrollTimer *scrollTimer;

@end


@implementation LAllListsViewController {
    BOOL addViewAnimationInProgress;
    BOOL cellMovingInProgress;
    CGFloat maxScrollTouchOffset;
}

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
    self.tableView.rowHeight = kAllListsCellHeight;
    [self.tableView registerClass:[LAllListsViewCell class] forCellReuseIdentifier:[LAllListsViewCell reuseIdentifier]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Shadow View
    self.shadowView.delegate = self;
    
    // Empty View
    self.emptyView.text = @"List of Lists is empty";
    
    // Add List View
    self.addListView = [[LAddListView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kAllListsCellHeight insets:inset_top(LLists.statusBarHeight)];
    self.addListView.hidden = YES;
    self.addListView.textField.delegate = self;
    
    // Delete List Alert
    self.deleteListAlert = [UIAlertController alertControllerWithTitle:@"Delete List" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self unswipeCell];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self deleteList];
    }];
    [self.deleteListAlert addAction:cancelAction];
    [self.deleteListAlert addAction:deleteAction];
    
    // Scroll Timer
    maxScrollTouchOffset = kAllListsCellHeight / 2;
    self.scrollTimer = [[LScrollTimer alloc] initWithScrollingTableView:self.tableView andMaxTouchOffset:maxScrollTouchOffset];
    
    // Variables
    addViewAnimationInProgress = NO;
    cellMovingInProgress = NO;
    
    [self.view bringSubviewToFront:self.header];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.lists.numberOfObjects) {
        self.emptyView.hidden = NO;
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
    cell.list = [self.lists objectAtIndexPath:indexPath];
//    cell.moving = cell.list == self.movingList;
    cell.delegate = self;
    
    return cell;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

    // Table animation
    switch (type) {
        case NSFetchedResultsChangeInsert:{
            
        }
            break;
            
        case NSFetchedResultsChangeDelete:{
            
        }
            break;
            
        case NSFetchedResultsChangeMove:{
            
        }
            break;
            
        case NSFetchedResultsChangeUpdate:{
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide keyboard
    [self.tableView endEditing:YES];
    
    // Hide swiped view
    [self unswipeCell];
    
    // Open Add List view if scrolled at the top
    if (!scrollView.isDecelerating && scrollView.contentOffset.y < -kPaddingSmall && self.header.showingAddButton) {
        [self showAddListView];
    }
}


#pragma mark - Add List

- (void)didPressAddButton {
    [self showAddListView];
}

- (void)showAddListView {
    if (!addViewAnimationInProgress) {
        addViewAnimationInProgress = YES;
        
        // Hide swiped cell
        [self unswipeCell];
        
        // Hide Add Button
        [self.header setShowingAddButton:NO];
        
        // Show Add List View
        self.addListView.hidden = NO;
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.addListView.top = self.header.bottom;
            self.shadowView.hidden = NO;
            
        } completion:^(BOOL finished) {
            [self.addListView animateColorTagShowing:YES completion:^{
                // Show keyboard
                run_main(^{
                    [self.addListView.textField becomeFirstResponder];

                    addViewAnimationInProgress = NO;
                });
            }];
            
            // Disable Table View scrolling
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.tableView.scrollEnabled = NO;
            }];
        }];
    }
}

- (void)hideAddListView:(void (^)())completion {
    if (!addViewAnimationInProgress) {
        addViewAnimationInProgress = YES;
        
        // Hide keyboard
        [self.addListView.textField resignFirstResponder];
        
        // Hide Add List View
        [self.addListView animateColorTagShowing:NO completion:^{
            
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.addListView.bottom = self.header.bottom;
                self.shadowView.hidden = YES;
                
            } completion:^(BOOL finished) {
                self.addListView.hidden = YES;
                addViewAnimationInProgress = NO;
                
                // Enable Table View scrolling
                self.tableView.scrollEnabled = YES;
                
                if (completion) {
                    completion();
                }
            }];
            
            // Show Add button
            [self.header setShowingAddButton:YES];
        }];
    }
}

- (void)addList {
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

#pragma mark - Add / Delete List

- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell {
    // Show alert
    self.deleteListAlert.message = string(@"Are you sure you want to delete list '%@'?", ((LAllListsViewCell *)cell).list.title);
    [self presentViewController:self.deleteListAlert animated:YES completion:nil];
}

- (void)deleteList {
    [ListsManager deleteList:((LAllListsViewCell *)self.swipedCell).list completion:nil];
    [self unswipeCell];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.addListView.textField) {
        // Add List
        [self addList];
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
//    else {
//        [self addList];
//    }
}

- (void)shadowViewDidSwipeDown {
    if (self.addListView.textField.text.isEmpty) {
        [self hideAddListView:nil];
    }
    else {
        [self addList];
    }
}


#pragma mark - Swipe

- (void)didSwipeCell:(LTableViewCell *)cell {
    // Hide previously swiped cell
    [self unswipeCell];
    self.swipedCell = cell.swiped ? cell : nil;
}

- (void)unswipeCell {
    if (self.swipedCell) {
        self.swipedCell.swiped = NO;
        self.swipedCell = nil;
    }
}


#pragma mark - Tap

- (void)didTapCell:(LTableViewCell *)cell {
    // Hide swiped cell
    [self unswipeCell];
    
    cell.backgroundColor = C_SELECTED;
    
    // Open Single List screen
    LSingleListViewController *vc = [[LSingleListViewController alloc] initWithList:((LAllListsViewCell *)cell).list];
    [self presentViewController:vc animated:YES completion:^{
        cell.backgroundColor = C_CLEAR;
    }];
}


#pragma mark - Long Press

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress {
    // Move cell within the table
    
    switch (longPress.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            cellMovingInProgress = YES;
            
            // Hide swiped cell
            [self unswipeCell];
            
            // Update moving cell
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[longPress locationInView:self.tableView]];
            LAllListsViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            self.movingList = cell.list;
            
            [UIView animateWithDuration:0.2 animations:^{
                cell.moving = YES;
                
            } completion:^(BOOL finished) {
                cellMovingInProgress = NO;
            }];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            // Get touch position
            CGFloat y = [longPress locationInView:self.tableView].y;
            
            // Get moving cell position
            LAllListsViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.lists indexPathForObject:self.movingList]];
            
            NSInteger row = [self.tableView indexPathForCell:cell].row;
            NSUInteger visibleIndex = [self.tableView.visibleCells indexOfObject:cell];
            LOG(@"- Row: %ld", row);
            LOG(@"- Visible Index: %ld", visibleIndex);
            
            if (row >= 0 && row < self.lists.numberOfObjects) {
                
                // Scroll table
                if (y < self.tableView.contentOffset.y + maxScrollTouchOffset && self.tableView.contentOffset.y > 0) {
                    
                    // Scroll up
                    CGFloat offset = y - self.tableView.contentOffset.y;
                    if (!self.scrollTimer.isValid) {
                        [self.scrollTimer startForScrollDirection:LScrollDirectionUp touchOffset:offset];
                    }
                    else {
                        [self.scrollTimer changeTimeIntervalForTouchOffset:offset];
                    }
                }
                else if (y > self.tableView.contentOffset.y + self.tableView.height - 2 * maxScrollTouchOffset && self.tableView.contentOffset.y + self.tableView.height < self.tableView.contentSize.height) {
                    
                    // Scroll down
                    CGFloat offset = self.tableView.contentOffset.y + self.tableView.height - y - maxScrollTouchOffset;
                    if (!self.scrollTimer.isValid) {
                        [self.scrollTimer startForScrollDirection:LScrollDirectionDown touchOffset:offset];
                    }
                    else {
                        [self.scrollTimer changeTimeIntervalForTouchOffset:offset];
                    }
                }
                else {
                    // Stop scrolling
                    if (self.scrollTimer.isValid) {
                        [self.scrollTimer stop];
                    }
                }
                
                // Move cell
                if (!cellMovingInProgress && visibleIndex > 0) {
                    
                    LOG(@"--- Move to previous");
                    // Compare to previous visible cell
                    LAllListsViewCell *prevCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
                    
                    if (y <= prevCell.centerY) {
                        
                        // Swap cells
                        cellMovingInProgress = YES;
                        
                        cell.list.indexValue -= 1;
                        prevCell.list.indexValue += 1;
                        
                        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] toIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
                        
                        cellMovingInProgress = NO;
                        
                        return;
                    }
                }
                
                if (!cellMovingInProgress && visibleIndex < self.tableView.visibleCells.count - 1) {
                    
                    // Compare to next visible cell
                    LAllListsViewCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:0]];
                    
                    if (y >= nextCell.centerY) {
                        
                        // Swap cells
                        cellMovingInProgress = YES;
                        
                        cell.list.indexValue += 1;
                        nextCell.list.indexValue -= 1;
                        
                        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] toIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:0]];
                        
                        cellMovingInProgress = NO;
                        return;
                    }
                }
            }
            else {
                // Invalid cell
                longPress.enabled = NO;
            }
            
        }
            break;
            
        default: {
            // Stop Scroll Timer
            if (self.scrollTimer.isValid) {
                [self.scrollTimer stop];
            }
            
            // Update moving cell
            [UIView animateWithDuration:kAnimationDuration animations:^{
                LAllListsViewCell *cell = [self.tableView cellForRowAtIndexPath:[self.lists indexPathForObject:self.movingList]];
                cell.moving = NO;
                
            } completion:^(BOOL finished) {
                self.movingList = nil;
                
                // Save changes
                [DataStore save];
                [self.tableView reloadData];
            }];
            
            // Enable GR
            if (!longPress.isEnabled) {
                longPress.enabled = YES;
            }
        }
            break;
    }
}


@end
