//
//  LDoneButton.h
//  LLists
//
//  Created by Lana Shatonova on 2/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDoneButtonDelegate;

@interface LDoneButton : UIView

@property (nonatomic) id<LDoneButtonDelegate> delegate;

@end

@protocol LDoneButtonDelegate <NSObject>

@required
- (void)didPressDoneButton:(LDoneButton *)button;

@end
