//
//  ATSquareRequestParser.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATSquareModel.h"
@interface ATSquareRequestParser : NSObject

- (ATSquareModel *)parseJson:(NSData *)data;

@end
