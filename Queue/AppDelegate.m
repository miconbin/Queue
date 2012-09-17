//
//  AppDelegate.m
//  Queue
//
//  Created by biLLy on 9/8/12.
//  Copyright (c) 2012 biLLy. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self configureModels];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    [self.library syncWithMusicLibrary];
    self.viewController.library = self.library;
    
    Player *player = [[Player alloc] initWithMPController: [MPMusicPlayerController iPodMusicPlayer]];
    self.player = player;
    
    if([self.window respondsToSelector:@selector(rootViewController)]) {
        self.window.rootViewController = self.viewController;
    } else {// iOS 3.X
        CGRect oldFrame = self.viewController.view.frame;
        
        oldFrame.origin.y += 20; // status bar
        
        self.viewController.view.frame = oldFrame;
        
        [self.window addSubview :self.viewController.view]; 
        
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) configureModels {    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MusicLibrary" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:path];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    
    Library *library = [Library alloc];
    
    NSString *libraryStorePath = [basePath stringByAppendingPathComponent: @"QueueLibrary.sqlite"];
    
    NSURL *libraryStoreUrl = [NSURL fileURLWithPath:libraryStorePath];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:libraryStoreUrl options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    

    // Object context
    library.managedObjectContext = [[NSManagedObjectContext alloc] init];
    [library.managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    
    self.library = library;    
}

@end
