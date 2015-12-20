//
//  ATSquareRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareRequest.h"
#import "ATSquareRequestParser.h"

@implementation ATSquareRequest

- (void)sendSquareRequestWithParameter:(NSDictionary *)paramDic delegate:(id<ATSquareRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    self.delegate = delegate;

    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/node/list?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@", paramDic[@"distance"], paramDic[@"latitude"], paramDic[@"longitude"], paramDic[@"token"], paramDic[@"user_id"]];
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
     
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

#pragma mark - request

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
//    NSLog(@"receive data string:%@", string);
    if (self.receivedData) {
        ATSquareRequestParser *parser = [[ATSquareRequestParser alloc] init];
        NSDictionary *dic = [parser parseJson:self.receivedData];
        if ([_delegate respondsToSelector:@selector(squareRequestSuccess:dictionary:)]) {
            [_delegate squareRequestSuccess:self dictionary:dic];
        }
    }
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(squareRequestFailed:error:)]) {
        [_delegate squareRequestFailed:self error:error];
    }
}


@end
