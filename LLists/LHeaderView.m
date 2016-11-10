//
//  LHeaderView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LHeaderView.h"

@interface LHeaderView ()

@end

@implementation LHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Add Button
    self.addButton = [[LIconButton alloc] initCenterInSuperview:self size:s(KHeaderViewAddButtonWidth, self.height) insets:inset_bottom(kPaddingTiny)];
    self.addButton.icon = LIconPlus;
    
    self.showingAddButton = YES;
    
    // Back Button
    self.backButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:KHeaderViewAddButtonWidth insets:inset_bottom(kPaddingTiny)];
    self.backButton.icon = LIconBack;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)setShowingAddButton:(BOOL)showingAddButton {
    _showingAddButton = showingAddButton;
    
    [UIView transitionWithView:self.addButton duration:plusButtonAnimationDuration options:(showingAddButton ? showingAnimation : hidingAnimation) animations:^{
        self.addButton.hidden = !showingAddButton;
    } completion:nil];
}

@end
