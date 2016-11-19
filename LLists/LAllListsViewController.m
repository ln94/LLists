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


@interface LAllListsViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate, LSwipeCellDelegate>

@property (nonatomic) NSFetchedResultsController<List *> *lists;

@property (nonatomic) UIAlertController *deleteListAlert;

@property (nonatomic) List *movingList;
@property (nonatomic) LScrollTimer *scrollTimer;

@end


@implementation LAllListsViewController {
    BOOL addListAnimationInProgress;
    BOOL cellMovingInProgress;
    CGFloat maxScrollTouchOffset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Header
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
    
    // Empty View
    self.emptyView.text = @"Your List of Lists is empty";
    
    // Add List View
    self.addView.textField.delegate = self;
    
    // Delete List Alert
    self.deleteListAlert = [UIAlertController alertControllerWithTitle:@"Delete List" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Hide swiped cell
        if (self.swipedCell) {
            self.swipedCell.swiped = NO;
        }
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
    addListAnimationInProgress = NO;
    cellMovingInProgress = NO;
    
//    [self.view bringSubviewToFront:self.header];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.emptyView.hidden = self.lists.numberOfObjects;
    self.longPress.enabled = self.lists.numberOfObjects;
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
    
    return cell;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    self.emptyView.hidden = self.lists.numberOfObjects;
    self.longPress.enabled = self.lists.numberOfObjects;
}


#pragma mark - Add / Delete List

- (void)addObjectOnPosition:(NSInteger)position {
    // Save new list
    self.addView.colorTag.color = C_RANDOM;
    [ListsManager saveListWithTitle:self.addView.textField.text
                              color:self.addView.colorTag.color
                         onPosition:position];
}

#pragma mark - Delete List

- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell {
    // Show alert
    self.deleteListAlert.message = string(@"Are you sure you want to delete list '%@'?", ((LAllListsViewCell *)cell).list.title);
    [self presentViewController:self.deleteListAlert animated:YES completion:nil];
}

- (void)deleteList {
    [ListsManager deleteList:((LAllListsViewCell *)self.swipedCell).list completion:nil];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == self.addView.textField) {
        if (textField.text.isEmpty) {
            // Shake cell
        }
        else {
            // Add List
            [self addObject];
        }
    }
    else {
        // Editing Cell
    }
    
    return YES;
}


#pragma mark - Tap

- (void)didTapCell:(LTableViewCell *)cell {
    if (cell.swiped) {
        cell.swiped = NO;
    }
    else {
        // Hide swiped cell
        if (self.swipedCell) {
            self.swipedCell.swiped = NO;
        }
        
        [UIView transitionWithView:cell.contentView duration:kAnimationDurationTiny options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            cell.contentView.backgroundColor = C_SELECTED;
        } completion:^(BOOL finished) {
            // Open Single List screen
            LSingleListViewController *vc = [[LSingleListViewController alloc] initWithList:((LAllListsViewCell *)cell).list];
            [self presentViewController:vc animated:YES completion:^{
                cell.contentView.backgroundColor = C_CLEAR;
            }];
        }];
    }
}


#pragma mark - Long Press

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress {
    // Move cell within the table
    
    switch (longPress.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            cellMovingInProgress = YES;
            
            self.view.userInteractionEnabled = NO;
            
            // Hide swiped cell
            if (self.swipedCell) {
                self.swipedCell.swiped = NO;
            }
            
            // Update moving cell
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[longPress locationInView:self.tableView]];
            LAllListsViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            self.movingList = cell.list;
            
            [UIView animateWithDuration:kAnimationDurationTiny animations:^{
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
            
            self.view.userInteractionEnabled = YES;
            
            // Stop Scroll Timer
            if (self.scrollTimer.isValid) {
                [self.scrollTimer stop];
            }
            
            // Update moving cell
            [UIView animateWithDuration:kAnimationDurationTiny animations:^{
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
