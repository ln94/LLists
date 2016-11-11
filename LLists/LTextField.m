//
//  LTextField.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTextField.h"

@implementation LTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = C_CLEAR;
    self.textColor = C_MAIN_TEXT;
    self.returnKeyType = UIReturnKeyDone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    NSDictionary *attributes = @{ NSForegroundColorAttributeName:C_SEPARATOR };
    self.attributedPlaceholder = [NSAttributedString attributedStringWithAttributes:attributes format:@"%@", placeholder];
}

@end
