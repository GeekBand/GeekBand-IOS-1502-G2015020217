//
//  ATRegisterViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#define yShiftConfrimTextField 113
#define yShiftpasswordTextField 40
#define yShiftEmailTextField 5
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

    if ([self validateEmail:self.emailTextField.text] &&
        [self validatePassword:self.passwordTextField.text] &&
        [self passwordMatch]) {
        
        
    }else {
        [self shakeView:self.incorrectEmailLabel];
        [self shakeView:self.incorrectPasswordLabel];
        [self shakeView:self.passwordUnmatchLabel];
    }
 
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        
        [UIView animateWithDuration:0.35 animations:^{
            [self.contentScrollView setContentOffset:CGPointMake(0, yShiftEmailTextField)];
        }];
        
    }else if (textField == self.comfirmpasswordTextField) {

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
    if (textField == self.emailTextField) {
        
        if ([self validateEmail:self.emailTextField.text]) {
            self.incorrectEmailLabel.hidden = YES;
        }else {
            self.incorrectEmailLabel.hidden = NO;
        }
        
    }else if (textField == self.passwordTextField){
        
        if ([self validatePassword:self.passwordTextField.text]) {
            self.incorrectPasswordLabel.hidden = YES;
        }else {
            self.incorrectPasswordLabel.hidden = NO;
        }
        
    }else if (textField == self.comfirmpasswordTextField) {
        
        if ([self passwordMatch]) {
            self.passwordUnmatchLabel.hidden = YES;
        }else {
            self.passwordUnmatchLabel.hidden = NO;
        }

    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.accountTextField) {
        [self.emailTextField becomeFirstResponder];
    }else if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField == self.passwordTextField){
        [self.comfirmpasswordTextField becomeFirstResponder];
    }else {
        [textField resignFirstResponder];
        [self contentScrollViewShiftRecover];
    }
    
    return YES;
}

#pragma mark - Gestrue methods
- (void)handleTapGestrue:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded )
    {
        
        if ([self.accountTextField isFirstResponder] || [self.emailTextField isFirstResponder] || [self.passwordTextField isFirstResponder] || [self.comfirmpasswordTextField isFirstResponder]) {
            
            [self.accountTextField resignFirstResponder];
            [self.emailTextField resignFirstResponder];
            [self.passwordTextField resignFirstResponder];
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
- (BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

- (BOOL)validatePassword:(NSString *)passwrod {
    if ([passwrod length] >= 6 && [passwrod length] <= 20) {
        return YES;
    }
    return NO;
}

- (BOOL)passwordMatch {
    if ([self.passwordTextField.text isEqualToString:self.comfirmpasswordTextField.text]) {
        return YES;
    }
    return NO;
}

-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t =2.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    
    viewToShake.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform = CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
