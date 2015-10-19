//
//  ATUserModel.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATUserModel : NSObject

@property (nonatomic , copy) NSString *username;
@property (nonatomic , copy) NSString *email;
@property (nonatomic , copy) NSString *password;
@property (nonatomic , copy) NSString *loginReturnMessage;
@property (nonatomic , copy) NSString *registerReturnMessage;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userId;

@property (nonatomic, strong) UIImage *image;

@end
