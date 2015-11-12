//
//  ATPublishViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATPublishViewController : ATBaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *pubilshImage;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (strong , nonatomic)UIImage *publishPhoto;

- (IBAction)repickPhotoButtonClicked:(id)sender;
- (IBAction)locaionButtonClicked:(id)sender;

@end
