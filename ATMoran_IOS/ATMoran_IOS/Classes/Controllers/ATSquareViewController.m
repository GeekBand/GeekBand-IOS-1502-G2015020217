//
//  ATSquareViewController.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/14.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareViewController.h"
#import "KxMenu.h"
#import "MJRefresh.h"
#import "ATGlobal.h"

#import "ATSquareRequest.h"
#import "ATUserModel.h"
#import "ATSquareModel.h"
#import "ATSquareTableViewCell.h"

#import "ATPhotoDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ATLocationManager.h"
#import "SVProgressHUD.h"

@interface ATSquareViewController () <UITableViewDataSource,UITableViewDelegate,ATSquareRequestDelegate,ATLocationManagerDelegate>
{
    BOOL updateLocationFinished;
}
@property (nonatomic, strong) NSArray *scrollArray;
@property (nonatomic ,strong) NSMutableDictionary * userLocationDict;

@property (strong, nonatomic) NSMutableArray *data; // Temp Refresh

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) NSMutableArray *pictureArray;

@end

@implementation ATSquareViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    updateLocationFinished = NO;
    [ATLocationManager sharedInstance].delegate = self;
    [[ATLocationManager sharedInstance] updateLBS];
    [SVProgressHUD showWithStatus:@"正在获取地理信息" maskType:SVProgressHUDMaskTypeClear];
    
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.frame = CGRectMake(0, 0, 200, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 133, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    self.navigationItem.titleView = self.titleButton;
    
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([self.titleButton.titleLabel.text isEqualToString:@"全部"]) {
            [self requestAllData];
            
        }else if ([self.titleButton.titleLabel.text isEqualToString:@"附近500米"]) {
            [self request500metersData];
            
        }else if ([self.titleButton.titleLabel.text isEqualToString:@"附近1000米"]) {
            [self request1000metersData];
            
        }else if ([self.titleButton.titleLabel.text isEqualToString:@"附近1500米"]) {
            [self request1500metersData];
        }

    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.footer endRefreshing];

    }];
    
}

- (void)updateLocationSuccess:(ATLocationManager *)manager
{
    
    [SVProgressHUD dismiss];
    [self requestAllData];
}

- (void)updateLocationFail:(ATLocationManager *)manager error:(NSError *)error
{
    [self requestAllData];
    [SVProgressHUD showErrorWithStatus:@"获取地理信息失败"];
}

- (void)toCheckPicture
{
    ATPhotoDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ATPhotoDetailViewController"];
    [detailVC.PhotoImage sd_setImageWithURL:[NSURL URLWithString:_pic_url]];
    detailVC.pic_id=_pic_id;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (void)titleButtonClick:(UIButton *)button
{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"显示全部"
                     image:nil
                    target:self
                    action:@selector(requestAllData)],
      
      [KxMenuItem menuItem:@"附近500米"
                     image:nil
                    target:self
                    action:@selector(request500metersData)],
      [KxMenuItem menuItem:@"附近1000米"
                     image:nil
                    target:self
                    action:@selector(request1000metersData)],
      [KxMenuItem menuItem:@"附近1500米"
                     image:nil
                    target:self
                    action:@selector(request1500metersData)],
      
      ];
    
    
    UIButton *btn = (UIButton *)button;
    CGRect editImageFrame = btn.frame;
    
    UIView *targetSuperview = btn.superview;
    CGRect rect = [targetSuperview convertRect:editImageFrame toView:[[UIApplication sharedApplication] keyWindow]];
    
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow]
                  fromRect:rect
                 menuItems:menuItems];
    
}

- (void)request500metersData
{
    [self.titleButton setTitle:@"附近500米" forState:UIControlStateNormal];
    
    NSDictionary *paramDic = @{@"user_id":[ATGlobal shareGloabl].user.userId,
                               @"token":[ATGlobal shareGloabl].user.token,
                               @"longitude":[ATLocationManager sharedInstance].longitude,
                               @"latitude":[ATLocationManager sharedInstance].latitude,
                               @"distance":@"500"};
    
    ATSquareRequest *squareRequest = [[ATSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    
}
- (void)request1000metersData
{
    [self.titleButton setTitle:@"附近1000米" forState:UIControlStateNormal];
    
    NSDictionary *paramDic = @{@"user_id":[ATGlobal shareGloabl].user.userId,
                               @"token":[ATGlobal shareGloabl].user.token,
                               @"longitude":[ATLocationManager sharedInstance].longitude,
                               @"latitude":[ATLocationManager sharedInstance].latitude,
                               @"distance":@"1000"};
    
    ATSquareRequest *squareRequest = [[ATSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    
}
- (void)request1500metersData
{
    [self.titleButton setTitle:@"附近1500米" forState:UIControlStateNormal];
    
    NSDictionary *paramDic = @{@"user_id":[ATGlobal shareGloabl].user.userId,
                               @"token":[ATGlobal shareGloabl].user.token,
                               @"longitude":[ATLocationManager sharedInstance].longitude,
                               @"latitude":[ATLocationManager sharedInstance].latitude,
                               @"distance":@"1500"};
    
    ATSquareRequest *squareRequest = [[ATSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
}

- (void)requestAllData
{
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    
    NSDictionary *paramDic = @{@"user_id":[ATGlobal shareGloabl].user.userId,
                               @"token":[ATGlobal shareGloabl].user.token,
                               @"longitude":@"121.47794",
                               @"latitude":@"31.22516",
                               @"distance":@"5000"};
    
    ATSquareRequest *squareRequest = [[ATSquareRequest alloc] init];
    [squareRequest sendSquareRequestWithParameter:paramDic delegate:self];
    
}

- (void)squareRequestSuccess:(ATSquareRequest *)request dictionary:(NSDictionary *)dictionary
{
    self.addrArray = [NSMutableArray arrayWithArray:[dictionary allKeys]];
    self.dataDic = dictionary;

    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    
}

- (void)squareRequestFailed:(ATSquareRequest *)request error:(NSError *)error
{
    [self.tableView.header endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    NSLog(@"addrArray: %zd", self.addrArray.count);
    return self.addrArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *str = @"ATSquareTableViewCell";
    
    ATSquareTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ATSquareTableViewCell"];
    if (!cell) {
        cell = [[ATSquareTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATSquareTableViewCell"];
    }
    
    ATSquareModel *squareModel = self.addrArray[indexPath.row][0];
    cell.squareVC = self;
    
    cell.addressLabel.text = squareModel.addr;
    cell.dataArr = self.dataDic[self.addrArray[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.commentCollectionView reloadData];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
