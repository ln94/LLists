//
//  LTableViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"
#import "LIconButton.h"

@interface LTableViewCell ()

@property (nonatomic) UIView *movingTopSeparator;
@property (nonatomic) UIView *movingBottomSeparator;

@property (nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic) UITapGestureRecognizer *tap;


@end


@implementation LTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Move
    self.movingTopSeparator = [[UIView alloc] initInSuperview:self.contentView edge:UIViewEdgeTop length:kMovingCellSeparatorHeight];
//    self.movingTopSeparator.backgroundColor = C_SEPARATOR;
    self.movingTopSeparator.backgroundColor = C_MOVING_SEPARATOR;
    
    self.movingBottomSeparator = [[UIView alloc] initInSuperview:self.contentView edge:UIViewEdgeBottom length:kMovingCellSeparatorHeight];
//    self.movingBottomSeparator.backgroundColor = C_SEPARATOR;
    self.movingBottomSeparator.backgroundColor = C_MOVING_SEPARATOR;
    
    self.moving = NO;
    
    // Swipe
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft)];
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight)];
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    _swiped = NO;
    
    // Tap
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    return self;
}

- (void)setMainView:(UIView *)mainView {
    _mainView = mainView;
    
    [mainView addGestureRecognizer:self.swipeLeft];
    [mainView addGestureRecognizer:self.swipeRight];
    [mainView addGestureRecognizer:self.tap];
}

#pragma mark - Move

- (void)setMoving:(BOOL)moving {
    _moving = moving;
    
//    self.mainView.backgroundColor = moving ? C_MOVING_CELL : C_CLEAR;
    
    self.movingTopSeparator.hidden = !moving;
    self.movingBottomSeparator.hidden = !moving;
    
    if (moving) {
        [self.contentView bringSubviewToFront:self.movingTopSeparator];
        [self.contentView bringSubviewToFront:self.movingBottomSeparator];
    }
}

#pragma mark - Swipe

- (void)setSwiped:(BOOL)swiped {
    
    if (self.mainView && self.rightSwipeView && _swiped != swiped) {
        
        _swiped = swiped;
        
        if (swiped) {
            // Reveal Right Swipe View
            [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                self.mainView.left = -self.rightSwipeView.width;
                self.rightSwipeView.right = self.contentView.width;
            }];
        }
        else if (!swiped) {
            // Hide Right Swipe View
            [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                self.mainView.left = 0;
                self.rightSwipeView.left = self.contentView.width;
            }];
        }
        
        if (self.delegate) {
            [self.delegate didSwipeCell:self];
        }
    }
}

- (void)didSwipeLeft {
    self.swiped = YES;
}

- (void)didSwipeRight {
    self.swiped = NO;
}

#pragma mark - Tap

- (void)didTap:(UITapGestureRecognizer *)tap {
    if (self.delegate) {
        [self.delegate didTapCell:self];
    }
}

@end
