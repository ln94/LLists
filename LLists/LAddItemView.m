//
//  LAddItemView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddItemView.h"

@implementation LAddItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Plus Button
    self.plusButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kSingleListCellLeftViewWidth insets:inset_bottom(1)];
    self.plusButton.icon = LIconPlus;
    
    // Text View
    self.textView.placeholder = @"New Item";
    
    [self clear];
    
    return self;
}

- (void)clear {
    self.textView.text = @"";
    self.textView.height = [self.textView heightForText:@""];
    self.height = kSingleListCellMinHeight;
    [self centerTextView];
}

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion {
    
    [UIView transitionWithView:self.plusButton duration:kAnimationDuration options:(showing ? kShowingAnimation : kHidingAnimation) animations:nil completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

@end
