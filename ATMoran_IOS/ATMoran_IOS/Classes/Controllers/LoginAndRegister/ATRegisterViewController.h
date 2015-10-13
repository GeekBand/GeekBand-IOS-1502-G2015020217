//
//  ATRegisterViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmpasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;



- (IBAction)registerButtonClicked:(id)sender;

- (IBAction)loginButtonClicked:(id)sender;

@end
