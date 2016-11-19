//
//  LAddListView.m
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddListView.h"
#import "LIconButton.h"


@interface LAddListView ()

@property (nonatomic) LIconButton *plusButton;

@end


@implementation LAddListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Text Field
    self.textField.placeholder = @"New List";
    
    // Plus Icon
    self.plusButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kAllListsCellLeftViewWidth insets:inset_bottom(kAllListsSeparatorHeight)];
    self.plusButton.icon = LIconPlus;
    self.plusButton.userInteractionEnabled = NO;
    
    // Color Tag
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    
    return self;
}

#pragma mark - Animation

- (void)animateColorTagShowing:(BOOL)showing completion:(void (^)())completion {
    UIView *fromView = showing ? self.plusButton : self.colorTag;
    UIView *toView = showing ? self.colorTag : self.plusButton;
    
    [UIView transitionWithView:fromView duration:kAnimationDuration options:(showing ? kShowingAnimation : kHidingAnimation) animations:^{
        fromView.hidden = YES;
    } completion:nil];
    
    [UIView transitionWithView:toView duration:kAnimationDuration options:(showing ? kShowingAnimation : kHidingAnimation) animations:^{
        toView.hidden = NO;
    } completion:^(BOOL finished) {
        
        if (completion) {
            completion();
        }
    }];
}

@end
