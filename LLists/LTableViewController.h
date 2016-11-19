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
#import "LAddView.h"
#import "LShadowView.h"
#import "LTableViewCell.h"

@interface LTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) LTableType type;

@property (nonatomic) LHeaderView *header;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) LEmptyView *emptyView;
@property (nonatomic) LShadowView *shadowView;
@property (nonatomic) LAddView *addView;

@property (nonatomic) LTableViewCell *swipedCell;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

- (id)initForType:(LTableType)type;

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress;

- (void)showAddView;
- (void)hideAddView;
- (void)addObject;
- (void)addObjectOnPosition:(NSInteger)position;

@end


@interface LPlaceholderTableViewController : LTableViewController

@end
