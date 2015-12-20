//
//  ATRegisterRequires.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATRegisterRequires.h"
#import "BLMultipartForm.h"
#import "ATRegisterRequireParser.h"
@implementation ATRegisterRequires

- (void) sendRegisterRequireWithUserAccount:(NSString *)account email:(NSString *)email password:(NSString *)password gbid:(NSString *)gbid delegate:(id<ATRegisterRequiresDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:account forField:@"username"];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

#pragma mark - Require Delegate

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
    NSLog(@"receive data string:%@", string);
    
    if (self.receivedData) {
        ATRegisterRequireParser *parser = [[ATRegisterRequireParser alloc] init];
        ATUserModel *user = [parser parseJson:self.receivedData];
        if ([_delegate respondsToSelector:@selector(registerRequireSuccess:user:)]) {
            [_delegate registerRequireSuccess:self user:user];
        }
    }
        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
    if ([_delegate respondsToSelector:@selector(registerRequireFailed:error:)]) {
        [_delegate registerRequireFailed:self error:error];
    }
}



@end
