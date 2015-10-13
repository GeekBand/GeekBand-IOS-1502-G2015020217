//
//  ATLoginViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATLoginViewController.h"

@interface ATLoginViewController ()

@end

@implementation ATLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)loginButtonClicked:(id)sender {
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([userName length] == 0 || [password length] == 0) {
    } else{
        NSLog(@"成功");
    }
         
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


- (void)showErrorMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end
