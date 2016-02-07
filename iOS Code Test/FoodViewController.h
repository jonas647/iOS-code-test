//
//  FoodViewController.h
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import "AbstractViewController.h"

@interface FoodViewController : AbstractViewController

@property (nonatomic) int foodCategory;
@property (strong, nonatomic) NSString *language;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
