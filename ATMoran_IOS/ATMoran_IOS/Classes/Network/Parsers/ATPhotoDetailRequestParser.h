//
//  ATPhotoDetailRequestParser.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/11/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPhotoDetailModel.h"

@interface ATPhotoDetailRequestParser : NSObject

- (ATPhotoDetailModel *)parseJson:(NSData *)data;
@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSMutableArray *pictureArray;

@end
