//
//  LSingleListViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"

static const CGFloat kTextContainerInsetY = 7;

@interface LSingleListViewCell : LTableViewCell

+ (NSString *)reuseIdentifier;

+ (CGFloat)rowHeightForText:(NSString *)text;

- (CGRect)textViewFrame;
- (void)setText:(NSString *)text forEditingCell:(BOOL)editing;

@end
