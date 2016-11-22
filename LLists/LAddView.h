//
//  LAddView.h
//  LLists
//
//  Created by Lana Shatonova on 19/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSecondClassView.h"
#import "LIconButton.h"

@protocol LTextViewProtocol;

@interface LAddView : LSecondClassView {
    
    CGFloat leftViewLength;
    CGFloat separatorLength;
    CGFloat height;
}

@property (nonatomic, strong) LIconButton *addButton;
@property (nonatomic, strong) UIView <LViewTransitionProtocol> *leftView;
@property (nonatomic, strong) UIView <LTextViewProtocol, UITextInputTraits, LViewTransitionProtocol> *textView;

- (id)initInSuperview:(UIView *)superview forType:(LTableType)type;

- (void)animateShowing:(void (^)(void))completion;
- (void)animateHiding:(void (^)(void))completion;
- (void)animateAdding:(void (^)(void))completion;

- (void)reset;

@end


@interface LPlaceholderAddView : LAddView

@end


@protocol LTextViewProtocol <NSObject>

@property (nonatomic, strong) NSString *text;

@end

