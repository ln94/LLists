//
//  LColorTag.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LColorTag.h"

@implementation LColorTag

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:rect_origin(frame.origin, s(kColorTagWidth, frame.size.height))];
    if (!self) return nil;
    
    self.alpha = 0.5;

    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}

@end
