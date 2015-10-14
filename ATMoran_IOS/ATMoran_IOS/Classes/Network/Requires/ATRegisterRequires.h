//
//  ATRegisterRequires.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUserModel.h"

@class ATRegisterRequires;

@protocol ATRegisterRequiresDelegate <NSObject>

- (void)registerRequireSuccess:(ATRegisterRequires *)request user:(ATUserModel *)user;
- (void)registerRequireFailed:(ATRegisterRequires *)request error:(NSError *)error;

@end


@interface ATRegisterRequires : NSObject

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATRegisterRequiresDelegate> delegate;

- (void)sendRegisterRequireWithUserAccount:(NSString *)account
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
                               delegate:(id <ATRegisterRequiresDelegate>)delegate;


@end
