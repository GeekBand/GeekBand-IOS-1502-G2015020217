//
//  ATPublishRequestParser.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPublishModel.h"
@interface ATPublishRequestParser : NSObject


-(ATPublishModel*)parseJson:(NSData *)data;

@end
