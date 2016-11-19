//
//  LAddView.h
//  LLists
//
//  Created by Lana Shatonova on 19/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSecondClassView.h"
#import "LIconButton.h"

typedef NS_ENUM(NSInteger, LAddViewState) {
    LAddViewStateHide = 0,
    LAddViewStateShow,
    LAddViewStateAdd
};

@interface LAddView : LSecondClassView

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *textView;

@property (nonatomic, readonly) BOOL isEmpty;

//- (id)initForType:(LTableType)type;
- (id)initInSuperview:(UIView *)superview forType:(LTableType)type;

- (void)setState:(LAddViewState)state completion:(void (^)(void))completion;

- (void)reset;

@end


@interface LPlaceholderAddView : LAddView

@end
