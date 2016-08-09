//
//  AppDelegate.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/4.
//  Copyright © 2016年 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, assign, nonatomic) BOOL supportsCoreData;

+ (instancetype)sharedDelegate;

- (void)saveContext;
@property(NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *applicationDocumentsDirectory;
@property(NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *applicationCachesDirectory;

@end

