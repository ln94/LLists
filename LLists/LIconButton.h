//
//  LIconButton.h
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LViewTransitionProtocol.h"

typedef NS_ENUM(NSInteger, LIcon) {
    LIconPlus = 0,
    LIconBack,
    LIconForward,
    LIconCircle,
    LIconCross
};

@interface LIconButton : UIButton <LViewTransitionProtocol>

@property (nonatomic) LIcon icon;

@end
