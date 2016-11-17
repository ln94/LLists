//
//  LSingleListViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSingleListViewCell.h"
#import "LItemCellView.h"
#import "LDoneButton.h"

static NSString *const reuseIdentifier = @"singleListViewCell";

@interface LSingleListViewCell () <LDoneButtonDelegate>

@property (nonatomic) LItemCellView *itemView;
@property (nonatomic) LDoneButton *doneButton;
@property (nonatomic, strong) UIView *separator;

@end

@implementation LSingleListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Item View
    self.itemView = [[LItemCellView alloc] initFullInSuperview:self.contentView insets:inset_bottom(1)];
    self.mainView = self.itemView;
    
    // Right Swipe View
    self.rightSwipeView = [[UIView alloc] init];
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.itemView edge:UIViewEdgeLeft length:kSingleListCellLeftViewWidth insets:inset_left(2)];
    self.doneButton.delegate = self;
    
    // Text View
    self.itemView.textView.userInteractionEnabled = NO;
    
    // Separator
    self.separator = [[UIView alloc] initInSuperview:self.itemView edge:UIViewEdgeBottom length:kSeparatorSingleHeight];
    self.separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    LSingleListViewCell *cell = [[LSingleListViewCell alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    CGFloat height = ceilf([cell.itemView.textView heightForText:text] + 1);
    return height > kSingleListCellMinHeight ? height : kSingleListCellMinHeight;
}

- (CGRect)getTextViewFrame {
    [self updateViews];
    self.itemView.textView.textColor = C_CLEAR;
    return r(self.itemView.textView.left, self.frame.origin.y + self.itemView.textView.frame.origin.y, self.itemView.textView.width, self.itemView.textView.height);
}

- (void)setItem:(Item *)item {
    _item = item;
    
    self.itemView.textView.text = item.text;
    self.itemView.textView.height = [self.itemView.textView heightForText:self.itemView.textView.text];
    [self.itemView centerTextView];
    
    self.itemView.textView.textColor = C_MAIN_TEXT;
}

- (void)updateViews {

    [self.itemView setEdge:UIViewEdgeTop length:self.contentView.height - 1];
    self.itemView.textView.height = [self.itemView.textView heightForText:self.itemView.textView.text];
    [self.itemView centerTextView];
    
    [self.separator setEdge:UIViewEdgeBottom length:kSeparatorSingleHeight insets:inset_bottom(0.1)];
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

@end
