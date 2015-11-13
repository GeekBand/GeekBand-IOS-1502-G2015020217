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
    self.pic_url = pictureModel.pic_link;
    self.pic_id = pictureModel.pic_id;
    self.squareVC.pic_url = self.pic_url;
    self.squareVC.pic_id = self.pic_id;
    [self.squareVC toCheckPicture];
}

@end
