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
    self.addButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeRight length:kHeaderViewSideButtonWidth insets:inset_right(-kHeaderViewSideButtonInset)];
    self.addButton.icon = LIconPlus;
    
    self.showingAddButton = YES;
    
    // Back Button
    self.backButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kHeaderViewSideButtonWidth insets:inset_left(-kHeaderViewSideButtonInset-4)];
    self.backButton.icon = LIconBack;
    
    // Settings Button
    self.settingsButton = [[LIconButton alloc] initCenterInSuperview:self size:s(kHeaderViewMiddleButtonWidth, self.height)];
    self.settingsButton.icon = LIconCircle;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)setShowingAddButton:(BOOL)showingAddButton {
    _showingAddButton = showingAddButton;
    
    [UIView transitionWithView:self.addButton duration:plusButtonAnimationDuration options:(showingAddButton ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
        self.addButton.hidden = !showingAddButton;
    } completion:nil];
}

@end
