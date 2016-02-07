//
//  AbstractViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "AbstractViewController.h"
#import "AppDelegate.h"

@interface AbstractViewController ()

@end

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupFetchRequestAndFetchResultControllerForEntity: (NSString*) entity andSortDescriptors: (NSArray*) sortDescriptors andSection: (NSString*) section {
    
    //Set the managed object context from the app delegate property
    [self setupManagedObjectContext];
    
    //Initializing the Fetch Request to the entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entity];
    
    //Adding sort descriptors to sort the result
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    //Initialize Fetched Results Controller that will get the data from data model
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:section cacheName:nil];

    //Set view controller as the delegate to handle the response from fetched results controller
    [self.fetchedResultsController setDelegate:self];
    
    //Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void) setupManagedObjectContext {
    //Set the managed object context from the app delegate property
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
