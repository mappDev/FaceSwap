//
//  AppDelegate.h
//  Face Swap
//
//  Created by capitan on 7/31/16.
//  Copyright © 2016 greenmango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#define APP_DELEGATE    ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UIImage *saveImage;
@property (nonatomic) NSInteger *gallerynumber;
@property (nonatomic) NSInteger *imagenumber;
@property (nonatomic, retain) NSString *imageName;
@property (strong, nonatomic) NSString *fullScreenBannerShow;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

