//
//  LAddItemView.h
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LItemCellView.h"

@interface LAddItemView : LItemCellView

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion;

@end
