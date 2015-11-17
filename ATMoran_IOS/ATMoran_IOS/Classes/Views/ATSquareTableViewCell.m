//
//  ATSquareTableViewCell.m
//  ATMoran_IOS
//
//  Created by AntsTower on 15/10/19.
//  Copyright © 2015年 Ants. All rights reserved.
//

#import "ATSquareTableViewCell.h"
#import "ATSquareCollectionViewCell.h"
#import "ATpictureModel.h"
#import "UIImageView+WebCache.h"

@implementation ATSquareTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ATSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ATSquareCollectionViewCell" forIndexPath:indexPath];
    ATpictureModel *pictureModel = self.dataArr[indexPath.row];
    NSString *pic = pictureModel.pic_link;
    pic = [pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *pic_url = [NSURL URLWithString:pic];
    [cell.commentImage sd_setImageWithURL:pic_url];
    cell.commentLabel.text = pictureModel.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ATpictureModel *pictureModel = self.dataArr[indexPath.row];
    [self.squareVC pictureSelectedWithPictureUrl:pictureModel.pic_link pictureId:pictureModel.pic_id];
}

@end
