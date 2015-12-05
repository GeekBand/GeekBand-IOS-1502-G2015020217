//
//  ATGetHeadImageRequest.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/17.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATGetHeadImageRequest.h"
#import "ATGlobal.h"

@implementation ATGetHeadImageRequest

- (void) sendGetImageRequest{
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/show";
    urlString = [NSString stringWithFormat:@"%@?user_id=%@", urlString, [ATGlobal shareGlobal].user.userId];
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [ATGlobal shareGlobal].user.image = [UIImage imageWithData:data];
    
}

@end
