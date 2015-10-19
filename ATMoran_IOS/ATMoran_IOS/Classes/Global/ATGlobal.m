//
//  ATGlobal.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATGlobal.h"

static ATGlobal *global = nil;
@implementation ATGlobal



+ (ATGlobal *)shareGloabl
{
    if (global == nil) {
        global = [[ATGlobal alloc] init];
    }
    return global;
}

@end
