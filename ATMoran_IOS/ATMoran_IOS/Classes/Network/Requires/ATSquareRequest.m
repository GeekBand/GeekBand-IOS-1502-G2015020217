//
//  ATSquareRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareRequest.h"
#import "ATSquareRequestParser.h"
#import "ATGlobal.h"

@implementation ATSquareRequest

- (void)sendSquareRequestWithParameter:(NSDictionary *)paramDic delegate:(id<ATSquareRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/node/list";
    
    //GET提交。参数user_id，token，longitude，latitude，distance。返回地理位置的列表，以及
    //各自的图片url列表。按距离排序。
    
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString,[ATGlobal shareGloabl].user.userId];
    urlString = [NSString stringWithFormat:@"%@&token=%@", urlString,[ATGlobal shareGloabl].user.token];
    urlString = [NSString stringWithFormat:@"%@&longitude=%@", urlString,@"121.47794"];
    urlString = [NSString stringWithFormat:@"%@&latitud=%@", urlString,@"31.22516"];
    urlString = [NSString stringWithFormat:@"%@&distance=%@", urlString,@"1000"];
    
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
    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"Square receive data string:%@", string);
    
    ATSquareModel *squareModel = nil;
    if (self.receivedData) {
        ATSquareRequestParser *parser = [[ATSquareRequestParser alloc] init];
        squareModel = [parser parseJson:self.receivedData];
    }
    
    if ([_delegate respondsToSelector:@selector(squareRequestSuccess:squareModel:)]) {
        [_delegate squareRequestSuccess:self squareModel:squareModel];
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
