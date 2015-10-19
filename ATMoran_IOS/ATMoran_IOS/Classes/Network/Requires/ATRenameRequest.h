//
//  ATRenameRequest.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATRenameRequest;

@protocol ATRenameRequestDelegate <NSObject>

- (void)renameRequestSuccess:(ATRenameRequest *)request ;
- (void)renameRequestfail:(ATRenameRequest *)request error:(NSError *)error;

@end

@interface ATRenameRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <ATRenameRequestDelegate> delegate;

- (void)sendReNameRequestWithName:(NSString *)name
                         delegate:(id <ATRenameRequestDelegate>)delegate;



@end
