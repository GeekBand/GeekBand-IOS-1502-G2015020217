//
//  ATPhotoDetailRequestParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/11/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATPhotoDetailRequestParser.h"

@implementation ATPhotoDetailRequestParser

- (ATPhotoDetailModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    ATPhotoDetailModel *model = nil;
    
    if (error) {
        NSLog(@"The parser is not work.");
    } else {
        
        model = [[ATPhotoDetailModel alloc] init];
        
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [jsonDic valueForKey:@"data"];
        
            for (id dic in data) {
                
                [model setValuesForKeysWithDictionary:dic];

            }
        }
        
    }
    return model;
}

@end
