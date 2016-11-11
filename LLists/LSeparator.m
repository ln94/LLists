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
    
    self.backgroundColor = C_WHITE;
    
    UIView *topLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeTop length:kSeparatorTopLineHeight];
    topLine.backgroundColor = C_SEPARATOR;
    
    UIView *bottomLine = [[UIView alloc] initInSuperview:self edge:UIViewEdgeBottom length:kSeparatorBottomLineHeight];
    bottomLine.backgroundColor = C_SEPARATOR;
    
    return self;
}

@end
