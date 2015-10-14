//
//  ATLoginViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#define yShiftpasswordTextField 30
#import "ATLoginViewController.h"

@interface ATLoginViewController ()<UITextFieldDelegate>
{
    UITapGestureRecognizer *_tapGesture;
}
@end

@implementation ATLoginViewController
- (void)dealloc
{
    [self.view removeGestureRecognizer:_tapGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.loginButton.layer.cornerRadius = 5.0f;
 
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    [self.view addGestureRecognizer:_tapGesture];
    
}

#pragma mark - ButtonClicked methods
- (IBAction)loginButtonClicked:(id)sender {

    if ([self validateEmail:self.emailTextField.text] && [self validatePassword:self.passwordTextField.text]) {
        
        
    }else {
        [self shakeView:self.incorrectEmailLabel];
        [self shakeView:self.incorrectPasswordLabel];
    }
    
    
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.passwordTextField){
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
        
    }else if (textField == self.passwordTextField) {
        
        if ([self validatePassword:self.passwordTextField.text]) {
            self.incorrectPasswordLabel.hidden = YES;
        }else {
            self.incorrectPasswordLabel.hidden = NO;
        }
        
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
        
    }else {
        [textField resignFirstResponder];
        [self contentScrollViewShiftRecover];
    }
    return YES;
}

#pragma mark - Gestrue methods
- (void)handleTapGestrue:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if ([self.emailTextField isFirstResponder] || [self.passwordTextField isFirstResponder]) {
            
            [self.emailTextField resignFirstResponder];
            [self.passwordTextField resignFirstResponder];
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
- (BOOL)validateEmail:(NSString *)candidate {
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
