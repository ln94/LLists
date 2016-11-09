//
//  LSingleListViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 29/10/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSingleListViewCell : UITableViewCell

@property (nonatomic, strong) Item *item;

+ (NSString *)reuseIdentifier;

+ (CGFloat)rowHeightForText:(NSString *)text;

- (CGRect)textViewFrame;

@end
