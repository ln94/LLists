//
//  LTableViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LTableViewCell.h"

@implementation LTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;

    self.backgroundColor = C_WHITE;
    
    // Separator
    self.separator = [[LSeparatorButton alloc] initInSuperview:self.contentView edge:UIViewEdgeBottom length:kSeparatorHeight];
    [self.separator addTarget:self action:@selector(didPressSeparator:)];
    
    // Long Press
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self addGestureRecognizer:longPress];
    
    return self;
}

- (void)didPressSeparator:(LSeparatorButton *)separator {
    if (self.delegate) {
        [self.delegate tableViewCell:self didPressSeparator:separator];
    }
}

- (void)longPressed:(UILongPressGestureRecognizer *)longPress {    

    if (self.delegate) {
        [self.delegate tableViewCell:self longPressed:longPress];
    }

}

@end
