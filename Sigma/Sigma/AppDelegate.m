//
//  AppDelegate.m
//  Sigma
//
//  Created by Terence on 16/8/1.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "AppDelegate.h"
#import "SARootViewController.h"

#import "CacheManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] init];
    
    self.window.frame = [[UIScreen mainScreen] bounds];
    
    SARootViewController *viewController = [[SARootViewController alloc]init];
    
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    
    [self initializeManagedObjectContext];

    return YES;
}

+ (instancetype)sharedDelegate {
    return [UIApplication sharedApplication].delegate;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[CacheManager defaultManager] clearMemoryCaches];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize supportsCoreData = _supportsCoreData;

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Sigma" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Sigma.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        _supportsCoreData = NO;
    } else {
        _supportsCoreData = YES;
    }
    
    return _persistentStoreCoordinator;
}

- (void)initializeManagedObjectContext {
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (!coordinator) {
        return;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = coordinator;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if (managedObjectContext.hasChanges && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            _supportsCoreData = NO;
        }
    }
}

#pragma mark - Utility

- (NSURL *)applicationDocumentsDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
}

- (NSURL *)applicationCachesDirectory {
    return [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask].lastObject;
}

@end

