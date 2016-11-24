//
//  LAllListsViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"
#import "LListViewProtocol.h"

@interface LAllListsViewCell : LTableViewCell

@property (nonatomic) List *list;

@property (nonatomic, strong) LSecondClassView<LListViewProtocol> *mainView;

+ (NSString *)reuseIdentifier;

@end
