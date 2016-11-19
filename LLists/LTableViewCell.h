//
//  LTableViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTableCellDelegate;


@interface LTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *rightSwipeView;

@property (nonatomic) BOOL swiped;
@property (nonatomic) BOOL moving;

@property (nonatomic) id<LTableCellDelegate> delegate;

+ (Class)classForType:(LTableType)type;
+ (NSString *)reuseIdentifierForType:(LTableType)type;
+ (NSString *)reuseIdentifier;

@end


@interface LPlaceholderTableViewCell : LTableViewCell

@end


@protocol LTableCellDelegate <NSObject>

@required
- (void)didSwipeCell:(LTableViewCell *)cell;
- (void)didPressDeleteButtonForCell:(LTableViewCell *)cell;
- (void)didTapCell:(LTableViewCell *)cell;

@end

