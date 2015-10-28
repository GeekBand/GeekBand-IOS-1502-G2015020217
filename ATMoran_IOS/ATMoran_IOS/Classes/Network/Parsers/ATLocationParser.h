//
//  ATLocationParser.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/20.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATLocationModel.h"

@interface ATLocationParser : NSObject

- (ATLocationModel *)parseJson:(NSData *)data;

@end
