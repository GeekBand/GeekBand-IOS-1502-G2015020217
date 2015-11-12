//
//  ATRegisterViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATRegisterViewController.h"
#import "ATRegisterRequires.h"

@interface ATRegisterViewController () <UITextFieldDelegate,ATRegisterRequiresDelegate>
{
    UITextField *_targetTextField;
    CGFloat _offSetMaxY;
    
}
@end

@implementation ATRegisterViewController

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)  name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)  name:UIKeyboardWillHideNotification object:nil];
    
    _offSetMaxY = self.ScrollViewContentView.frame.size.height - self.ScrollView.frame.size.height;
    _offSetMaxY = _offSetMaxY < 0 ? 0 : _offSetMaxY;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.registerButton.layer.cornerRadius = 5.0f;
    self.registerButton.clipsToBounds = YES;
    
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

#pragma mark - keyboardNotification methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (_targetTextField) {
        
        NSDictionary *userInfoDic = notification.userInfo;

        CGRect keyboardEndRect = [[userInfoDic valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardY = keyboardEndRect.origin.y;
        
        CGFloat targetTextFieldY = _targetTextField.frame.origin.y + _targetTextField.frame.size.height - self.ScrollView.contentOffset.y;
        
        CGFloat offSetY = targetTextFieldY - keyboardY;
        if (offSetY > 0) {
            [self.ScrollView setContentOffset:CGPointMake(0, self.ScrollView.contentOffset.y + offSetY) animated:YES];
        }
        [self.ScrollView setScrollEnabled:NO];
        
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat offSetY = self.ScrollView.contentOffset.y - _offSetMaxY;
    if (offSetY > 0) {
        [self.ScrollView setContentOffset:CGPointMake(0, _offSetMaxY) animated:YES];
    }
    _targetTextField = nil;
    [self.ScrollView setScrollEnabled:YES];
}

#pragma mark - ButtonClicked methods
- (IBAction)registerButtonClicked:(id)sender {

    if ([self accountOK] && [self emailOK] && [self passwordOK] && [self repeatPasswordOK]) {
        
        [self registerRequireHandler];
        
    }else {
        
        if (![self emailOK]) {
            self.incorrectEmailLabel.hidden = NO;
            [self shakeView:self.incorrectEmailLabel];
        }
        if (![self passwordOK]) {
            self.incorrectPasswordLabel.hidden = NO;
            [self shakeView:self.incorrectPasswordLabel];
        }
        if (![self repeatPasswordOK]) {
            self.incorrectRepeatPasswordLabel.hidden = NO;
            [self shakeView:self.incorrectRepeatPasswordLabel];
        }
        if (![self accountOK])
        {
            self.incorrectAccountLabel.hidden = NO;
            [self shakeView:self.incorrectAccountLabel];
        }
        
    }
 
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - RegisterRequire Delegate
- (void)registerRequireHandler
{
    NSString *account = self.accountTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"GeekBand-I150001";
    
    
    ATRegisterRequires *registerReuiqre = [[ATRegisterRequires alloc] init];
    [registerReuiqre sendRegisterRequireWithUserAccount:account
                                                  email:email
                                               password:password
                                                   gbid:gbid delegate:self];
}


- (void)registerRequireSuccess:(ATRegisterRequires *)request user:(ATUserModel *)user
{
    if ([user.registerReturnMessage isEqualToString:@"Register success"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)registerRequireFailed:(ATRegisterRequires *)request error:(NSError *)error
{
    
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _targetTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
 
    if (textField == self.accountTextField) {
        if ([self accountOK]) {
            self.incorrectAccountLabel.hidden = YES;
        }else {
            self.incorrectAccountLabel.hidden = NO;
        }
        
    }
    else if (textField == self.emailTextField) {
        
        if ([self emailOK]) {
            self.incorrectEmailLabel.hidden = YES;
        }else {
            self.incorrectEmailLabel.hidden = NO;
        }
        
    }else if (textField == self.passwordTextField){
        
        if ([self passwordOK]) {
            self.incorrectPasswordLabel.hidden = YES;
        }else {
            self.incorrectPasswordLabel.hidden = NO;
        }
        
    }else if (textField == self.comfirmpasswordTextField) {
        
        if ([self repeatPasswordOK]) {
            self.incorrectRepeatPasswordLabel.hidden = YES;
        }else {
            self.incorrectRepeatPasswordLabel.hidden = NO;
        }

    }
    
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
    }
    
    return YES;
}


#pragma mark - Gestrue methods
- (void)handleTapGestrue:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {

        [self.accountTextField resignFirstResponder];
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        [self.comfirmpasswordTextField resignFirstResponder];

    }
    
}

#pragma mark - checkInput
- (BOOL)emailOK{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.emailTextField.text];
}

- (BOOL)passwordOK{
    
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passwordPredicate evaluateWithObject:self.passwordTextField.text];
    
}

- (BOOL)repeatPasswordOK
{
    if ([self.passwordTextField.text isEqualToString:self.comfirmpasswordTextField.text]) {
        return YES;
    }
    return NO;
}

- (BOOL)accountOK
{
    if ([self.accountTextField.text length] != 0) {
        return YES;
    }
    return NO;
}

#pragma mark - other
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
