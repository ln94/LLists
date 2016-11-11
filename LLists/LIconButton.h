//
//  LIconButton.h
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LIcon) {
    LIconPlus = 0,
    LIconBack,
    LIconCircle,
    LIconCross
};

typedef NS_ENUM(NSInteger, LMoveDirection) {
    LMoveDirectionLeft = 0,
    LMoveDirectionRight
};

@interface LIconButton : UIButton

@property (nonatomic) LIcon icon;

- (void)moveIcon:(LMoveDirection)direction by:(CGFloat)by;

@end
