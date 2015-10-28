//
//  ATLocationParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/20.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATLocationParser.h"

@implementation ATLocationParser

-(ATLocationModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    if (error) {
        NSLog(@"The parser is not work.");
    } else {
        ATLocationModel *locationModel = [[ATLocationModel alloc] init];
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [jsonDic valueForKey:@"addrList"];
            if ([[data class] isSubclassOfClass:[NSArray class]]) {
                NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
                
                id name = [data valueForKey:@"name"];
                if ([[name class] isSubclassOfClass:[NSArray class]]) {
                    locationModel.nameArray = name;
                    
                }
                
                id admName = [data valueForKey:@"admName"];
                if ([[admName class] isSubclassOfClass:[NSArray class]]) {
                    [tempDic setValue:admName forKey:@"admName"];
                    locationModel.addrArray = admName;
                }
                
            }
            
            
            
            return locationModel;
        }
    }
    return nil;
}

@end
