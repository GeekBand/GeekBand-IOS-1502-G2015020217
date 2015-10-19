//
//  ATPhotoDetailViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATPhotoDetailViewController : ATBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *PhotoImage;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *LocalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (copy,nonatomic ) NSString *pic_id;

@end
