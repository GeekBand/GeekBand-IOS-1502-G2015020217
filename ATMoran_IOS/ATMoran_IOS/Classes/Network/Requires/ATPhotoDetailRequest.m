//
//  ATPhotoDetailRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATPhotoDetailRequest.h"

@implementation ATPhotoDetailRequest

-(void)sendViewDetailRequestWithParameter:(NSDictionary *)paramDic delegate:(id<ATPhotoDetailRequestDelegate>)delegate{
    
    
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web//picture/read?pic_id=%@&token=%@&user_id=%@",paramDic[@"pic_id"], paramDic[@"token"], paramDic[@"user_id"]];
    // POST请求
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData; // 忽略本地和远程的缓存
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

#pragma mark - 网络请求代理方法

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
    //    NSLog(@"ViewDetail receive data string:%@", string);
    //
    //    GBMSquareRequestParser *parser = [[GBMSquareRequestParser alloc] init];
    if ([_delegate respondsToSelector:@selector(viewDetailRequestSuccess:data:)]) {
        [_delegate viewDetailRequestSuccess:self data:self.receivedData];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(viewDetailRequestFailed:error:)]) {
        [_delegate viewDetailRequestFailed:self error:error];
    }
}



@end
