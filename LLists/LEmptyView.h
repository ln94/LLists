//
//  LEmptyView.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LViewTransitionProtocol.h"

@interface LEmptyView : UIView <LViewTransitionProtocol>

- (instancetype)initInTableView:(UITableView *)tableView forType:(LTableType)type;

@end
