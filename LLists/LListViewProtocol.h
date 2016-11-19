//
//  LListCellViewDelegate.h
//  LLists
//
//  Created by Lana Shatonova on 20/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LSecondClassView.h"
#import "LColorTag.h"
#import "LTextField.h"
#import "LSeparator.h"

@protocol LListViewProtocol <LSecondClassViewProtocol>

@required
@property (nonatomic, strong) LColorTag *colorTag;
@property (nonatomic, strong) LTextField *textField;
@property (nonatomic, strong) LSeparator *separator;

@end

@interface UIView (LListViewProtocol) <LListViewProtocol>

- (void)initInView:(UIView *)view;

@end
