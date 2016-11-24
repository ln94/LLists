//
//  LAllListsViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewCell.h"
#import "LListCellView.h"
#import "LListCellRightSwipeView.h"

static NSString *const reuseIdentifier = @"allListsViewCell";


@interface LAllListsViewCell ()

//@property (nonatomic, strong) LListCellView *listView;
@property (nonatomic, strong) LListCellRightSwipeView *swipeView;

@end


@implementation LAllListsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    // List View
//    self.listView = [[LListCellView alloc] initFullInSuperview:self.contentView];
//    self.mainView = self.listView;
    
    // Right Swipe View
    self.swipeView = [[LListCellRightSwipeView alloc] initInSuperview:self.contentView edge:UIViewEdgeRight length:[LListCellRightSwipeView width] insets:inset_right(-[LListCellRightSwipeView width])];
    self.rightSwipeView = self.swipeView;
    
    // Text Field
    self.mainView.textField.placeholder = @"List Title";
    self.mainView.textField.userInteractionEnabled = NO;
    
    // Delete Button
    [self.swipeView.deleteButton addTarget:self action:@selector(didPressDeleteButton)];
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

- (void)setMoving:(BOOL)moving {
    [super setMoving:moving];
    
    self.mainView.colorTag.left = moving ? kPaddingSmall + kMovingCellLeftOffset : kPaddingSmall;
    self.mainView.textField.left = moving ? kAllListsCellLeftViewWidth + kMovingCellLeftOffset : kAllListsCellLeftViewWidth;
}

#pragma mark - Setters

- (void)setList:(List *)list {
    _list = list;
    self.mainView.textField.text = list.title;
    self.mainView.colorTag.color = list.color;
}

#pragma mark - Delete List

- (void)didPressDeleteButton {
    if (self.delegate) {
        [self.delegate didPressDeleteCell:self];
    }
}

@end
