//
//  LSecondClassView.m
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSecondClassView.h"

@implementation LSecondClassView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    // Init Second Class
    [self initInView:self];
    
    return self;
}

@end
