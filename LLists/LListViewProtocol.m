//
//  LListCellViewDelegate.m
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <objc/runtime.h>
#import "LListViewProtocol.h"

NSString * const kColorTagPropertyKey = @"kColorTagPropertyKey";
NSString * const kTextFieldPropertyKey = @"kTextFieldPropertyKey";
NSString * const kSeparatorPropertyKey = @"kSeparatorPropertyKey";

@implementation UIView (LListViewProtocol)

- (void)initInView:(UIView *)view {
    // Color Tag
    self.colorTag = [[LColorTag alloc] initInSuperview:self edge:UIViewEdgeLeft length:kColorTagWidth insets:i(0, 0, kAllListsSeparatorHeight, kPaddingSmall)];
    
    // Text Field
    self.textField = [[LTextField alloc] initFullInSuperview:self insets:i(0, 0, kAllListsSeparatorHeight, kAllListsCellLeftViewWidth)];
    self.textField.font = F_TITLE;
    
    // Separator
    self.separator = [[LSeparator alloc] initInSuperview:self edge:UIViewEdgeBottom length:kAllListsSeparatorHeight];
}

#pragma  mark - Properties

- (void)setColorTag:(LColorTag *)colorTag {
    objc_setAssociatedObject(self, &kColorTagPropertyKey, colorTag, OBJC_ASSOCIATION_ASSIGN);
}

- (LColorTag *)colorTag {
    return objc_getAssociatedObject(self, &kColorTagPropertyKey);
}

- (void)setTextField:(LTextField *)textField {
    objc_setAssociatedObject(self, &kTextViewHeighthMax, textField, OBJC_ASSOCIATION_ASSIGN);
}

- (LTextField *)textField {
    return objc_getAssociatedObject(self, &kTextFieldPropertyKey);
}

- (void)setSeparator:(LSeparator *)separator {
    objc_setAssociatedObject(self, &kSeparatorPropertyKey, separator, OBJC_ASSOCIATION_ASSIGN);
}

- (LSeparator *)separator {
    return objc_getAssociatedObject(self, &kSeparatorPropertyKey);
}

@end
