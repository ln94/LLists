//
//  LListsManager.m
//  LLists
//
//  Created by Lana Shatonova on 4/11/16.
//  Copyright © 2016 Lana. All rights reserved.
//

#import "LListsManager.h"

@implementation LListsManager

- (void)createDefaultLists {
    
    for (int i = 0; i < 4; i++) {
        List *list = [List create];
        list.index = [NSNumber numberWithInt:i];
        switch (i) {
            case 0:
                list.title = @"Today";
                break;
                
            case 1:
                list.title = @"Tomorrow";
                break;
                
            case 2:
                list.title = @"This Weekend";
                break;
                
            case 3:
                list.title = @"Next Week";
                break;
                
            default:
                break;
        }
    }
    [DataStore save];

}

@end
