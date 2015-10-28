//
//  ATPublishViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATPublishViewController.h"
#import "ATPublishRequest.h"
#import "ATPublishRequestParser.h"
#import "ATLocationManager.h"
#import "ATGlobal.h"

@interface ATPublishViewController () <ATLocationManagerDelegate,ATPublishRequestDelegate,UITextViewDelegate>
{
    BOOL       _updateLocationFinished;
    UIButton   *_publishButton;
}

@end

@implementation ATPublishViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [_publishButton removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pubilshImage.image= self.publishPhoto;
    
    [self makePublishButton];
    
    UIToolbar *topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *btnSapce = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboardAndShiftBack)];
    NSArray *buttonArray = [NSArray arrayWithObjects:btnSapce, doneButton, nil];
    [topView setItems:buttonArray];
    [self.titleTextView setInputAccessoryView:topView];
    
    _updateLocationFinished = NO;
    [ATLocationManager sharedInstance].delegate = self;
    [[ATLocationManager sharedInstance] updateLBS];


}

-(void)makePublishButton{
    
    _publishButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, 0, 50, 40)];
    _publishButton.backgroundColor = [UIColor whiteColor];
    _publishButton.alpha = 0.8;
    [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [_publishButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_publishButton addTarget:self action:@selector(publishPhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _publishButton.layer.cornerRadius = 3.0;
    _publishButton.clipsToBounds = YES;
    
    [self.navigationController.navigationBar addSubview:_publishButton];
    
}


#pragma mark - buttonClicked methods
- (IBAction)publishLocation:(id)sender {
    
    _updateLocationFinished = NO;
    [[ATLocationManager sharedInstance] updateLBS];
}

- (IBAction)returnToCamera:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)publishPhotoButtonClicked:(UIButton *)button{
    
    if (_updateLocationFinished) {
        [self publishRequestHandler];
    }else {
        //wait until location update complete
    }
}

#pragma mark - textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.35 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(0, 80);
    }];
    
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }

    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"%@",textView.text);
    NSInteger number = [textView.text length];
    if (number > 25) {
        textView.text = [textView.text substringToIndex:25];
        number = 25;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%d/25",number];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView.text.length < 1) {
        textView.text = @"你想说的话";
    }
    
}

- (void)resignKeyboardAndShiftBack
{
    [self.titleTextView resignFirstResponder];
    [UIView animateWithDuration:0.35 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark - publish request delegate
- (void)publishRequestHandler
{

    NSString *userId = [ATGlobal shareGloabl].user.userId;
    NSString *token = [ATGlobal shareGloabl].user.token;
    NSString *longitude = [ATLocationManager sharedInstance].longitude;
    NSString *latitude = [ATLocationManager sharedInstance].latitude;
    NSString *title = self.titleTextView.text;//not nil
    NSString *location = @"";
    NSString *addr = @"test address";
    NSData *data = UIImageJPEGRepresentation(self.pubilshImage.image, 0.00001);
    
    
    
    ATPublishRequest *request = [[ATPublishRequest alloc] init];
    [request sendPublishRequestWithUserId:userId
                                    token:token
                                longitude:longitude
                                 latitude:latitude
                                    title:title
                                photoData:data
                                 location:location
                                     addr:addr
                                 delegate:self];
    
}

- (void)requestSuccess:(ATPublishRequest *)request picId:(NSString *)picId
{
   
}


- (void)requestFailed:(ATPublishRequest *)request error:(NSError *)error
{
    NSLog(@"publishRequestFail:%@",error.description);

}

#pragma mark - positionManager delegate
- (void)updateLocationSuccess:(ATLocationManager *)manager
{
    _updateLocationFinished = YES;
    self.locationButton.titleLabel.text = [ATLocationManager sharedInstance].address;
    
}

- (void)updateLocationFail:(ATLocationManager *)manager error:(NSError *)error
{
    _updateLocationFinished = YES;
}


#pragma mark other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
