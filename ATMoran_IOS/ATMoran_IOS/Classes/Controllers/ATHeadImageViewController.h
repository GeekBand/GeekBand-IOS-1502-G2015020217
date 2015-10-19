//
//  ATHeadImageViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/16.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATBaseViewController.h"

@interface ATHeadImageViewController : ATBaseViewController


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (nonatomic, weak) UIImage *headImage;


- (IBAction)doneButtonClicked:(id)sender;

- (IBAction)selectImageButtonClicked:(id)sender;

@end
