//
//  ATSquareRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATSquareModel.h"

@class ATSquareRequest;

@protocol ATSquareRequestDelegate <NSObject>

- (void)squareRequestSuccess:(ATSquareRequest *)request squareModel:(ATSquareModel *)squareModel;
- (void)squareRequestFailed:(ATSquareRequest *)request error:(NSError *)error;

@end

@interface ATSquareRequest : NSObject

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATSquareRequestDelegate> delegate;

- (void)sendSquareRequestWithParameter:(NSDictionary *)paramDic
                              delegate:(id <ATSquareRequestDelegate>)delegate;



@end
