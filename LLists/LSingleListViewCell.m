//
//  LSingleListViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSingleListViewCell.h"
#import "LDoneButton.h"
#import "LItemCellRightSwipeView.h"

static NSString *const reuseIdentifier = @"singleListViewCell";

@interface LSingleListViewCell () <LDoneButtonDelegate>

@property (nonatomic, strong) LDoneButton *doneButton;
@property (nonatomic, strong) LItemCellRightSwipeView *swipeView;

@end

@implementation LSingleListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Item View
    self.itemView = [[LItemCellView alloc] initFullInSuperview:self.contentView];
    self.mainView = self.itemView;
    
    // Right Swipe View
    self.swipeView = [[LItemCellRightSwipeView alloc] initInSuperview:self.contentView edge:UIViewEdgeRight length:[LItemCellRightSwipeView width] insets:inset_right(-[LItemCellRightSwipeView width])];
    self.rightSwipeView = self.swipeView;
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.itemView edge:UIViewEdgeLeft length:kSingleListCellLeftViewWidth insets:i(0, 0, 1, 2)];
    self.doneButton.delegate = self;
    
    // Text View
    self.itemView.textView.userInteractionEnabled = NO;
    
    // Delete Button
    [self.swipeView.deleteButton addTarget:self action:@selector(didPressDeleteButton)];
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    LTextView *sampleTextView = [[LTextView alloc] initWithSize:s(screenWidth - kSingleListCellLeftViewWidth, 0)];
    sampleTextView.font = F_MAIN_TEXT;
    
    CGFloat height = [sampleTextView heightForText:text] + 1;
    return height > kSingleListCellMinHeight ? height : kSingleListCellMinHeight;
}

- (CGRect)getTextViewFrame {
    return rect_origin(p(self.itemView.textView.left, self.frame.origin.y + self.itemView.textView.frame.origin.y), self.itemView.textView.size);
}

- (void)setItem:(Item *)item {
    _item = item;
    
    self.itemView.textView.text = item.text;
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

#pragma mark - Delete List

- (void)didPressDeleteButton {
    if (self.delegate) {
        [self.delegate didPressDeleteButtonForCell:self];
    }
}

@end
