//
//  ATSquareRequestParser.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareRequestParser.h"
#import "ATpictureModel.h"
@implementation ATSquareRequestParser

- (NSDictionary *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (error) {
        NSLog(@"ATSquareRequestParser is not work.");
    } else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [[jsonDic valueForKey:@"data"] allValues];
            
            __block ATSquareRequestParser *weakSelf = self;
            
            for (id dic in data) {
                weakSelf.addrArray = [NSMutableArray array];
                weakSelf.pictureArray = [NSMutableArray array];
                ATSquareModel *squareModel = [[ATSquareModel alloc] init];
                [squareModel setValuesForKeysWithDictionary:dic[@"node"]];
                for (id picDictionary in dic[@"pic"]) {
                    
                    ATpictureModel *pictureModel = [[ATpictureModel alloc] init];
                    [pictureModel setValuesForKeysWithDictionary:picDictionary];
                    [weakSelf.pictureArray addObject:pictureModel];
                }
                [weakSelf.addrArray addObject:squareModel];
                
                [dictionary setObject:_pictureArray forKey:_addrArray];
            }
        }

    }
    return dictionary;
}


@end
