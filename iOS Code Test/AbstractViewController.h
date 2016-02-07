//
//  AbstractViewController.h
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AbstractViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void) setupFetchRequestAndFetchResultControllerForEntity: (NSString*) entity andSortDescriptors: (NSArray*) sortDescriptors andSection: (NSString*) section;
- (void) setupManagedObjectContext;

@end
