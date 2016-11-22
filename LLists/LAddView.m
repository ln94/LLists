//
//  LAddView.m
//  LLists
//
//  Created by Lana Shatonova on 19/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddView.h"
#import "LAddListView.h"
#import "LAddItemView.h"

#pragma clang diagnostic ignored "-Wincompatible-pointer-types"


#pragma mark - Class

@implementation LAddView

+ (id)alloc {
    if ([self class] == [LAddView class]) {
        LPlaceholderAddView *placeholder = [LPlaceholderAddView alloc];
        return placeholder;
    }
    else {
        return [super alloc];
    }
}

- (id)initInSuperview:(UIView *)superview forType:(LTableType)type {
    self = [super initInSuperview:superview edge:UIViewEdgeTop length:height insets:inset_top(kHeaderViewHeight - height)];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    self.hidden = YES;
    
    // Add Button
    self.addButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:leftViewLength insets:inset_bottom(separatorLength)];
    self.addButton.icon = LIconPlus;
    self.addButton.hidden = YES;

    return self;
}

- (void)reset {
    self.hidden = YES;
    self.height = height;
    self.bottom = kHeaderViewHeight;
    
    self.addButton.hidden = YES;
    self.leftView.hidden = YES;
    self.textView.text = @"";
    self.textView.hidden = YES;
}


#pragma mark - Setters

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    leftView.hidden = YES;
}

- (void)setTextView:(UIView<LTextViewProtocol,UITextInputTraits,LViewTransitionProtocol> *)textView {
    _textView = textView;
    textView.returnKeyType = UIReturnKeyDefault;
    textView.hidden = YES;
}


#pragma mark - Animation

- (void)animateShowing:(void (^)(void))completion {
    self.hidden = NO;
    
    // Show Add View
    [UIView animateWithDuration:kAnimationDurationMed animations:^{
        self.top = kHeaderViewHeight;
        
    } completion:^(BOOL finished) {
        //Show keyboard
        [self.textView becomeFirstResponder];
        
        if (completion) {
            completion();
        }
    }];
    
    // Show Add Button and Text View
    [self.addButton setHidden:NO animated:YES];
    [self.textView setHidden:NO animated:YES];
}

- (void)animateHiding:(void (^)(void))completion {
    // Hide keyboard, Text View and Add Button
    [self.textView resignFirstResponder];
    [self.textView setHidden:YES animated:YES];
    [self.addButton setHidden:YES animated:YES completion:^{
        
        // Hide Add View
        [UIView animateWithDuration:kAnimationDurationSmall animations:^{
            self.bottom = kHeaderViewHeight;
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
            
            if (completion) {
                completion();
            }
        }];

    }];
}

- (void)animateAdding:(void (^)(void))completion {
    // Hide keyboard
    [self.textView resignFirstResponder];
    
    // Transition from Add Button to Left View
    [self.addButton setHidden:YES animated:YES];
    [self.leftView setHidden:NO animated:YES];
    
    if (completion) {
        completion();
    }
}

@end



#pragma mark - Placeholder

@implementation LPlaceholderAddView

- (id)initInSuperview:(UIView *)superview forType:(LTableType)type {
    Class class = [self classForType:type];
    LAddView *instance = [(LAddView *)[class alloc] initInSuperview:superview forType:type];
    return instance;
}

- (Class)classForType:(LTableType)type {
    switch (type) {
        case LTableTypeList:
            return [LAddListView class];
            
        case LTableTypeItem:
            return [LAddItemView class];
            
        default:
            return [LAddView class];
    }
}

@end
