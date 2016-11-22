//
//  LViewTransitionProtocol.m
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <objc/runtime.h>
#import "LViewTransitionProtocol.h"

NSString * const kTransitionTypePropertyKey = @"kTransitionTypePropertyKey";
NSString * const kTransitionDurationPropertyKey = @"kTransitionDurationPropertyKey";


@implementation UIView (LViewTransitionProtocol)

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    [self setHidden:hidden animated:animated completion:nil];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)())completion {
    
    if (self.hidden != hidden) {
        if (self.transitionType == LViewTransitionTypeFlip) {
            
            [UIView transitionWithView:self duration:self.transitionDuration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                self.hidden = hidden;
                
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
        else {
            self.hidden = NO;
            [UIView transitionWithView:self duration:self.transitionDuration options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                self.alpha = hidden ? 0 : 1;
                
            } completion:^(BOOL finished) {
                self.hidden = hidden;
                if (completion) {
                    completion();
                }
            }];
        }
    }
}

#pragma  mark - Properties

- (void)setTransitionType:(LViewTransitionType)transitionType {
    objc_setAssociatedObject(self, &kTransitionTypePropertyKey, @(transitionType), OBJC_ASSOCIATION_ASSIGN);
}

- (LViewTransitionType)transitionType {
    return [objc_getAssociatedObject(self, &kTransitionTypePropertyKey) integerValue];
}

- (void)setTransitionDuration:(CGFloat)transitionDuration {
    objc_setAssociatedObject(self, &kTransitionDurationPropertyKey, @(transitionDuration), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)transitionDuration {
    return [objc_getAssociatedObject(self, &kTransitionDurationPropertyKey) floatValue];
}

@end
