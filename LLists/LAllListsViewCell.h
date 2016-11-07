//
//  LAllListsViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"

@protocol LAllListsViewCellDelegate;

@interface LAllListsViewCell : LTableViewCell

@property (nonatomic) List *list;

@property (nonatomic) id<LTableViewCellDelegate, LAllListsViewCellDelegate> delegate;

+ (NSString *)reuseIdentifier;

@end

@protocol LAllListsViewCellDelegate <NSObject>

@required
- (void)didSelectTableViewCell:(LAllListsViewCell *)cell;

@end
