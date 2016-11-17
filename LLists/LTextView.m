//
//  LTextView.m
//  LLists
//
//  Created by Lana Shatonova on 8/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

static const CGFloat kTextContainerInsetBottom = 7;

#import "LTextView.h"

@interface LTextView () <UITextViewDelegate>

@property (nonatomic) UILabel *placeholderLabel;

@end

@implementation LTextView {
    BOOL changedHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.textColor = C_MAIN_TEXT;
    self.textAlignment = NSTextAlignmentLeft;
    self.returnKeyType = UIReturnKeyDefault;
    self.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.spellCheckingType = UITextSpellCheckingTypeYes;
    self.textContainerInset = i(kPaddingTiny, 0, kTextContainerInsetBottom, 0);
    self.delegate = self;
    
    // Placeholder
    self.placeholderLabel = [[UILabel alloc] initInSuperview:self];
    self.placeholderLabel.textColor = C_SEPARATOR;
    
    changedHeight = NO;
    
    return self;
}

#pragma mark - Setter

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    [self.placeholderLabel setEdge:UIViewEdgeTop length:[self minHeight] insets:inset_left(kPaddingTiny)];
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.text = placeholder;
}


#pragma mark - Height

- (CGFloat)heightForText:(NSString *)text {
    
    CGFloat boundingWidth = self.width - self.textContainerInset.left - self.textContainerInset.right - kPaddingSmall;
    CGRect rect = [(text.isEmpty ? @"A" : text) boundingRectWithSize:s(boundingWidth, 1000)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:@{NSFontAttributeName:self.font}
                                     context:nil];
    
    CGFloat height = rect.size.height + self.textContainerInset.top + self.textContainerInset.bottom;
//    LOG(@"--- %.2f", height);
    return height;
}

- (CGFloat)minHeight {
    return [self heightForText:@""];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [self.text stringByReplacingCharactersInRange:range withString:text];
    self.placeholderLabel.hidden = !newText.isEmpty;
    
    if ([self.lDelegate respondsToSelector:@selector(textViewShouldChangeText:to:)]) {
        [self.lDelegate textViewShouldChangeText:self to:newText];
    }
    
    CGFloat newHeight = [self heightForText:newText];
    if (newHeight != self.height && newHeight <= kTextViewHeighthMax) {
        
        if (self.lDelegate) {
            [self.lDelegate textViewShouldChangeHeight:self to:newHeight];
        }
        
        // Update height
        self.height = newHeight;
        
        if ([self.lDelegate respondsToSelector:@selector(textViewDidChangeHeight:)]) {
            [self.lDelegate textViewDidChangeHeight:self];
        }
    }
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.lDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.lDelegate textViewShouldBeginEditing:self];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.lDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        [self.lDelegate textViewShouldEndEditing:self];
    }
    
    return YES;
}

@end
