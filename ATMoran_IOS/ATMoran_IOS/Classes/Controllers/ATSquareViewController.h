//
//  ATSquareViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATSquareViewController : ATBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)pictureSelectedWithPictureUrl:(NSString *)pic_url pictureId:(NSString *)pic_id;

@end
