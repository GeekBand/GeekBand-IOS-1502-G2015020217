//
//  ATRegisterViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#define yShiftConfrimTextField 100
#define yShiftpasswordTextField 30
#import "ATRegisterViewController.h"

@interface ATRegisterViewController ()
{
    UITapGestureRecognizer *_tapGesture;
}
@end

@implementation ATRegisterViewController
- (void)dealloc
{
    [self.view removeGestureRecognizer:_tapGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerButton.layer.cornerRadius = 5.0f;
    
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    [self.view addGestureRecognizer:_tapGesture];
    
}

#pragma mark - ButtonClicked methods
- (IBAction)registerButtonClicked:(id)sender {
    
    
    
    
    if ([self.comfirmpasswordTextField isFirstResponder]) {
        [self.comfirmpasswordTextField resignFirstResponder];
        [self contentScrollViewShiftRecover];
    }
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.comfirmpasswordTextField) {

        [UIView animateWithDuration:0.35 animations:^{
            [self.contentScrollView setContentOffset:CGPointMake(0, yShiftConfrimTextField)];
        }];
        
    }else if (textField == self.passwordTextField){
        [UIView animateWithDuration:0.35 animations:^{
            [self.contentScrollView setContentOffset:CGPointMake(0, yShiftpasswordTextField)];
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == self.comfirmpasswordTextField) {
        [self contentScrollViewShiftRecover];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField){
        [self.comfirmpasswordTextField becomeFirstResponder];
    }else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Gestrue methods
- (void)handleTapGestrue:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded )
    {
        if ([self.emailTextField isFirstResponder]) {
            [self.emailTextField resignFirstResponder];
            
        }else if ([self.passwordTextField isFirstResponder]){
            [self.passwordTextField resignFirstResponder];
            [self contentScrollViewShiftRecover];
            
        }else if ([self.comfirmpasswordTextField isFirstResponder]){
            [self.comfirmpasswordTextField resignFirstResponder];
            [self contentScrollViewShiftRecover];
        }
        
    }
    
}

- (void)contentScrollViewShiftRecover{
    [UIView animateWithDuration:0.35 animations:^{
        [self.contentScrollView setContentOffset:CGPointMake(0, 0)];
    }];
}

#pragma mark - other
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
