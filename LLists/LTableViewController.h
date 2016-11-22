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
#import "LScrollTimer.h"

@interface LTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    BOOL animationInProgress;
    CGFloat maxScrollTouchOffset;
}

@property (nonatomic) LTableType type;

@property (nonatomic) LHeaderView *header;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) LEmptyView *emptyView;
@property (nonatomic) LShadowView *shadowView;

@property (nonatomic) LAddView *addView;
@property (nonatomic) UIAlertController *deleteAlert;

@property (nonatomic) LTableViewCell *swipedCell;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic) LScrollTimer *scrollTimer;

- (id)initForType:(LTableType)type;

- (void)updateViews;

- (void)animateShowingAddView;
- (void)animateHidingAddView;
- (void)animateAddingObject;
- (void)animateDeletingObject;

- (void)addObject;
- (void)deleteObject;

- (void)didLongPress;

@end


@interface LPlaceholderTableViewController : LTableViewController

@end
