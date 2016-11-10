//
//  LAddItemView.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddItemView.h"
#import "LIconButton.h"


@interface LAddItemView () <UITextViewDelegate>

@property (nonatomic) LIconButton *plusButton;

@end


@implementation LAddItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Plus Button
    self.plusButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:kTextFieldLeftViewWidth insets:inset_bottom(kPaddingTiny)];
    self.plusButton.icon = LIconPlus;
    self.plusButton.userInteractionEnabled = NO;
    
    // Text View
    self.textView.delegate = self;
    
    return self;
}

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion {
    
    [UIView transitionWithView:self.plusButton duration:plusButtonAnimationDuration options:(showing ? showingAnimation : hidingAnimation) animations:^{
        self.plusButton.hidden = !showing;
    } completion:^(BOOL finished) {
        self.plusButton.hidden = NO;
        if (completion) completion();
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}


@end
