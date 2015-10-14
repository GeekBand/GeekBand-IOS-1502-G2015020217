//
//  ATLoginRequires.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATLoginRequires.h"
#import "BLMultipartForm.h"
#import "ATLoginRequireParser.h"

@implementation ATLoginRequires

- (void)sendLoginRequestWithUserEmail:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<ATLoginRequiresDelegate>)delegate
{
    [self.URLConnection cancel];
    
    self.delegate = delegate;

    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/login";
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
    self.URLConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
    
    
    
}

- (void)cancelRequest
{
    if (self.URLConnection) {
        self.URLConnection = nil;
    }
}

#pragma mark - Request Delegate
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
    NSString *stirng = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"receive data string:%@",stirng);
    
    ATLoginRequireParser *parser = [[ATLoginRequireParser alloc] init];
    ATUserModel *user = nil;
    
    if (self.receivedData) {
        user = [parser parseJson:self.receivedData];
    }
    
    if ([_delegate respondsToSelector:@selector(loginRequiresSuccess:user:)]) {
        [_delegate loginRequiresSuccess:self user:user];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error.description);
    if ([_delegate respondsToSelector:@selector(loginRequiresFailed:error:)]) {
        [_delegate loginRequiresFailed:self error:error];
    }
}
@end
