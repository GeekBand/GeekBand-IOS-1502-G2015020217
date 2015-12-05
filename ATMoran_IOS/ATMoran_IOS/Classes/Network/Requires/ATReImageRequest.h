//
//  ATReImageRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ATReImageRequest;

@protocol ATReImageRequestDelegate <NSObject>

- (void)reImageRequestSuccess:(ATReImageRequest *)request ;
- (void)reImageRequestfail:(ATReImageRequest *)request error:(NSError *)error;

@end

@interface ATReImageRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATReImageRequestDelegate> delegate;

- (void)sendReImageRequestWithImage:(UIImage *)image
                          delegate:(id <ATReImageRequestDelegate>)delegate;



@end