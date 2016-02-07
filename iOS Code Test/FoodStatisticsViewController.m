//
//  FoodStatisticsViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "FoodStatisticsViewController.h"
#import "FoodStatisticsTableViewCell.h"

@interface FoodStatisticsViewController ()

@end

@implementation FoodStatisticsViewController {
    NSArray *keys;
    NSArray *values;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the navigation bar title
    self.title = [self.foodStatistics valueForKey:@"title"];
    
    //Get the keys and values into two separate arrays to populate the table view
    keys = [self.foodStatistics allKeys];
    values = [self.foodStatistics allValues];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return [keys count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"foodStatisticsTableViewCell";
    FoodStatisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FoodStatisticsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Update the table view cell
    [cell.title setText:[keys objectAtIndex:indexPath.row]];
    
    //If the value isn't a string then change to string value
    if (![[values objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        [cell.volume setText:[[values objectAtIndex:indexPath.row]stringValue]];
    } else {
        [cell.volume setText:[values objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
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
