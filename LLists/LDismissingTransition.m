//
//  LDismissingTransition.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LDismissingTransition.h"

@implementation LDismissingTransition

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return kAnimationDurationSmall;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVC.view];
    toVC.view.right = 0;
    
    [UIView animateWithDuration:kAnimationDurationSmall animations:^{
        fromVC.view.left = container.width;
        toVC.view.left = 0;
        
    } completion:^(BOOL finished) {
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:finished];
    }];
}

@end
