//
//  LSecondClassView.h
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSecondClassViewProtocol <NSObject>

@required
- (void)initInView:(UIView *)view;

@end


@interface LSecondClassView : UIView <LSecondClassViewProtocol>

@end


