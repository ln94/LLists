//
//  LShadowView.h
//  LLists
//
//  Created by Lana Shatonova on 11/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LShadowViewDelegate;


@interface LShadowView : UIView

@property (nonatomic, strong) id<LShadowViewDelegate> delegate;

@end


@protocol LShadowViewDelegate <NSObject>

@required
- (void)shadowViewDidSwipeUp;
- (void)shadowViewDidSwipeDown;
- (void)shadowViewDidTap;

@end
