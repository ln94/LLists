//
//  LTableViewController.h
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHeaderView.h"
#import "LEmptyView.h"

@interface LTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) LHeaderView *header;

@property (nonatomic) UITableView *tableView;

@property (nonatomic) UIView *shadowView;

@property (nonatomic) LEmptyView *emptyView;

@end
