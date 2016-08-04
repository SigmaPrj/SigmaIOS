//
//  AppDelegate.m
//  Sigma
//
//

#import "AppDelegate.h"
#import "SAUserDataManager.h"
#import "SARootViewController.h"
#import "CacheManager.h"
#import "SAAnimationNavController.h"
#import "SAHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    /**
     * 判断用户是否已经登录
     */
    NSMutableDictionary* userData = (NSMutableDictionary *)[SAUserDataManager readUserData];

    // 验证有效性
    if (userData) {
        if (userData[@"token"] && userData[@"time"]) {
            NSTimeInterval timeInterval = [userData[@"time"] intValue];
            NSTimeInterval nowInterval = [NSDate date].timeIntervalSince1970;
            if (timeInterval > nowInterval) {
                // 直接进入主页面
                SARootViewController *rootController = [[SARootViewController alloc] init];
                self.window.rootViewController = rootController;
                [self.window makeKeyAndVisible];
                return YES;
            }
        }
    }

    // 显示home页面,选择注册和登录
    SAHomeViewController *homeViewController = [[SAHomeViewController alloc] init];
    SAAnimationNavController *navController = [[SAAnimationNavController alloc] initWithRootViewController:homeViewController];

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

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

