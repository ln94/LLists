//
//  LTableViewCell.h
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSeparatorButton.h"

@protocol LTableViewCellDelegate;


@interface LTableViewCell : UITableViewCell

@property (nonatomic, strong) LSeparatorButton *separator;

@property (nonatomic) id<LTableViewCellDelegate> delegate;

@end


@protocol LTableViewCellDelegate <NSObject>

@required
- (void)tableViewCell:(LTableViewCell *)cell didPressSeparator:(LSeparatorButton *)separator;
- (void)tableViewCell:(LTableViewCell *)cell longPressed:(UILongPressGestureRecognizer *)longPress;

@end
