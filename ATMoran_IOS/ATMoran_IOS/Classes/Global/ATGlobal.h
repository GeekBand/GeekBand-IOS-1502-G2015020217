//
//  ATGlobal.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUserModel.h"


@interface ATGlobal : NSObject

@property(nonatomic, strong)ATUserModel *user;

+ (ATGlobal *)shareGloabl;

@end
