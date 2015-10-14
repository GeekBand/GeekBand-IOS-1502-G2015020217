//
//  ATRegisterRequireParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATRegisterRequireParser.h"

@implementation ATRegisterRequireParser

- (ATUserModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"parseJson fail:%@",error.description);
        
    }else {
        
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                ATUserModel *user = [[ATUserModel alloc] init];
                user.registerReturnMessage = returnMessage;
                
                return user;
            }
            
            
        }
    }
    
    return nil;
}

@end
