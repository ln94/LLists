//
//  LSingleListViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSingleListViewCell.h"
#import "LDoneButton.h"

static NSString *const reuseIdentifier = @"singleListViewCell";

@interface LSingleListViewCell () <LDoneButtonDelegate>

@property (nonatomic) UITextView *textView;
@property (nonatomic) LDoneButton *doneButton;

@end

@implementation LSingleListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.contentView edge:UIViewEdgeLeft length:kDoneButtonLength + kPaddingMed];
    self.doneButton.delegate = self;
    
    // Text View
    self.textView = [[UITextView alloc] initFullInSuperview:self.contentView insets:inset_left(self.doneButton.right)];
    self.textView.font = F_MAIN_TEXT;
    self.textView.textColor = C_MAIN_TEXT;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.textContainerInset = i(kTextContainerInsetY, kPaddingTiny, kTextContainerInsetY, 0);
    self.textView.userInteractionEnabled = NO;
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    LSingleListViewCell *cell = [[LSingleListViewCell alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    return [cell textViewHeightForText:text] + 2 * kTextContainerInsetY;
}

- (CGFloat)textViewHeightForText:(NSString *)text {
    
    if (text.isEmpty)
        text = @"A";
    
    CGRect rect = [text boundingRectWithSize:s(self.textView.width + 20, 1000) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:F_MAIN_TEXT} context:nil];
    
    return rect.size.height;
}

- (CGRect)textViewFrame {
    return rect_origin(p(self.textView.left, self.frame.origin.y), self.textView.size);
}

- (void)setText:(NSString *)text forEditingCell:(BOOL)editing {
    self.textView.text = text;
    
    // If editing, scroll to bottom
    if (self.textView.contentSize.height > self.textView.height) {
        [self.textView setContentOffset:p(0, editing ? self.textView.contentSize.height - self.textView.height : 0) animated:(editing ? NO : YES)];
    }
}

- (void)setItem:(Item *)item {
    _item = item;
    [self setText:item.text forEditingCell:NO];
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

@end
