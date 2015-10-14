//
//  ATRegisterRequireParser.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUserModel.h"

@interface ATRegisterRequireParser : NSObject

- (ATUserModel *)parseJson:(NSData *)data;

@end
