//
//  ATPhotoDetailModel.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/11/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATPhotoDetailModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *shop_id;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *comment;
@property (nonatomic,strong) NSString *modified;
@property (nonatomic,strong) NSString *pic_id;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end
