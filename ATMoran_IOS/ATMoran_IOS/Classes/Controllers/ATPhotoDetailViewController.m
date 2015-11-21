//
//  ATPhotoDetailViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATPhotoDetailViewController.h"
#import "ATGlobal.h"
#import "SVProgressHUD.h"
#import "ATPhotoDetailRequest.h"
@interface ATPhotoDetailViewController () <ATPhotoDetailRequestDelegate>

@end

@implementation ATPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PhotoImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.pic_url]]];
    
    [SVProgressHUD show];
    [self viewDetailRequestHandler];
    
}

- (void)viewDetailRequestHandler
{
    NSString *token= [ATGlobal shareGloabl].user.token;
    NSString *userId= [ATGlobal shareGloabl].user.userId;
    
    NSDictionary *dic=@{@"pic_id":_pic_id,
                        @"token":token,
                        @"user_id":userId};
    
    ATPhotoDetailRequest *request= [[ATPhotoDetailRequest alloc]init];
    [request sendViewDetailRequestWithParameter:dic delegate:self];
}

#pragma mark - photoDetailRequestDelegate
-(void)ATPhotoDetailRequestSuccess:(ATPhotoDetailRequest *)request data:(ATPhotoDetailModel *)model{
    
    //set data
    
    self.TimeLabel.text = model.modified;
    [SVProgressHUD dismiss];
}
- (void)ATPhotoDetailRequestFailed:(ATPhotoDetailRequest *)request error:(NSError *)error
{
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
