//
//  LColorTag.h
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LViewTransitionProtocol.h"

@interface LColorTag : UIView <LViewTransitionProtocol>
@property (nonatomic) UIColor *color;

@end
