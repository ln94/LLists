//
//  LTransition.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTransition.h"
#import "LPresentingTransition.h"
#import "LDismissingTransition.h"

@interface LTransition ()

@property (nonatomic, strong) LPresentingTransition *presentingTransition;
@property (nonatomic, strong) LDismissingTransition *dismissingTransition;

@end

@implementation LTransition

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    
    self.presentingTransition = [[LPresentingTransition alloc] init];
    self.dismissingTransition = [[LDismissingTransition alloc] init];
    
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentingTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissingTransition;
}

@end
