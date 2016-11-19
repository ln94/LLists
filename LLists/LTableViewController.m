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

#pragma clang diagnostic ignored "-Wincompatible-pointer-types"


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
            return [NSObject class];
    }
}

@end


#pragma mark - Class

@interface LTableViewController () <LSwipeCellDelegate, LShadowViewDelegate>

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
    [self.header.addButton addTarget:self action:@selector(didPressAddButton)];
    
    // Table View
    self.tableView = [[UITableView alloc] initFullInSuperview:self.view insets:inset_top(self.header.bottom)];
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
//    [self.tableView registerClass:[LTableViewCell class] forCellReuseIdentifier:[LTableViewCell reuseIdentifier]];
    
    // Empty View
    self.emptyView = [[LEmptyView alloc] initFullInSuperview:self.tableView];
    self.emptyView.hidden = YES;
    
    // Shadow View
    self.shadowView = [[LShadowView alloc] initFullInSuperview:self.view insets:inset_top(self.tableView.top)];
    self.shadowView.delegate = self;
    self.shadowView.hidden = YES;
    
    // Add View
    self.addView = [[LAddView alloc] initInSuperview:self.view forType:LTableTypeList];
    
    // GR
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    self.longPress.minimumPressDuration = 0.2;
    self.longPress.allowableMovement = 1000;
    [self.tableView addGestureRecognizer:self.longPress];
    
    [self.view bringSubviewToFront:self.header];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Hide keyboard
    [self.tableView endEditing:YES];
    
    // Hide swiped view
    if (self.swipedCell) {
        self.swipedCell.swiped = NO;
    }
    
    // Open Add List view if scrolled at the top
    if (!scrollView.isDecelerating && scrollView.contentOffset.y < -kPaddingSmall && !self.header.addButton.hidden) {
        [self showAddView];
    }
}

#pragma mark - Add List

- (void)didPressAddButton {
    [self showAddView];
}

- (void)showAddView {
    // Hide swiped cell
    if (self.swipedCell) {
        self.swipedCell.swiped = NO;
    }
    
    // Hide Add Button
    self.header.addButton.hidden = YES;
    
    // Show Shadow View
    self.shadowView.hidden = NO;
    
    [self.addView setState:LAddViewStateShow completion:^{
        
        // Disable Table View scrolling
        [UIView animateWithDuration:kAnimationDurationSmall animations:^{
            self.tableView.scrollEnabled = NO;
        }];
    }];
}

- (void)hideAddView {
    // Show Add button
    self.header.addButton.hidden = NO;
    
    [self.addView setState:LAddViewStateHide completion:^{
        
        // Enable Table View scrolling
        self.tableView.scrollEnabled = YES;
    }];
    
    // Hide Shadow View
    self.shadowView.hidden = YES;
}

- (void)addObject {
    // Save new object
    NSInteger position = self.tableView.indexPathsForVisibleRows.count ? [self.tableView.indexPathsForVisibleRows firstObject].row : 0;
    [self addObjectOnPosition:position];
    
    // Hide Shadow View
    self.shadowView.hidden = YES;
    
    // Show Add Button
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
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        self.tableView.scrollEnabled = YES;
        [self.addView reset];
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
        [self addObject];
    }
}

- (void)shadowViewDidTap {
    [self shadowViewDidSwipeDown];
}

#pragma mark - Swipe

- (void)didSwipeCell:(LTableViewCell *)cell {

    if (cell.swiped) {
        // Hide previously swiped cell
        if (self.swipedCell) {
            self.swipedCell.swiped = NO;
        }
        self.swipedCell = cell;
    }
    else if (cell == self.swipedCell) {
        self.swipedCell = nil;
    }
}

@end
