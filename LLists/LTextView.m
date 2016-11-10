//
//  LTextView.m
//  LLists
//
//  Created by Lana Shatonova on 8/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

static const CGFloat kTextContainerInsetBottom = 7;

#import "LTextView.h"

@implementation LTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.returnKeyType = UIReturnKeyDefault;
    self.textContainerInset = i(kPaddingTiny, 0, kTextContainerInsetBottom, 0);
    
    return self;
}

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
    return [self heightForText:@"A"];
}

@end
