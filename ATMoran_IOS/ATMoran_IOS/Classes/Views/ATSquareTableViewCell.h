//
//  ATSquareTableViewCell.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATSquareViewController.h"
@interface ATSquareTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) ATSquareViewController *squareVC;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *commentCollectionView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *pic_id;


@end
