//
//  LSeparatorButton.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSeparatorButton.h"

@interface LSeparatorButton ()

@end

@implementation LSeparatorButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:rect_origin(frame.origin, s(frame.size.width, kSeparatorHeight))];
    if (!self) return nil;
    
    self.backgroundColor = C_WHITE;
    
    UIView *topLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeTop length:1];
    topLine.backgroundColor = C_SEPARATOR;
    
    UIView *bottomLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    bottomLine.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
