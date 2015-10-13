//
//  ATLoginViewController.h
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)touchDownAction:(id)sender;


@end
