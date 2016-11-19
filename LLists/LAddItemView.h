//
//  LAddItemView.h
//  LLists
//
//  Created by Lana Shatonova on 10/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LItemCellView.h"
#import "LIconButton.h"

@interface LAddItemView : LItemCellView

@property (nonatomic) LIconButton *plusButton;

- (void)clear;

- (void)setShowingPlusButton:(BOOL)showing completion:(void (^)())completion;

@end
