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
#import "SVProgressHUD.h"
#import "GlobalTool.h"

@interface ATPublishViewController () <ATLocationManagerDelegate,ATPublishRequestDelegate,UITextViewDelegate>
{
    BOOL       _updateLocationFinished;
    UIButton   *_publishButton;
}

@end

@implementation ATPublishViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self makePublishButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_publishButton removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pubilshImage.image= self.publishPhoto;
    
    UIToolbar *topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    topView.backgroundColor = UIColorFromRGB(0xee7f41);
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *btnSapce = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboardAndShiftBack)];
    NSArray *buttonArray = [NSArray arrayWithObjects:btnSapce, doneButton, nil];
    [topView setItems:buttonArray];
    [self.titleTextView setInputAccessoryView:topView];
    
    [ATLocationManager sharedInstance].delegate = self;
    _updateLocationFinished = YES;
    if (![ATLocationManager sharedInstance].location) {
        _updateLocationFinished = NO;
        [[ATLocationManager sharedInstance] updateLBS];
        self.locationLabel.text = @"正在获取地理位置信息";
        
    }else{
        self.locationLabel.text = [ATLocationManager sharedInstance].location;
    }

}

-(void)makePublishButton{
    
    _publishButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, 5, 45, 30)];
    _publishButton.backgroundColor = [UIColor whiteColor];
    [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
    [_publishButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_publishButton addTarget:self action:@selector(publishPhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _publishButton.layer.cornerRadius = 3.0;
    _publishButton.clipsToBounds = YES;
    
    [self.navigationController.navigationBar addSubview:_publishButton];
    
}


#pragma mark - buttonClicked methods
- (IBAction)locaionButtonClicked:(id)sender {
    self.locationLabel.text = @"正在获取地理位置信息";
    _updateLocationFinished = NO;
    [[ATLocationManager sharedInstance] updateLBS];
}

- (IBAction)repickPhotoButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)publishPhotoButtonClicked:(UIButton *)button{
    
    if (_updateLocationFinished) {
        [self publishRequestHandler];
    }else {
        [SVProgressHUD showWithStatus:@"正在获取地理位置信息"];
    }
}

#pragma mark - textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.ScrollView setContentOffset:CGPointMake(0, 110) animated:YES];
    
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }

    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger number = [textView.text length];
    if (number > 25) {
        textView.text = [textView.text substringToIndex:25];
        number = 25;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/25",(long)number];
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
    [self.ScrollView setContentOffset:CGPointMake(0, -64) animated:YES];
}

#pragma mark - publish request delegate
- (void)publishRequestHandler
{

    NSString *userId = [ATGlobal shareGlobal].user.userId;
    NSString *token = [ATGlobal shareGlobal].user.token;
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
    [SVProgressHUD showSuccessWithStatus:@"发布成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)requestFailed:(ATPublishRequest *)request error:(NSError *)error
{
    NSString *errorString = [NSString stringWithFormat:@"发布失败:%@",error];
    [SVProgressHUD showErrorWithStatus:errorString];
    NSLog(@"publishRequestFail:%@",error);

}

#pragma mark - positionManager delegate
- (void)updateLocationSuccess:(ATLocationManager *)manager
{
    _updateLocationFinished = YES;
    self.locationLabel.text = [ATLocationManager sharedInstance].location;
    
    
    
}

- (void)updateLocationFail:(ATLocationManager *)manager error:(NSError *)error
{
    _updateLocationFinished = YES;
    self.locationLabel.text = @"获取地理位置信息失败，点击重试";
}


#pragma mark other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
