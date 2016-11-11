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
    self.rightSwipeView = [[UIView alloc] init];
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.itemView edge:UIViewEdgeLeft length:kCellLeftViewWidth insets:inset_left(2)];
    self.doneButton.delegate = self;
    
    // Text View
    self.itemView.textView.userInteractionEnabled = NO;
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    LSingleListViewCell *cell = [[LSingleListViewCell alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    CGFloat height = [cell.itemView.textView heightForText:text] + kSeparatorBottomLineHeight;
    return height >= kSingleListViewCellMinHeight ? height : kSingleListViewCellMinHeight + kSeparatorBottomLineHeight;
}

- (CGRect)getTextViewFrame {
    CGFloat height = self.itemView.textView.height < self.height ? self.itemView.textView.height : self.itemView.height;
    return r(self.itemView.textView.left, self.frame.origin.y + self.itemView.textView.frame.origin.y, self.itemView.textView.width, height);
}

- (void)setItem:(Item *)item {
    _item = item;
    self.itemView.textView.text = item.text;
}

- (void)setTextViewShowing:(BOOL)showing {
    self.itemView.textView.hidden = !showing;
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

@end
