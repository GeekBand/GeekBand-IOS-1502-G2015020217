//
//  ATSquareRequestParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareRequestParser.h"

@implementation ATSquareRequestParser

- (ATSquareModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
     
                                                   error:&error];
    if (error) {
        NSLog(@"The parser is not work.");
    } else {
        ATSquareModel *squareModel = [[ATSquareModel alloc] init];
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [jsonDic valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                
                id addr = [data valueForKey:@"addr"];
                if ([[addr class] isSubclassOfClass:[NSString class]]) {
                    squareModel.addr = addr;
                }
                
                id pic = [data valueForKey:@"pic"];
                if ([[addr class] isSubclassOfClass:[NSString class]]) {
                    squareModel.pic = pic;
                }
                
            }
            
            
            return squareModel;
        }
    }
    return nil;
}

@end
