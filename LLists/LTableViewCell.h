//
//  LTableViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSwipeCellDelegate;


@interface LTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *rightSwipeView;

@property (nonatomic) BOOL swiped;
@property (nonatomic) BOOL moving;

@property (nonatomic) id<LSwipeCellDelegate> delegate;

@end


@protocol LSwipeCellDelegate <NSObject>

@required
- (void)didSwipeCell:(LTableViewCell *)cell;
- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell;
- (void)didTapCell:(LTableViewCell *)cell;

@end
