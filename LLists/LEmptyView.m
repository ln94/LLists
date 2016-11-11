//
//  LEmptyView.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LEmptyView.h"

@interface LEmptyView ()

@property (nonatomic) UILabel *textLabel;

@end

@implementation LEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = C_EMPTY_VIEW;
    
    // Label
    self.textLabel = [[UILabel alloc] initFullInSuperview:self];
    self.textLabel.font = F_TITLE;
    self.textLabel.textColor = C_SEPARATOR;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
}

@end
