//
//  ATLoginRequireParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATLoginRequireParser.h"

@implementation ATLoginRequireParser

- (ATUserModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"parseJson fail:%@",error.description);
        
    }else {
        
        ATUserModel *user = [[ATUserModel alloc] init];
        
        id data = [jsonDic valueForKey:@"data"];
        if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
            
            id userId = [data valueForKey:@"user_id"];
            if ([[userId class] isSubclassOfClass:[NSString class]]) {
                user.userId = userId;
            }
            
            id token = [data valueForKey:@"token"];
            if ([[token class] isSubclassOfClass:[NSString class]]) {
                user.token = token;
            }
            
        }
        
        
        
        id returnMessage = [jsonDic valueForKey:@"message"];
        if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
            
            user.loginReturnMessage = returnMessage;
            
            
        }
        
        return user;
    }
    
    return nil;
}

@end
