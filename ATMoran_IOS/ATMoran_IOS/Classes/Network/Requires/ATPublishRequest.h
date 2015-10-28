//
//  ATPublishRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATPublishRequest;


@protocol ATPublishRequestDelegate <NSObject>

- (void)requestSuccess:(ATPublishRequest *)request picId:(NSString *)picId;
- (void)requestFailed:(ATPublishRequest *)request error:(NSError *)error;

@end


@interface ATPublishRequest : NSObject

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property(nonatomic, assign)id<ATPublishRequestDelegate> delegate;

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                            latitude:(NSString *)latitude
                               title:(NSString *)title
                           photoData:(NSData *)photoData
                            location:(NSString *)location
                                addr:(NSString *)addr
                            delegate:(id<ATPublishRequestDelegate>)delegate;

@end
