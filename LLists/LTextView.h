//
//  LTextView.h
//  LLists
//
//  Created by Lana Shatonova on 8/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTextView : UITextView

@property (nonatomic, readonly) CGFloat minHeight;

- (CGFloat)heightForText:(NSString *)text;

@end
