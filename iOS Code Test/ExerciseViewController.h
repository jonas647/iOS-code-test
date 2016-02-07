//
//  ExerciseViewController.h
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AbstractViewController.h"

@interface ExerciseViewController : AbstractViewController <NSFetchedResultsControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
