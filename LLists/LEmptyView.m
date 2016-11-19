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

- (instancetype)initInTableView:(UITableView *)tableView forType:(LTableType)type {
    self = [super initFullInSuperview:tableView];
    if (!self) return nil;
    
    self.backgroundColor = C_EMPTY_VIEW;
    
    // Label
    self.textLabel = [[UILabel alloc] initFullInSuperview:self];
    self.textLabel.font = F_TITLE;
    self.textLabel.textColor = C_SEPARATOR;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.text = type == LTableTypeList ? @"Your List of Lists is empty" : @"Your List is empty";
    
    return self;
}

- (void)setHidden:(BOOL)hidden {
    if (self.window && self.hidden != hidden) {
        
        [UIView transitionWithView:self duration:kAnimationDurationMed options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.alpha = hidden ? 0 : 1;
        } completion:^(BOOL finished) {
            [super setHidden:hidden];
        }];
    }
    
}

@end
