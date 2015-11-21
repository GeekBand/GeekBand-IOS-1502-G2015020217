//
//  ATPhotoDetailRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATPhotoDetailRequest.h"
#import "ATPhotoDetailRequestParser.h"

@implementation ATPhotoDetailRequest

-(void)sendViewDetailRequestWithParameter:(NSDictionary *)paramDic delegate:(id<ATPhotoDetailRequestDelegate>)delegate{
    
    
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/comment?user_id=%@&token=%@&pic_id=%@",paramDic[@"user_id"], paramDic[@"token"], paramDic[@"pic_id"]];
    
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
//    NSString *receivedString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
//    NSLog(@"detail:%@",receivedString);
    
    ATPhotoDetailRequestParser *parser = [[ATPhotoDetailRequestParser alloc] init];
    ATPhotoDetailModel *photoDetailModel = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(ATPhotoDetailRequestSuccess:data:)]) {
        [_delegate ATPhotoDetailRequestSuccess:self data:photoDetailModel];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(ATPhotoDetailRequestFailed:error:)]) {
        [_delegate ATPhotoDetailRequestFailed:self error:error];
    }
}



@end
