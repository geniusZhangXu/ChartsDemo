//
//  AppDelegate.h
//  ChartsDemo
//
//  Created by SKOTC on 17/6/26.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

