//
//  LSeparator.m
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSeparator.h"

@implementation LSeparator

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    UIView *topLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeTop length:1];
    topLine.backgroundColor = C_SEPARATOR;
    
    UIView *bottomLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:1];
    bottomLine.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
