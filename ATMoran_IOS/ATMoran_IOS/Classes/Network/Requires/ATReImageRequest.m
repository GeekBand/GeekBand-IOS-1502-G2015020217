//
//  ATReImageRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATReImageRequest.h"
#import "BLMultipartForm.h"
#import "ATGlobal.h"

@implementation ATReImageRequest

- (void)sendReImageRequestWithImage:(UIImage *)image delegate:(id<ATReImageRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web//user/avatar";
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    NSData *data;
    data = UIImageJPEGRepresentation(image, 0.000001);
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue: [ATGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[ATGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:data forField:@"data"];
    request.HTTPBody = [form httpBodyForImage];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
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
    NSLog(@"ReImage receive data string:%@", string);
    
    if ([_delegate respondsToSelector:@selector(reImageRequestSuccess:)]) {
        [_delegate reImageRequestSuccess:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    
    if ([_delegate respondsToSelector:@selector(reImageRequestfail:error:)]) {
        [_delegate reImageRequestfail:self error:error];
    }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"bytesWritten: %ld", (long)bytesWritten);
    NSLog(@"totalWritten: %ld", (long)totalBytesWritten);
    NSLog(@"totalBytesExpectedToWrite: %ld", (long)totalBytesWritten);
}

@end
