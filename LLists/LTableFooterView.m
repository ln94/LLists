//
//  LTableFooterView.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableFooterView.h"
#import "LColorTag.h"

static const CGFloat duration = 0.4;

@interface LTableFooterView () <UITextFieldDelegate>

@property (nonatomic) UIButton *plusIconButton;
@property (nonatomic) LColorTag *colorTag;

@end

@implementation LTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Text Field
    self.textField = [[UITextField alloc] initFullInSuperview:self];
    self.textField.textColor = C_MAIN_TEXT;
    self.textField.returnKeyType = UIReturnKeyDone;
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:C_SEPARATOR };
    self.textField.attributedPlaceholder = [NSAttributedString attributedStringWithAttributes:attributes format:@"New List"];
    
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc] initWithSize:s(kTextFieldLeftViewWidth, self.height)];
    self.textField.delegate = self;
    
    // Plus Icon
    self.plusIconButton = [[UIButton alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kPaddingTiny, kPaddingSmall)];
    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:24],
                                  NSForegroundColorAttributeName:C_ICON };
    NSAttributedString *plusIconTitle = [NSAttributedString attributedStringWithAttributes:attributes format:@"+"];
    [self.plusIconButton setAttributedTitle:plusIconTitle forState:UIControlStateNormal];
    [self.plusIconButton addTarget:self action:@selector(didPressPlusIconButton)];
    
    // Color Tag
    self.colorTag = [[LColorTag alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:inset_left(kPaddingSmall)];
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)didPressPlusIconButton {
    [self.textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.colorTag.hidden = NO;
    [UIView transitionFromView:self.plusIconButton toView:self.colorTag duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        self.plusIconButton.hidden = YES;
    }];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    self.plusIconButton.hidden = NO;
    [UIView transitionFromView:self.colorTag toView:self.plusIconButton duration:duration options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        self.colorTag.hidden = YES;
    }];
    
    return YES;
}

@end
