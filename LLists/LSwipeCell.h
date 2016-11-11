//
//  LSwipeCell.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSwipeCellDelegate;


@interface LSwipeCell : UITableViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *rightSwipeView;

@property (nonatomic) BOOL swiped;

@property (nonatomic) id<LSwipeCellDelegate> delegate;

@end


@protocol LSwipeCellDelegate <NSObject>

@required
- (void)didSwipeCell:(LSwipeCell *)cell;
- (void)didPressDeleteButtonForCell:(LSwipeCell *)cell;
- (void)didTapCell:(LSwipeCell *)cell;
- (void)didLongPress:(UILongPressGestureRecognizer *)longPress cell:(LSwipeCell *)cell;

@end
