//
//  LAllListsViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewCell.h"
#import "LColorTag.h"

static NSString *const reuseIdentifier = @"allListsViewCell";


@interface LAllListsViewCell () <UITextFieldDelegate>

@property (nonatomic) LColorTag *colorTag;
@property (nonatomic) UITextField *textField;

@end


@implementation LAllListsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Text Field
    self.textField = [[UITextField alloc] initFullInSuperview:self.contentView insets:inset_bottom(kSeparatorHeight)];
    self.textField.font = F_TITLE;
    self.textField.textColor = C_MAIN_TEXT;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.userInteractionEnabled = NO;
    self.textField.delegate = self;
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc] initWithSize:s(kTextFieldLeftViewWidth, self.textField.height)];
    
    // Color Tag
    self.colorTag = [[LColorTag alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:inset_left(kPaddingSmall)];
    
    // GR
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

- (void)setList:(List *)list {
    _list = list;
    self.textField.text = list.title;
    self.colorTag.backgroundColor = list.color;
}

#pragma mark - GR

- (void)singleTapped {
//    LOG(@"%@", self.colorTag.backgroundColor);
    
    // Open list or finish editing
    if (self.delegate) {
        [self.delegate didSelectTableViewCell:self];
    }
}

- (void)doubleTapped {
    // Edit title
//    self.list.editing = YES;
    self.textField.userInteractionEnabled = YES;
    [self.textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // Save or discard changes
    self.textField.userInteractionEnabled = NO;
    
    if (!textField.text.isEmpty) {
        self.list.title = textField.text;
    }
    else {
        textField.text = self.list.title;
    }
    
    self.list.editing = NO;
    [DataStore save];
}

@end
