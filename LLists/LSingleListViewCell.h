//
//  LSingleListViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSwipeCell.h"

@interface LSingleListViewCell : LSwipeCell

@property (nonatomic, strong) Item *item;

+ (NSString *)reuseIdentifier;

+ (CGFloat)rowHeightForText:(NSString *)text;

- (CGRect)getTextViewFrame;

- (void)updateViews;

@end
