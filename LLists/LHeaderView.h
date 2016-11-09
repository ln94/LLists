//
//  LHeaderView.h
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHeaderViewDelegate;

@interface LHeaderView : UIView

@property (nonatomic) id<LHeaderViewDelegate> delegate;

@end


@protocol LHeaderViewDelegate <NSObject>

@required
- (void)didPressAddButton;

@end
