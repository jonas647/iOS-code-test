//
//  FoodCategoryViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "FoodCategoryViewController.h"
#import "FoodCategoryTableViewCell.h"
#import "FoodViewController.h"

@interface FoodCategoryViewController ()

@end

@implementation FoodCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Adding sort descriptors to sort by category
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES]];
    
    //Setup the fetch request and fetch results controller for the entity and with the mentioned sort descriptors
    [self setupFetchRequestAndFetchResultControllerForEntity:@"FoodCategory" andSortDescriptors:sortDescriptors andSection:@"headcategoryid"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Remove the selection of the previously selected table cell. Make the deselection here to show the user the previously selected cell with a short "flash".
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    
    NSString *cellIdentifier = @"foodCategoryTableViewCell";
    FoodCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FoodCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Fetch Record
    NSManagedObject *recordInDataModel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Update the table view cell
    if ([recordInDataModel valueForKey:@"category"]) {
        [cell.title setText:[recordInDataModel valueForKey:@"category"]];
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
    if ([[segue identifier] isEqualToString:@"showFoodForCategory"])
    {
        // Get reference to the destination view controller
        FoodViewController *destinationVc = [segue destinationViewController];
        
        //Get the object that is being sent to the detailed view controller
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSManagedObject *sendingObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        int categoryID = [[sendingObject valueForKey:@"oid"]intValue];
        
        [destinationVc setFoodCategory:categoryID];
        [destinationVc setLanguage:@"en_US"];
        
    }
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
