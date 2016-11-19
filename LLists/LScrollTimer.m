//
//  LScrollTimer.m
//  LLists
//
//  Created by Lana Shatonova on 19/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LScrollTimer.h"

static const CGFloat scrollOffset = 10;

@interface LScrollTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) CGFloat maxTouchOffset;

@property (nonatomic) LScrollDirection direction;
@property (nonatomic) CGFloat interval;

@end

@implementation LScrollTimer

- (instancetype)initWithScrollingTableView:(UITableView *)tableView andMaxTouchOffset:(CGFloat)offset {
    self = [super init];
    if (!self) return nil;
    
    self.tableView = tableView;
    self.maxTouchOffset = offset;
    
    return self;
}

- (BOOL)isValid {
    return self.timer.isValid;
}

- (void)startForScrollDirection:(LScrollDirection)direction touchOffset:(CGFloat)offset {
    self.direction = direction;
    self.interval = [self getScrollTimerIntervalFromTouchOffset:offset];
    
    [self start];
}

- (void)changeTimeIntervalForTouchOffset:(CGFloat)offset {
    CGFloat newInterval = [self getScrollTimerIntervalFromTouchOffset:offset];
    
    if (self.interval != newInterval) {
        self.interval = newInterval;
        [self stop];
        [self start];
    }
}

- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(scroll) userInfo:nil repeats:YES];
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scroll {
    CGFloat newOffset = 0;
    
    if (self.direction == LScrollDirectionUp) {
        newOffset = self.tableView.contentOffset.y - scrollOffset;
        if (newOffset <= 0) {
            newOffset = 0;
            [self stop];
        }
    }
    else {
        newOffset = self.tableView.contentOffset.y + scrollOffset;
        CGFloat maxTableOffset = self.tableView.contentSize.height - self.tableView.height;
        if (newOffset >= maxTableOffset) {
            newOffset = maxTableOffset;
            [self stop];
        }
    }
    
    [UIView animateWithDuration:self.interval animations:^{
        self.tableView.contentOffset = p(0, newOffset);
    }];
}


#pragma mark - Utils

- (CGFloat)getScrollTimerIntervalFromTouchOffset:(CGFloat)offset {
    if (offset >= self.maxTouchOffset / 2) {
        return 0.08;
    }
    else if (offset >= 0) {
        return 0.05;
    }
    else if (offset >= -self.maxTouchOffset / 2) {
        return 0.03;
    }
    else {
        return 0.01;
    }
}

@end
