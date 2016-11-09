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
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // Plus Icon
    self.plusIconButton = [[UIButton alloc] initInSuperview:self.textField.leftView edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kPaddingTiny, kPaddingSmall)];
    attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:28],
                    NSForegroundColorAttributeName:C_ICON };
    NSAttributedString *plusIconTitle = [NSAttributedString attributedStringWithAttributes:attributes format:@"+"];
    [self.plusIconButton setAttributedTitle:plusIconTitle forState:UIControlStateNormal];
    self.plusIconButton.userInteractionEnabled = NO;
    
    // Color Tag
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    
    return self;
}

#pragma mark - UITextFieldDelegate

- (void)setShowingColorTag:(BOOL)showing completion:(void (^)())completion {
    UIView *fromView = showing ? self.plusIconButton : self.colorTag;
    UIView *toView = showing ? self.colorTag : self.plusIconButton;
    
    toView.hidden = NO;
    [UIView transitionFromView:fromView toView:toView duration:duration options:(showing ? showingAnimation : hidingAnimation) completion:^(BOOL finished) {
        fromView.hidden = YES;
        if (completion) completion();
    }];
}

@end
