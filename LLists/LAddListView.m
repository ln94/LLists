//
//  LAddListView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddListView.h"
#import "LColorTag.h"

static const CGFloat duration = 0.4;

@interface LAddListView ()

@property (nonatomic) UIButton *plusIconButton;

@end

@implementation LAddListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Text Field
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:C_SEPARATOR };
    self.textField.attributedPlaceholder = [NSAttributedString attributedStringWithAttributes:attributes format:@"New List"];
    
    // Plus Icon
    self.plusIconButton = [[UIButton alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kPaddingTiny, kPaddingSmall)];
    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:28],
                    NSForegroundColorAttributeName:C_ICON };
    NSAttributedString *plusIconTitle = [NSAttributedString attributedStringWithAttributes:attributes format:@"+"];
    [self.plusIconButton setAttributedTitle:plusIconTitle forState:UIControlStateNormal];
    [self.plusIconButton addTarget:self action:@selector(didPressPlusIconButton)];
    
    // Color Tag
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    
    return self;
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
