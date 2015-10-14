//
//  ATLoginViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *incorrectEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *incorrectPasswordLabel;

- (IBAction)loginButtonClicked:(id)sender;


@end
