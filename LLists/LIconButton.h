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
    LIconCircle
};

@interface LIconButton : UIButton

@property (nonatomic) LIcon icon;

@end
