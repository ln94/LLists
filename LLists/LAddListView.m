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
    
    // Text Field
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:C_SEPARATOR };
    self.textField.attributedPlaceholder = [NSAttributedString attributedStringWithAttributes:attributes format:@"New List"];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // Plus Icon
    self.plusButton = [[LIconButton alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kPaddingTiny, kPaddingSmall)];
    self.plusButton.icon = LIconPlus;
    self.plusButton.userInteractionEnabled = NO;
    
    // Color Tag
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    
    return self;
}

#pragma mark - UITextFieldDelegate

- (void)setShowingColorTag:(BOOL)showing completion:(void (^)())completion {
    UIView *fromView = showing ? self.plusButton : self.colorTag;
    UIView *toView = showing ? self.colorTag : self.plusButton;
    
    toView.hidden = NO;
    [UIView transitionFromView:fromView toView:toView duration:plusButtonAnimationDuration options:(showing ? showingAnimation : hidingAnimation) completion:^(BOOL finished) {
        fromView.hidden = YES;
        if (completion) completion();
    }];
}

@end
