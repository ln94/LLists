//
//  LSingleListViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSwipeCell.h"
#import "LItemCellView.h"

@interface LSingleListViewCell : LSwipeCell

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) LItemCellView *itemView;

+ (NSString *)reuseIdentifier;

+ (CGFloat)rowHeightForText:(NSString *)text;

- (CGRect)getTextViewFrame;

- (void)updateViews;

@end
