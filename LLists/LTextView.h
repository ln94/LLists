//
//  LTextView.h
//  LLists
//
//  Created by Lana Shatonova on 8/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTextViewDelegate;

@interface LTextView : UITextView

@property (nonatomic) NSString *placeholder;

@property (nonatomic, readonly) CGFloat minHeight;

@property (nonatomic, strong) id<LTextViewDelegate> lDelegate;

- (CGFloat)heightForText:(NSString *)text;

@end

@protocol LTextViewDelegate <NSObject>

@required
- (void)textViewShouldChangeHeight:(LTextView *)textView by:(CGFloat)by;

@optional
- (void)textViewShouldChangeText:(LTextView *)textView to:(NSString *)text;

@end
