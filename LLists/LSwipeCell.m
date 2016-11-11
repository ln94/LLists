//
//  LSwipeCell.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSwipeCell.h"
#import "LIconButton.h"

@interface LSwipeCell ()

@property (nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic) UILongPressGestureRecognizer *longPress;

@end


@implementation LSwipeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.swiped = NO;
    
    // GR
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft)];
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight)];
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
    
    return self;
}

- (void)setMainView:(UIView *)mainView {
    _mainView = mainView;
    
    [mainView addGestureRecognizer:self.swipeLeft];
    [mainView addGestureRecognizer:self.swipeRight];
    [mainView addGestureRecognizer:self.tap];
    [mainView addGestureRecognizer:self.longPress];
}

#pragma mark - Swipe

- (void)setSwiped:(BOOL)swiped {
    
    if (self.mainView && self.rightSwipeView) {
        
        if (swiped && !_swiped) {
            // Reveal Right Swipe View
            [UIView animateWithDuration:swipeAnimationDuration animations:^{
                self.mainView.left = -self.rightSwipeView.width;
                self.rightSwipeView.right = self.contentView.width;
            }];
        }
        else if (!swiped && _swiped) {
            // Hide Right Swipe View
            [UIView animateWithDuration:swipeAnimationDuration animations:^{
                self.mainView.left = 0;
                self.rightSwipeView.left = self.contentView.width;
            }];
        }
    }
    
    _swiped = swiped;
}

- (void)didSwipeLeft {
    self.swiped = YES;
    
    if (self.delegate) {
        [self.delegate didSwipeCell:self];
    }
}

- (void)didSwipeRight {
    self.swiped = NO;
    
    if (self.delegate) {
        [self.delegate didSwipeCell:self];
    }
}

#pragma mark - Tap

- (void)didTap:(UITapGestureRecognizer *)tap {
    if (self.delegate) {
        [self.delegate didTapCell:self];
    }
}

#pragma mark - Long Press

- (void)didLongPress:(UILongPressGestureRecognizer *)longPress {
    if (self.delegate) {
        [self.delegate didLongPress:longPress cell:self];
    }
}

@end
