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
    self.itemView.textView.userInteractionEnabled = NO;
    
    // Done Button
    self.doneButton = [[LDoneButton alloc] initInSuperview:self.itemView edge:UIViewEdgeLeft length:kTextFieldLeftViewWidth];
    self.doneButton.delegate = self;
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

+ (CGFloat)rowHeightForText:(NSString *)text {
    LSingleListViewCell *cell = [[LSingleListViewCell alloc] initWithSize:[UIScreen mainScreen].bounds.size];
    return [cell.itemView.textView heightForText:text] + 0.1;
}

- (CGRect)textViewFrame {
    return rect_origin(p(self.itemView.textView.left, self.frame.origin.y), self.itemView.textView.size);
}

- (void)setItem:(Item *)item {
    _item = item;
    self.itemView.textView.text = item.text;
}

#pragma mark - LDoneButtonDelegate

- (void)didPressDoneButton:(LDoneButton *)button {
    
}

@end
