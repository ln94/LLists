//
//  LListCellView.h
//  LLists
//
//  Created by Lana Shatonova on 9/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LColorTag.h"
#import "LTextField.h"
#import "LSeparator.h"

@interface LListCellView : UIView

@property (nonatomic, strong) LColorTag *colorTag;
@property (nonatomic, strong) LTextField *textField;
@property (nonatomic, strong) LSeparator *separator;

@end
