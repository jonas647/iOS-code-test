//
//  ExerciseViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ExerciseTableViewCell.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adding sort descriptors to sort by name
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    
    //Setup the fetch request and fetch results controller for the entity and with the mentioned sort descriptors
    [self setupFetchRequestAndFetchResultControllerForEntity:@"ExerciseCategory" andSortDescriptors:sortDescriptors andSection:nil];
    
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
    
    NSString *cellIdentifier = @"exerciseTableViewCell";
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[ExerciseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Fetch Record
    NSManagedObject *recordInDataModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Update the table view cell
    if ([recordInDataModel valueForKey:@"title"]) {
        [cell.title setText:[recordInDataModel valueForKey:@"title"]];
    } else {
        NSLog(@"title doesn't exist in data model");
    }
    if ([recordInDataModel valueForKey:@"calories"]) {
        //Convert the NSNumber value to string
        NSString *caloriesString = [[recordInDataModel valueForKey:@"calories"]stringValue];
        [cell.calories setText:caloriesString];
    } else {
        NSLog(@"calories doesn't exist in data model");
    }
    
    //Add rounded corners and border
    cell.background.layer.cornerRadius = 6.0f;
    cell.background.layer.borderColor = [UIColor blackColor].CGColor;
    cell.background.layer.borderWidth = 2.0f;
    
    return cell;
}


#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Table view delegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
