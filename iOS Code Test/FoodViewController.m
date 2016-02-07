//
//  FoodViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "FoodViewController.h"
#import "FoodStatisticsViewController.h"
#import "FoodTableViewCell.h"

@interface FoodViewController ()

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the managed object context from appdelegate
    [self setupManagedObjectContext];
    
    //Initializing the Fetch Request to the entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"FoodStatistics"];
    
    //Set the sorting descriptors for the fetch request
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"categoryid" ascending:YES]]];
    
    // Create Predicate to get the correct food statistics data
    NSPredicate *categoryPredicate = [NSPredicate predicateWithFormat:@"ocategoryid = %i", self.foodCategory];
    NSPredicate *languagePredicate = [NSPredicate predicateWithFormat:@"language = %@", self.language];
    
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[categoryPredicate, languagePredicate]];
    
    [fetchRequest setPredicate:compoundPredicate];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"foodTableViewCell";
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Fetch Record
    NSManagedObject *recordInDataModel = [self.fetchedResultsController objectAtIndexPath:indexPath];

    //Update the table view cell
    if ([recordInDataModel valueForKey:@"title"]) {
        [cell.title setText:[recordInDataModel valueForKey:@"title"]];
    } else {
        NSLog(@"category doesn't exist in data model");
    }
    
    //Add rounded corners and border
    cell.background.layer.cornerRadius = 6.0f;
    cell.background.layer.borderColor = [UIColor blackColor].CGColor;
    cell.background.layer.borderWidth = 2.0f;
    
    
    return cell;
}

#pragma mark - Storyboard segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showFoodDetails"])
    {
        // Get reference to the destination view controller
        FoodStatisticsViewController *destinationVc = [segue destinationViewController];
        
        //Get the object that is being sent to the detailed view controller
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSManagedObject *sendingObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NSLog(@"Sending object: %@", sendingObject);
        
        //Convert the selected object to a NSDictionary
        NSArray *keys = [[[sendingObject entity] attributesByName] allKeys];
        NSDictionary *dict = [sendingObject dictionaryWithValuesForKeys:keys];
        
        NSLog(@"Dict: %@", dict);
        
        [destinationVc setFoodStatistics:dict];
        
    }
}

@end
