//
//  ATLoginRequires.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATUserModel.h"

@class ATLoginRequires;
@protocol ATLoginRequiresDelegate <NSObject>

- (void)loginRequiresSuccess:(ATLoginRequires *)requires user:(ATUserModel *)user;
- (void)loginRequiresFailed:(ATLoginRequires *)requires  error:(NSError *)error;

@end

@interface ATLoginRequires : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong)NSURLConnection *URLConnection;
@property (nonatomic, strong)NSMutableData *receivedData;
@property (nonatomic, assign)id<ATLoginRequiresDelegate> delegate;

- (void)sendLoginRequestWithUserEmail:(NSString *)email
                               password:(NSString *)password
                            gbid:(NSString *)gbid
                            delegate:(id<ATLoginRequiresDelegate>)delegate;

- (void)cancelRequest;

@end
