//
//  GalleryItemCollectionViewCell.m
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "ImageItemCollectionViewCell.h"
#import "ImageItem.h"

@implementation ImageItemCollectionViewCell

- (void)setGalleryItem:(ImageItem *)item
{
    _itemImageView.image = [UIImage imageNamed:item.itemImage];
    [_itemImageView setContentMode:UIViewContentModeScaleAspectFit];
    _itembackImageView.frame=_itemImageView.frame;
    _itembackImageView.image = [UIImage imageNamed:@"back"];
//    _itemImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
//    _itemImageView.layer.masksToBounds=YES;
}

@end
