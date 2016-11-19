//
//  LTableViewController.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewController.h"
#import "LTransition.h"
#import "LAllListsViewController.h"
#import "LSingleListViewController.h"
#import "LAllListsViewCell.h"

#pragma clang diagnostic ignored "-Wincompatible-pointer-types"


#pragma mark - Class

@interface LTableViewController () <LTableCellDelegate, LShadowViewDelegate>

@property (nonatomic, strong) LTransition *transition;

@end

@implementation LTableViewController

+ (id)alloc {
    if ([self class] == [LTableViewController class]) {
        LPlaceholderTableViewController *placeholder = [LPlaceholderTableViewController alloc];
        return placeholder;
    }
    else {
        return [super alloc];
    }
}

- (instancetype)initForType:(LTableType)type {
    self = [super init];
    if (!self) return nil;
    
    self.type = type;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_WHITE;
    
    // Transition
    self.transition = [[LTransition alloc] init];
    self.transitioningDelegate = self.transition;
    
    // Header
    self.header = [[LHeaderView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kHeaderViewHeight];
    [self.header.addButton addTarget:self action:@selector(showAddView)];
    
    // Table View
    self.tableView = [[UITableView alloc] initFullInSuperview:self.view insets:inset_top(self.header.bottom)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
    [self.tableView registerClass:[LTableViewCell classForType:self.type] forCellReuseIdentifier:[LTableViewCell reuseIdentifierForType:self.type]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Empty View
    self.emptyView = [[LEmptyView alloc] initInTableView:self.tableView forType:self.type];
    
    // Shadow View
    self.shadowView = [[LShadowView alloc] initFullInSuperview:self.tableView];
    self.shadowView.delegate = self;
    
    // Add View
    self.addView = [[LAddView alloc] initInSuperview:self.view forType:LTableTypeList];
    
    // Delete Alert
    self.deleteAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Hide swiped cell
        self.swipedCell.swiped = NO;
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self animateDeleteObject];
    }];
    [self.deleteAlert addAction:cancelAction];
    [self.deleteAlert addAction:deleteAction];
    
    // GR
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    self.longPress.minimumPressDuration = 0.2;
    self.longPress.allowableMovement = 1000;
    [self.tableView addGestureRecognizer:self.longPress];
    
    // Variables
    deletingInProgress = NO;
    cellMovingInProgress = NO;
    
    [self.view bringSubviewToFront:self.header];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide keyboard
    [self.tableView endEditing:YES];
    
    // Hide swiped view
    self.swipedCell.swiped = NO;
    
    // Open Add List view if scrolled at the top
    if (!scrollView.isDecelerating && scrollView.contentOffset.y < -kPaddingSmall && !self.header.addButton.hidden) {
        [self showAddView];
    }
}

#pragma mark - Add Object

- (void)showAddView {
    // Hide swiped cell and Add Button, show Shadow View
    self.swipedCell.swiped = NO;
    self.header.addButton.hidden = YES;
    self.shadowView.hidden = NO;
    
    [self.addView setState:LAddViewStateShow completion:^{
        
        // Disable Table View scrolling
        [UIView animateWithDuration:kAnimationDurationSmall animations:^{
            self.tableView.scrollEnabled = NO;
        }];
    }];
}

- (void)hideAddView {
    // Show Add button and hide Shadow View
    self.header.addButton.hidden = NO;
    self.shadowView.hidden = YES;
    
    [self.addView setState:LAddViewStateHide completion:^{
        
        // Enable Table View scrolling
        self.tableView.scrollEnabled = YES;
    }];
}

- (void)animateAddObject {
    NSInteger row = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
    
    // Save new object
    [self addObject];
    
    // Hide Shadow View and show Add Button
    self.shadowView.hidden = YES;
    self.header.addButton.hidden = NO;
    
    // Animate Add View
    [self.addView setState:LAddViewStateAdd completion:nil];
    
    // Animate Table View
    [UIView animateWithDuration:kAnimationDurationMed animations:^{
        // Move Table View cells down
        CGFloat offset = self.tableView.contentOffset.y - [self.tableView.visibleCells firstObject].top;
        for (LTableViewCell *cell in self.tableView.visibleCells) {
            cell.top += offset + kAllListsCellHeight;
        }
        
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        self.tableView.scrollEnabled = YES;
        [self.addView reset];
    }];
}


#pragma mark - Delete Object

- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell {
    [self presentViewController:self.deleteAlert animated:YES completion:nil];
}

- (void)animateDeleteObject {
    deletingInProgress = YES;
    
    NSInteger row = [self.tableView indexPathForCell:self.swipedCell].row;
    CGFloat offset = self.swipedCell.height;
    
    // Hide swiped cell
    self.swipedCell.swiped = NO;
    
    // Delete object
    [self deleteObject];
    
    // Animate Table View
    [UIView animateWithDuration:kAnimationDurationMed delay:kAnimationDurationMed options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        // Move Table View cells up
        for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
            if (indexPath.row > row) {
                LTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                cell.top -= offset;
            }
            
            if (indexPath == [self.tableView.indexPathsForVisibleRows lastObject]) {
                LTableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
                if (nextCell) {
                    nextCell.top -= offset;
                }
            }
        }
        
    } completion:^(BOOL finished) {
        
        [self.tableView reloadData];
        self.swipedCell = nil;
        
        deletingInProgress = NO;
    }];
    
}

#pragma mark - LShadowViewDelegate

- (void)shadowViewDidSwipeUp {
    [self hideAddView];
}

- (void)shadowViewDidSwipeDown {
    if (self.addView.isEmpty) {
        [self hideAddView];
    }
    else {
        [self animateAddObject];
    }
}

- (void)shadowViewDidTap {
    [self shadowViewDidSwipeDown];
}


#pragma mark - Swipe

- (void)didSwipeCell:(LTableViewCell *)cell {

    if (cell.swiped) {
        // Hide previously swiped cell
        self.swipedCell.swiped = NO;
        self.swipedCell = cell;
    }
    else if (deletingInProgress) {
        // Hide deleting cell
        self.swipedCell.hidden = YES;
    }
}

@end



#pragma mark - Placeholder

@implementation LPlaceholderTableViewController

- (instancetype)init {
    return [self initForType:-1];
}

- (id)initForType:(LTableType)type {
    Class class = [self classForType:type];
    LTableViewController *instance = [(LTableViewController *)[class alloc] initForType:type];
    return instance;
}

- (Class)classForType:(LTableType)type {
    switch (type) {
        case LTableTypeList:
            return [LAllListsViewController class];
            
        case LTableTypeItem:
            return [LSingleListViewController class];
            
        default:
            return [LTableViewController class];
    }
}

@end
