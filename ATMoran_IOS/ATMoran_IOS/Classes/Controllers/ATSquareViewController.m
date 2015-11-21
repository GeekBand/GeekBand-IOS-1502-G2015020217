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
#import "ATSquareModel.h"
#import "ATSquareTableViewCell.h"
#import "ATPhotoDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ATLocationManager.h"
#import "SVProgressHUD.h"

@interface ATSquareViewController () <UITableViewDataSource,UITableViewDelegate,ATSquareRequestDelegate,ATLocationManagerDelegate>
{
    BOOL      _updateLocationFinished;
    NSArray   *_menuItems;
}

@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *addrArray;
@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation ATSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _updateLocationFinished = NO;
    [ATLocationManager sharedInstance].delegate = self;
    [[ATLocationManager sharedInstance] updateLBS];
    [SVProgressHUD showWithStatus:@"正在获取地理信息" maskType:SVProgressHUDMaskTypeClear];
    
    [self loadTitleButtonView];
    [self loadRefreshView];

}

- (void)loadTitleButtonView
{
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.titleButton.titleLabel setFont:[UIFont systemFontOfSize:19]];
    self.titleButton.frame = CGRectMake(0, 0, 150, 35);
    [self.titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleButton setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    self.navigationItem.titleView = self.titleButton;
    
    _menuItems =@[
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
}

- (void)loadRefreshView
{
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

#pragma mark - locationManagerDelegate
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

#pragma mark - detailView
- (void)pictureSelectedWithPictureUrl:(NSString *)pic_url pictureId:(NSString *)pic_id
{
    ATPhotoDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ATPhotoDetailViewController"];
    [detailVC.PhotoImage sd_setImageWithURL:[NSURL URLWithString:pic_url]];
    detailVC.pic_id = pic_id;
    detailVC.pic_url = pic_url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - titleButtonClicked
- (void)titleButtonClick:(UIButton *)button
{
    CGRect rect = [button.superview convertRect:button.frame toView:[[UIApplication sharedApplication] keyWindow]];
    [KxMenu showMenuInView:[[UIApplication sharedApplication] keyWindow]
                  fromRect:rect
                 menuItems:_menuItems];
}

- (void)request500metersData
{
    [self.titleButton setTitle:@"附近500米" forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 125, 0, 0);
    NSString *distance = @"500";
    [self squareRequestHandlerWithinDistance:distance];
    
}
- (void)request1000metersData
{
    [self.titleButton setTitle:@"附近1000米" forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 125, 0, 0);
    NSString *distance = @"1000";
    [self squareRequestHandlerWithinDistance:distance];
    
}
- (void)request1500metersData
{
    [self.titleButton setTitle:@"附近1500米" forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 125, 0, 0);
    NSString *distance = @"1500";
    [self squareRequestHandlerWithinDistance:distance];
    
}

- (void)requestAllData
{
    [self.titleButton setTitle:@"全部" forState:UIControlStateNormal];
    self.titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
    NSString *distance = @"5000";
    [self squareRequestHandlerWithinDistance:distance];

}

#pragma mark - squareRequestDelegate
- (void)squareRequestHandlerWithinDistance:(NSString *)distance
{
    NSDictionary *paramDic = @{@"user_id":[ATGlobal shareGloabl].user.userId,
                               @"token":[ATGlobal shareGloabl].user.token,
                               @"longitude":@"121.47794",
                               @"latitude":@"31.22516",
                               @"distance":distance};
    
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


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addrArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
