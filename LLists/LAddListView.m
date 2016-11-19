//
//  LAddListView.m
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAddListView.h"

@implementation LAddListView

@synthesize colorTag = _colorTag;
@synthesize textField = _textField;
@synthesize separator = _separator;

- (id)initInSuperview:(UIView *)superview forType:(LTableType)type {
    self = [super initInSuperview:superview forType:type];
    if (!self) return nil;
    
    // Text Field
    self.textField.placeholder = @"New List";
    self.textView = self.textField;
    
    // Color Tag
    self.colorTag.backgroundColor = C_ICON;
    self.colorTag.hidden = YES;
    self.leftView = self.colorTag;
    
    return self;
}

- (void)reset {
    self.textField.text = @"";
}

@end
