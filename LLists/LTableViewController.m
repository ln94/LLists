//
//  LTableViewController.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewController.h"
#import "LTransition.h"

@interface LTableViewController ()

@property (nonatomic, strong) LTransition *transition;

@end

@implementation LTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = C_WHITE;
    
    // Transition
    self.transition = [[LTransition alloc] init];
    self.transitioningDelegate = self.transition;
    
    // Header
    self.header = [[LHeaderView alloc] initInSuperview:self.view edge:UIViewEdgeTop length:kHeaderViewHeight];
    
    // Table View
    self.tableView = [[UITableView alloc] initFullInSuperview:self.view insets:inset_top(self.header.bottom)];
    self.tableView.backgroundColor = C_WHITE;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelection = NO;
    
    // Shadow View
    self.shadowView = [[LShadowView alloc] initFullInSuperview:self.view insets:inset_top(self.tableView.top)];
    self.shadowView.hidden = YES;
    
    // Empty View
    self.emptyView = [[LEmptyView alloc] initFullInSuperview:self.tableView];
    self.emptyView.hidden = YES;
}

@end
