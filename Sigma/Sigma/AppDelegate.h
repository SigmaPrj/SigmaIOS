//
//  AppDelegate.h
//  Sigma
//
//  Created by Terence on 16/8/1.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma -
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, assign, nonatomic) BOOL supportsCoreData;

+ (instancetype)sharedDelegate;

- (void)saveContext;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *applicationDocumentsDirectory;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *applicationCachesDirectory;

@end

