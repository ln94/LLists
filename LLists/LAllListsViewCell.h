//
//  LAllListsViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSwipeCell.h"

@interface LAllListsViewCell : LSwipeCell

@property (nonatomic) List *list;

+ (NSString *)reuseIdentifier;

@end
