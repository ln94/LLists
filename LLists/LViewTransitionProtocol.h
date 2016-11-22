//
//  LViewTransitionProtocol.h
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LViewTransitionType) {
    LViewTransitionTypeFlip = 0,
    LViewTransitionTypeFade
};

@protocol LViewTransitionProtocol <NSObject>

@required
@property (nonatomic) LViewTransitionType transitionType;
@property (nonatomic) CGFloat transitionDuration;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)())completion;

@end

@interface UIView (LViewTransitionProtocol) <LViewTransitionProtocol>

@end
