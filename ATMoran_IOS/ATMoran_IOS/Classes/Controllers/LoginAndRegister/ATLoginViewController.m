//
//  ATLoginViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/13.
//  Copyright © 2015年 Ants. All rights reserved.
//

#define yShiftpasswordTextField 30

#import "ATLoginViewController.h"
#import "ATLoginRequires.h"
#import "AppDelegate.h"
#import "ATGlobal.h"
#import "ATGetHeadImageRequest.h"

@interface ATLoginViewController ()<UITextFieldDelegate,ATLoginRequiresDelegate>
{
    UITapGestureRecognizer *_tapGesture;
    NSString *_myEmail;
    NSString *_myPassword;
}
@end

@implementation ATLoginViewController
- (void)dealloc
{
    [self.view removeGestureRecognizer:_tapGesture];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readInformation];

    
    self.loginButton.layer.cornerRadius = 5.0f;
    self.loginButton.clipsToBounds = YES;
 
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestrue:)];
    [self.view addGestureRecognizer:_tapGesture];
    
}

// 读取本地化的数据
-(void)readInformation{
    
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

    if ([self validateEmail:self.emailTextField.text] && [self validatePassword:self.passwordTextField.text]) {
        
        NSString *email = self.emailTextField.text;
        NSString *password = self.passwordTextField.text;
        NSString *gbid = @"GeekBand-I150001";
        
        
        ATLoginRequires *loginRequest = [[ATLoginRequires alloc] init];
        [loginRequest sendLoginRequestWithUserEmail:email
                                           password:password
                                               gbid:gbid
                                           delegate:self];
        
        
    }else {
        
        if (![self validateEmail:self.emailTextField.text]) {
            self.incorrectEmailLabel.hidden = NO;
            [self shakeView:self.incorrectEmailLabel];
        }
        if (![self validatePassword:self.passwordTextField.text]) {
            self.incorrectPasswordLabel.hidden = NO;
            [self shakeView:self.incorrectPasswordLabel];
        }
        
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

#pragma mark - loginRequireDelegate
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
        
        
        
    }else {
        
        
        
    }
}

- (void)loginRequiresFailed:(ATLoginRequires *)requires error:(NSError *)error
{
    
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
