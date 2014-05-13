//
//  CoreDataBasicClass.h
//  CoreDataSample
//
//  Created by bala on 5/8/14.
//  Copyright (c) 2014 bala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataBasicClass : NSObject

@property(strong) NSString              *XCModalName;
@property(strong) NSString              *SQLiteName;


- (NSManagedObjectContext *)managedObjectContext;

@end
