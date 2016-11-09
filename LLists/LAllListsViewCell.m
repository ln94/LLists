//
//  LAllListsViewCell.m
//  LLists
//
//  Created by Lana Shatonova on 3/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LAllListsViewCell.h"
#import "LListCellView.h"

static NSString *const reuseIdentifier = @"allListsViewCell";


@interface LAllListsViewCell ()

@property (nonatomic, strong) LListCellView *listView;

@end


@implementation LAllListsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // List View
    self.listView = [[LListCellView alloc] initFullInSuperview:self.contentView];
    
    // Text Field
    self.listView.textField.userInteractionEnabled = NO;
    
    return self;
}

+ (NSString *)reuseIdentifier {
    return reuseIdentifier;
}

- (void)setList:(List *)list {
    _list = list;
    self.listView.textField.text = list.title;
    self.listView.colorTag.color = list.color;
}

@end
