//
//  ATLoginViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//
#import "ATLoginViewController.h"
#import "ATLoginRequires.h"
#import "AppDelegate.h"
#import "ATGlobal.h"
#import "ATGetHeadImageRequest.h"

@interface ATLoginViewController ()<UITextFieldDelegate,ATLoginRequiresDelegate>
{
    NSString *_myEmail;
    NSString *_myPassword;
    
    UITextField *_targetTextField;
}

@end

@implementation ATLoginViewController

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)  name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)  name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readLocalInformation];

    self.loginButton.layer.cornerRadius = 5.0f;
    self.loginButton.clipsToBounds = YES;
 
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    [self.view addGestureRecognizer:tapGesture];
  
}

#pragma mark - keyboardNotification methods
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (_targetTextField) {
        
        NSDictionary *userInfoDic = notification.userInfo;
        CGRect keyboardRect = [[userInfoDic valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardY = keyboardRect.origin.y;
        CGFloat targetTextFieldY = _targetTextField.frame.origin.y + _targetTextField.frame.size.height;
        CGFloat keyboardOffSet = targetTextFieldY - keyboardY;

        if (keyboardOffSet > 0) {
            [UIView animateWithDuration:0.25 animations:^{
                [self.view setFrame:CGRectMake(0, -keyboardOffSet, self.view.frame.size.width, self.view.frame.size.height)];
            }];
        }
        
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.view.frame.origin.y < 0 ) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        }];
    }
    _targetTextField = nil;
}

#pragma mark - readLocalInformation
-(void)readLocalInformation{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _myEmail = [defaults stringForKey:@"email"];
    _myPassword = [defaults stringForKey:@"password"];
    
    if (_myEmail){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"是否使用本地邮箱密码"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        self.emailTextField.text = _myEmail;
        self.passwordTextField.text = _myPassword;
    }
}



#pragma mark - ButtonClicked methods
- (IBAction)loginButtonClicked:(id)sender {

    if ([self emailOK] && [self passwordOK]) {
        
        [self loginRequiresHandler];
       
    }else {
        
        if (![self emailOK]) {
            self.incorrectEmailLabel.hidden = NO;
            [self shakeView:self.incorrectEmailLabel];
        }
        if (![self passwordOK]) {
            self.incorrectPasswordLabel.hidden = NO;
            [self shakeView:self.incorrectPasswordLabel];
        }
        
    }
    
    
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.emailTextField) {
        [self.passwordTextField becomeFirstResponder];
        
    }else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _targetTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
 
    if (textField == self.emailTextField) {
        
        if ([self emailOK]) {
            self.incorrectEmailLabel.hidden = YES;
        }else {
            self.incorrectEmailLabel.hidden = NO;
        }
        
    }
    
    else if (textField == self.passwordTextField) {
        
        if ([self passwordOK]) {
            self.incorrectPasswordLabel.hidden = YES;
        }else {
            self.incorrectPasswordLabel.hidden = NO;
        }
        
    }
    
}

#pragma mark - Gestrue methods
- (void)handleTapGestrue:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded)
    {
        
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        
    }
    
}

#pragma mark - loginRequireDelegate
- (void)loginRequiresHandler
{
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"GeekBand-I150001";
    
    ATLoginRequires *loginRequest = [[ATLoginRequires alloc] init];
    [loginRequest sendLoginRequestWithUserEmail:email
                                       password:password
                                           gbid:gbid
                                       delegate:self];
}

- (void)loginRequiresSuccess:(ATLoginRequires *)requires user:(ATUserModel *)user
{
    if ([user.loginReturnMessage isEqualToString:@"Login success"]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadMainViewWithController:self];
        
        
        [ATGlobal shareGloabl].user = user;
        [ATGlobal shareGloabl].user.email= self.emailTextField.text;
        
        ATGetHeadImageRequest *getImageRequest=[[ATGetHeadImageRequest alloc]init];
        [getImageRequest sendGetImageRequest];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.emailTextField.text forKey:@"email"];
        [defaults setObject:self.passwordTextField.text forKey:@"password"];
        [defaults synchronize];
     
    }
    
}

- (void)loginRequiresFailed:(ATLoginRequires *)requires error:(NSError *)error
{
    
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
