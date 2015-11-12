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
    
//    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/node/list";
//    
//    //GET提交。参数user_id，token，longitude，latitude，distance。返回地理位置的列表，以及
//    //各自的图片url列表。按距离排序。
//    
//    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString,paramDic[@"user_id"]];
//    urlString = [NSString stringWithFormat:@"%@&token=%@", urlString,paramDic[@"token"]];
//    urlString = [NSString stringWithFormat:@"%@&longitude=%@", urlString,paramDic[@"longitude"]];
//    urlString = [NSString stringWithFormat:@"%@&latitud=%@", urlString,paramDic[@"latitude"]];
//    urlString = [NSString stringWithFormat:@"%@&distance=%@", urlString,paramDic[@"distance"]];
    
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
    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    
    ATSquareRequestParser *parser = [[ATSquareRequestParser alloc] init];
    NSDictionary *dic = nil;
    if (self.receivedData) {
        dic = [parser parseJson:self.receivedData];
    }
    
    if ([_delegate respondsToSelector:@selector(squareRequestSuccess:dictionary:)]) {
        [_delegate squareRequestSuccess:self dictionary:dic];
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
