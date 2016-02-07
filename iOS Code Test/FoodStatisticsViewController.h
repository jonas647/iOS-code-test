//
//  FoodStatisticsViewController.h
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "AbstractViewController.h"

@interface FoodStatisticsViewController : AbstractViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *foodStatistics;

@end
