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
    
    CGSize buttonSize = s(kHeaderViewButtonWidth, kHeaderViewButtonHeight);
    
    // Add Button: on the right
    self.addButton = [[LIconButton alloc] initInSuperview:self corner:UIViewCornerBottomRight size:buttonSize];
    self.addButton.icon = LIconPlus;
    [self.addButton moveIcon:LMoveDirectionRight by:12.5];
    
    self.showingAddButton = YES;
    
    // Back Button: on the left
    self.backButton = [[LIconButton alloc] initInSuperview:self corner:UIViewCornerBottomLeft size:buttonSize];
    self.backButton.icon = LIconBack;
    [self.backButton moveIcon:LMoveDirectionLeft by:22];
    
    // Settings Button: in the middle
    self.settingsButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeBottom size:buttonSize];
    self.settingsButton.icon = LIconCircle;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

- (void)setShowingAddButton:(BOOL)showingAddButton {
    _showingAddButton = showingAddButton;
    
    [UIView transitionWithView:self.addButton duration:kAnimationDuration options:(showingAddButton ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
        self.addButton.hidden = !showingAddButton;
    } completion:nil];
}

@end
