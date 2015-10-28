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
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

- (IBAction)returnToCamera:(id)sender;
- (IBAction)publishLocation:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (strong , nonatomic)UIImage *publishPhoto;

@end
