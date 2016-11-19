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


#pragma mark - Placeholder

@implementation LPlaceholderAddView

- (instancetype)init {
    return [self initInSuperview:nil forType:-1];
}

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
            return [NSObject class];
    }
}

@end




@interface LAddView ()

@property (nonatomic, strong) LIconButton *addButton;

@end

@implementation LAddView {
    BOOL animationInProgress;
}

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
    CGFloat leftViewLength = type == LTableTypeList ? kAllListsCellLeftViewWidth : kSingleListCellLeftViewWidth;
    CGFloat separatorLength = type == LTableTypeList ? kAllListsSeparatorHeight : kSingleListSeparatorHeight;
    CGFloat height = type == LTableTypeList ? kAllListsCellHeight : kSingleListCellMinHeight;
    
    self = [super initInSuperview:superview edge:UIViewEdgeTop length:height insets:inset_top(kHeaderViewHeight - height)];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    // Add Button
    self.addButton = [[LIconButton alloc] initInSuperview:self edge:UIViewEdgeLeft length:leftViewLength insets:inset_bottom(separatorLength)];
    self.addButton.icon = LIconPlus;
    [self.addButton addTarget:self action:@selector(add:)];
    self.addButton.hidden = YES;
    
    self.hidden = YES;
    
    animationInProgress = NO;

    return self;
}

- (BOOL)isEmpty {
    if ([self.textView isKindOfClass:[UITextField class]]) {
        return ((UITextField *)self.textView).text.isEmpty;
    }
    else if ([self.textView isKindOfClass:[UITextView class]]) {
        return ((UITextView *)self.textView).text.isEmpty;
    }
    else return YES;
}

#pragma mark - Setters

- (void)setLeftView:(UIView *)leftView {
    _leftView = leftView;
    leftView.hidden = YES;
}

- (void)setTextView:(UIView *)textView {
    _textView = textView;
    textView.hidden = YES;
}

#pragma mark - Change State

- (void)setState:(LAddViewState)state completion:(void (^)(void))completion {
    if (!animationInProgress) {
        animationInProgress = YES;
        
        switch (state) {
                
            case LAddViewStateHide:
                [self hide:completion];
                break;
                
            case LAddViewStateShow:
                [self show:completion];
                break;
                
            case LAddViewStateAdd:
                [self add:completion];
                break;
                
            default:
                break;
        }
    }
}

- (void)hide:(void (^)(void))completion {
    // Hide keyboard, Add Button and Text View
    [self.textView resignFirstResponder];
    self.addButton.hidden = YES;
    
    run_delayed(kAnimationDurationSmall, ^{
        // Pull up
        [UIView animateWithDuration:kAnimationDurationSmall animations:^{
            self.bottom = kHeaderViewHeight;
            self.textView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self.hidden = YES;
            
            animationInProgress = NO;
            
            if (completion) {
                completion();
            }
        }];
    });
}

- (void)show:(void (^)(void))completion {
    self.hidden = NO;
    
    // Drop down
    [UIView animateWithDuration:kAnimationDurationSmall animations:^{
        self.top = kHeaderViewHeight;
        self.textView.hidden = NO;
        
    } completion:^(BOOL finished) {
        [self.textView becomeFirstResponder];
        
        animationInProgress = NO;
        
        if (completion) {
            completion();
        }
    }];
    
    // Show add button
    run_delayed(kAnimationDurationTiny, ^{
        self.addButton.hidden = NO;
    });
}

- (void)add:(void (^)(void))completion {
    if (!self.isEmpty) {
        // Hide keyboard
        [self.textView resignFirstResponder];
        
        // Transition from Add Button to Color Tag
        self.addButton.hidden = YES;
        
        [UIView transitionWithView:self.leftView duration:kAnimationDurationMed options:kShowingAnimation animations:^{
            self.leftView.hidden = NO;
            self.textView.hidden = YES;
            
        } completion:^(BOOL finished) {
            self.bottom = kHeaderViewHeight;
            self.leftView.hidden = YES;
            self.addButton.hidden = YES;
            self.hidden = YES;
            
            animationInProgress = NO;
            
            if (completion) {
                completion();
            }
        }];
    }
}

@end
