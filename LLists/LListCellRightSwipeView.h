//
//  LListCellRightSwipeView.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIconButton.h"

@interface LListCellRightSwipeView : UIView

@property (nonatomic, strong) LIconButton *deleteButton;
@property (nonatomic, strong) LIconButton *editButton;

+(CGFloat)width;

@end
