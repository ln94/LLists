//
//  LEmptyView.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LEmptyView.h"

@implementation LEmptyView

@synthesize transitionType = _transitionType;
@synthesize transitionDuration = _transitionDuration;

- (instancetype)initInTableView:(UITableView *)tableView forType:(LTableType)type {
    self = [super initFullInSuperview:tableView];
    if (!self) return nil;
    
    self.backgroundColor = C_EMPTY_VIEW;
    
    // Label
    UILabel *textLabel = [[UILabel alloc] initFullInSuperview:self];
    textLabel.font = F_TITLE;
    textLabel.textColor = C_SEPARATOR;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = type == LTableTypeList ? @"Your List of Lists is empty" : @"Your List is empty";
    
    // Transition
    self.transitionType = LViewTransitionTypeFade;
    self.transitionDuration = kAnimationDurationMed;
    
    return self;
}

@end
