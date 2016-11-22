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
    self.header = [[LHeaderView alloc] initInSuperview:self.view];
    [self.header.addButton addTarget:self action:@selector(animateShowingAddView) forControlEvents:UIControlEventTouchUpInside];
    
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
    self.shadowView = [[LShadowView alloc] initFullInSuperview:self.view insets:inset_top(self.tableView.top)];
    self.shadowView.delegate = self;
    
    // Add View
    self.addView = [[LAddView alloc] initInSuperview:self.view forType:LTableTypeList];
    [self.addView.addButton addTarget:self action:@selector(animateAddingObject)];
    
    // Delete Alert
    self.deleteAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Hide swiped cell
        [self.swipedCell setSwiped:NO animated:YES];
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self animateDeletingObject];
    }];
    [self.deleteAlert addAction:cancelAction];
    [self.deleteAlert addAction:deleteAction];
    
    // GR
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress)];
    self.longPress.minimumPressDuration = 0.2;
    self.longPress.allowableMovement = 1000;
    [self.tableView addGestureRecognizer:self.longPress];
    
    // Variables
    animationInProgress = NO;
    
    [self.view bringSubviewToFront:self.header];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.emptyView.hidden) {
        run_delayed(0.25, ^{
            [self animateShowingAddView];
        });
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide keyboard
    [self.tableView endEditing:YES];
    
    // Hide swiped view
    [self.swipedCell setSwiped:NO animated:YES];
    
    // Open Add List view if scrolled at the top
    if (!scrollView.isDecelerating && scrollView.contentOffset.y < -kPaddingSmall && !self.header.addButton.hidden && !animationInProgress) {
        [self animateShowingAddView];
    }
}

#pragma mark - Show / Hide Add View

- (void)animateShowingAddView {
    if (!animationInProgress) {
        animationInProgress = YES;
        
        // Hide Swiped cell and Add Button
        [self.swipedCell setSwiped:NO animated:YES];
        [self.header.addButton setHidden:YES animated:YES];
        
        // Show Shadow View and Add View
        [self.shadowView setHidden:NO animated:YES];
        [self.addView animateShowing:^{
            
            // Smoothly disable Table View scrolling
            [UIView animateWithDuration:kAnimationDurationMed animations:^{
                self.tableView.scrollEnabled = NO;
            }];
            
            animationInProgress = NO;
        }];
    }
}

- (void)animateHidingAddView {
    if (!animationInProgress) {
        animationInProgress = YES;
        
        // Show Add Button
        [self.header.addButton setHidden:NO animated:YES];
        
        // Hide Shadow View and Add View
        [self.shadowView setHidden:YES animated:YES];
        [self.addView animateHiding:^{
            
            // Enable Table View scrolling
            self.tableView.scrollEnabled = YES;
            
            animationInProgress = NO;
        }];
    }
}

#pragma mark - Add / Delete Object

- (void)animateAddingObject {
    if (self.addView.textView.text.isEmpty) {
        [self animateHidingAddView];
    }
    else if (!animationInProgress) {
        animationInProgress = YES;
        
        // Save new object
        [self addObject];
        
        // Animate Add View
        [self.addView animateAdding:nil];
        
        // Hide Shadow View
        [self.shadowView setHidden:YES animated:YES];
        
        // Show Add Button
        [self.header.addButton setHidden:NO animated:YES];
        
        // Move all visible Table View cells down
        NSInteger row = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
        [UIView animateWithDuration:kAnimationDurationMed animations:^{
            CGFloat offset = self.tableView.contentOffset.y - [self.tableView.visibleCells firstObject].top;
            for (LTableViewCell *cell in self.tableView.visibleCells) {
                cell.top += offset + kAllListsCellHeight;
            }
            
        } completion:^(BOOL finished) {
            
            // Update Table View
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            self.tableView.scrollEnabled = YES;
            
            // Reset Add View
            [self.addView reset];
            
            animationInProgress = NO;
        }];
    }
}

- (void)animateDeletingObject {
    if (!animationInProgress) {
        animationInProgress = YES;
        
        // Delete object
        [self deleteObject];
        
        // Hide Swiped Cell
        [self.swipedCell setSwiped:NO animated:YES completion:^{
            [self.swipedCell setHidden:YES animated:YES];
            
            // Move Table View cells up
            NSInteger row = [self.tableView indexPathForCell:self.swipedCell].row;
            CGFloat offset = self.swipedCell.height;
            [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                
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
                
                animationInProgress = NO;
            }];
        }];
    }
}

#pragma mark - LShadowViewDelegate

- (void)shadowViewDidSwipeUp {
    [self animateHidingAddView];
}

- (void)shadowViewDidSwipeDown {
    [self animateAddingObject];
}

- (void)shadowViewDidTap {
    [self animateAddingObject];
}


#pragma mark - LTableCellDelegate

- (void)didSwipeCell:(LTableViewCell *)cell {

    if (cell.swiped) {
        // Hide previously swiped cell
        [self.swipedCell setSwiped:NO animated:YES];
        self.swipedCell = cell;
    }
}

- (void)didPressDeleteCell:(LTableViewCell *)cell {
    [self presentViewController:self.deleteAlert animated:YES completion:nil];
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
