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

- (id)initInSuperview:(UIView *)superview {
    self = [super initInSuperview:superview edge:UIViewEdgeTop length:kHeaderViewHeight];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    CGSize buttonSize = s(kHeaderViewButtonWidth, kHeaderViewButtonHeight);
    
    // Add Button: on the right
    self.addButton = [[LIconButton alloc] initInSuperview:self corner:UIViewCornerBottomRight size:buttonSize insets:inset_right(-12.5)];
    self.addButton.icon = LIconPlus;
    
    // Back Button: on the left
    self.backButton = [[LIconButton alloc] initInSuperview:self corner:UIViewCornerBottomLeft size:buttonSize insets:inset_left(-22)];
    self.backButton.icon = LIconBack;
    
    // Settings Button: in the middle
    self.settingsButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeBottom size:buttonSize];
    self.settingsButton.icon = LIconCircle;
    
    // Separator
    UIView *separator = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    separator.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
