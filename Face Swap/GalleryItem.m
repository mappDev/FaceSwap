//
//  GalleryItem.m
//  UICollectionView_p1_ObjC
//
//  Created by olxios on 19/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

#import "GalleryItem.h"

@implementation GalleryItem

+ (instancetype)galleryItemWithDictionary:(NSString *)dictionary
{
    GalleryItem *item = [[GalleryItem alloc] init];
    
    item.itemImage = dictionary;
    
    return item;
}

@end
