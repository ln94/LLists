//
//  LItemCellRightSwipeView.h
//  LLists
//
//  Created by Lana Shatonova on 18/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIconButton.h"

@interface LItemCellRightSwipeView : UIView

@property (nonatomic, strong) LIconButton *deleteButton;

+(CGFloat)width;

@end
