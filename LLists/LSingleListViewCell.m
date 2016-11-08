//
//  LSingleListViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSingleListViewCell.h"
#import "LDoneButton.h"
#import "LTextView.h"

static NSString *const reuseIdentifier = @"singleListViewCell";

@interface LSingleListViewCell () <LDoneButtonDelegate>

@property (nonatomic) LTextView *textView;
@property (nonatomic) LDoneButton *doneButton;

@end

@implementation LSingleListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.contentView edge:UIViewEdgeLeft length:kTextFieldLeftViewWidth insets:inset_bottom(kSeparatorHeight)];
    self.doneButton.delegate = self;
    
    // Text View
    self.textView = [[LTextView alloc] initFullInSuperview:self.contentView insets:i(0, 0, kSeparatorHeight, kTextFieldLeftViewWidth)];
    self.textView.font = F_MAIN_TEXT;
    self.textView.textColor = C_MAIN_TEXT;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.userInteractionEnabled = NO;

    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    LSingleListViewCell *cell = [[LSingleListViewCell alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    return [cell.textView heightForText:text] + kSeparatorHeight;
}

- (CGRect)textViewFrame {
    return rect_origin(p(self.textView.left, self.frame.origin.y), self.textView.size);
}

- (void)setItem:(Item *)item {
    _item = item;
    self.textView.text = item.text;
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

@end
