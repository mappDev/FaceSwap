//
//  GalleryItem.m
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "ImageItem.h"

@implementation ImageItem

+ (instancetype)galleryItemWithDictionary:(NSString *)dictionary
{
    ImageItem *item = [[ImageItem alloc] init];
    
    item.itemImage = dictionary;
    
    return item;
}

@end
