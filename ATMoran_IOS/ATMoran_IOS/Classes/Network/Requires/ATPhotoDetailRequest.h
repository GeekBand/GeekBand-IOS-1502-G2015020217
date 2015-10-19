//
//  ATPhotoDetailRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATPhotoDetailRequest;

@protocol ATPhotoDetailRequestDelegate <NSObject>

- (void)viewDetailRequestSuccess:(ATPhotoDetailRequest *)request data:(NSData *)dictionary;

- (void)viewDetailRequestFailed:(ATPhotoDetailRequest *)request error:(NSError *)error;

@end

@interface ATPhotoDetailRequest : NSObject

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATPhotoDetailRequestDelegate> delegate;

- (void)sendViewDetailRequestWithParameter:(NSDictionary *)paramDic
                                  delegate:(id <ATPhotoDetailRequestDelegate>)delegate;



@end
