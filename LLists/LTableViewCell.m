//
//  LTableViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"
#import "LIconButton.h"
#import "LAllListsViewCell.h"
#import "LSingleListViewCell.h"

#pragma mark - Class

@interface LTableViewCell ()

@property (nonatomic) UIView *movingTopSeparator;
@property (nonatomic) UIView *movingBottomSeparator;

@property (nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (nonatomic) UITapGestureRecognizer *tap;


@end


@implementation LTableViewCell

+ (id)alloc {
    if ([self class] == [LTableViewCell class]) {
        LPlaceholderTableViewCell *placeholder = [LPlaceholderTableViewCell alloc];
        return placeholder;
    }
    else {
        return [super alloc];
    }
}

+ (Class)classForType:(LTableType)type {
    return [LPlaceholderTableViewCell classForType:type];
}

+ (NSString *)reuseIdentifierForType:(LTableType)type {
    return [LPlaceholderTableViewCell reuseIdentifierForType:type];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.backgroundColor = C_CLEAR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Main View
    self.mainView = [[LSecondClassView alloc] initFullInSuperview:self.contentView];
    
    // Move
    self.movingTopSeparator = [[UIView alloc] initInSuperview:self.contentView edge:UIViewEdgeTop length:kMovingCellSeparatorHeight];
    self.movingTopSeparator.backgroundColor = C_MOVING_SEPARATOR;
    
    self.movingBottomSeparator = [[UIView alloc] initInSuperview:self.contentView edge:UIViewEdgeBottom length:kMovingCellSeparatorHeight];
    self.movingBottomSeparator.backgroundColor = C_MOVING_SEPARATOR;
    
    self.moving = NO;
    
    // Swipe
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft)];
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight)];
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    self.swiped = NO;
    
    // Tap
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    // Transition
    self.transitionType = LViewTransitionTypeFade;
    self.transitionDuration = kAnimationDurationSmall;
    
    return self;
}

//- (void)setMainView:(UIView *)mainView {
//    _mainView = mainView;
//    
//    [mainView addGestureRecognizer:self.swipeLeft];
//    [mainView addGestureRecognizer:self.swipeRight];
//    [mainView addGestureRecognizer:self.tap];
//}


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
    [self setSwiped:swiped animated:NO];
}

- (void)setSwiped:(BOOL)swiped animated:(BOOL)animated {
    [self setSwiped:swiped animated:animated completion:nil];
}

- (void)setSwiped:(BOOL)swiped animated:(BOOL)animated completion:(void (^)())completion {
    if (_swiped != swiped) {
        if (self.mainView && self.rightSwipeView) {
            
            _swiped = swiped;
            
            if (animated) {
                if (swiped) {
                    // Show Right Swipe View
                    [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                        self.mainView.left = -self.rightSwipeView.width;
                        self.rightSwipeView.right = self.contentView.width;
                    } completion:^(BOOL finished) {
                        if (completion) {
                            completion();
                        }
                    }];
                }
                else {
                    // Hide Right Swipe View
                    [UIView animateWithDuration:kAnimationDurationSmall animations:^{
                        self.mainView.left = 0;
                        self.rightSwipeView.left = self.contentView.width;
                    } completion:^(BOOL finished) {
                        if (completion) {
                            completion();
                        }
                    }];
                }
            }
        }
        else {
            _swiped = NO;
        }
    }
}

- (void)didSwipeLeft {
    [self setSwiped:YES animated:YES];
    if (self.delegate) {
        [self.delegate didSwipeCell:self];
    }
}

- (void)didSwipeRight {
    [self setSwiped:NO animated:YES];
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

@end



#pragma mark - Placeholder

@implementation LPlaceholderTableViewCell

+ (Class)classForType:(LTableType)type {
    switch (type) {
        case LTableTypeList:
            return [LAllListsViewCell class];
            
        case LTableTypeItem:
            return [LSingleListViewCell class];
            
        default:
            return [LTableViewCell class];
    }
}

+ (NSString *)reuseIdentifierForType:(LTableType)type {
    switch (type) {
        case LTableTypeList:
            return [LAllListsViewCell reuseIdentifier];
            
        case LTableTypeItem:
            return [LSingleListViewCell reuseIdentifier];
            
        default:
            return nil;
    }
}

@end

