//
//  ViewController.m
//  CoreDataSample
//
//  Created by bala on 5/8/14.
//  Copyright (c) 2014 bala. All rights reserved.
//

#import "ViewController.h"
#import "Settings.h"
#import "CoreDataBasicClass.h"

@interface ViewController ()

@end

@implementation ViewController

NSManagedObjectContext *context;
Settings *settingsInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CoreDataBasicClass *sample = [[CoreDataBasicClass alloc] init];
    
    [sample setXCModalName:@"Settings"];
    [sample setSQLiteName:@"Setting"];
    
    context = [sample managedObjectContext];
    
    settingsInfo = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Settings"
                              inManagedObjectContext:context];
    
    if(context != NULL){
        
        [self saveValue];
        [self readValue];
        
         NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }

    }

}

- (void) saveValue{
     NSError *error;
    
    [settingsInfo setValue:[NSNumber numberWithInt:10] forKey:@"volume"];
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (void) updateValue{
     NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *SettingsObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Settings *info in SettingsObjects) {
        NSLog(@"Name: %@", info.volume);
        info.volume = [NSNumber numberWithInt:40];       
        
    }
}

- (void) deleteValue{
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *SettingsObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Settings *info in SettingsObjects) {
        [context deleteObject:info];
        
    }
}

- (void) readValue{
    NSError *error;
    int volume = 0;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"volume == %d", volume];
    [fetchRequest setPredicate:predicate];
    
    NSArray *SettingsObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Settings *info in SettingsObjects) {
        NSLog(@"Name: %@", info.volume);        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
