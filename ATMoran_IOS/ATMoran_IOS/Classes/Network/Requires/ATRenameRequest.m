//
//  ATRenameRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATRenameRequest.h"
#import "ATGlobal.h"
#import "BLMultipartForm.h"

@implementation ATRenameRequest

- (void)sendReNameRequestWithName:(NSString *)name delegate:(id<ATRenameRequestDelegate>)delegate{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web//user/rename";
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue: [ATGlobal shareGlobal].user.userId forField:@"user_id"];
    [form addValue:[ATGlobal shareGlobal].user.token forField:@"token"];
    [form addValue:name forField:@"new_name"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

#pragma mark - Request

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
    NSLog(@"ReName data string:%@", string);
    
    if (self.receivedData) {
        if ([_delegate respondsToSelector:@selector(renameRequestSuccess:)]) {
            [_delegate renameRequestSuccess:self];
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(renameRequestfail:error:)]) {
        [_delegate renameRequestfail:self error:error];
    }
}

@end
