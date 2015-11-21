//
//  ATPhotoDetailRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATPhotoDetailModel.h"
@class ATPhotoDetailRequest;

@protocol ATPhotoDetailRequestDelegate <NSObject>

- (void)ATPhotoDetailRequestSuccess:(ATPhotoDetailRequest *)request data:(ATPhotoDetailModel *)model;

- (void)ATPhotoDetailRequestFailed:(ATPhotoDetailRequest *)request error:(NSError *)error;

@end

@interface ATPhotoDetailRequest : NSObject

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATPhotoDetailRequestDelegate> delegate;

- (void)sendViewDetailRequestWithParameter:(NSDictionary *)paramDic
                                  delegate:(id <ATPhotoDetailRequestDelegate>)delegate;



@end
