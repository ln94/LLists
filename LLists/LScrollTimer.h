//
//  LScrollTimer.h
//  LLists
//
//  Created by Lana Shatonova on 19/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LScrollDirection) {
    LScrollDirectionUp = 0,
    LScrollDirectionDown
};

@interface LScrollTimer : NSObject

@property (nonatomic, readonly) BOOL isValid;

- (instancetype)initWithTableView:(UITableView *)tableView andMaxTouchOffset:(CGFloat)offset;

- (void)startForScrollDirection:(LScrollDirection)direction touchOffset:(CGFloat)offset;
- (void)changeTimeIntervalForTouchOffset:(CGFloat)offset;
- (void)stop;

@end
