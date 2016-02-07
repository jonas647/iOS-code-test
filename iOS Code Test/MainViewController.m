//
//  MainViewController.m
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

//Macro for converting null values to nil
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#import "mainViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    
    NSString *filePathForDatabase;
    NSManagedObjectContext *managedObjectContext;
    AppDelegate *appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Get the managed object context from appdelegate
    appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    //Check if the data has been loaded, if not then insert the json data into the data model
    if (![appDelegate tableExistForEntity:@"FoodCategory"]) {
        [self loadInitialFoodCategoryData];
        
    }
    if (![appDelegate tableExistForEntity:@"FoodStatistics"]) {
        [self loadInitialFoodStatisticsData];
    }
    if (![appDelegate tableExistForEntity:@"ExerciseCategory"]) {
        [self loadInitialExerciseCategoryData];
    }
    
}

- (void) viewDidLayoutSubviews {
    
    //Make the buttons as circles
    self.exerciseButton.layer.cornerRadius = self.exerciseButton.frame.size.width/2;
    self.exerciseButton.layer.masksToBounds = YES;
    
    self.foodButton.layer.cornerRadius = self.foodButton.frame.size.width/2;
    self.foodButton.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Hide the navigation bar in this view controller
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //Show the navigation bar in the other view controllers
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - First time load

- (void) loadInitialFoodCategoryData {
    
    //Load the json files into NSDictionary
    NSArray *foodCategories = [self arrayFromLocalJsonFile:@"categoriesStatic"];
    
    //Create objects in the data model from the Json array
    [self setupDataModelEntity:@"FoodCategory" fromJsonObjects:foodCategories];
    
}

- (void) loadInitialExerciseCategoryData {
    
    //Load the json files into NSDictionary
    NSArray *exerciseCategories = [self arrayFromLocalJsonFile:@"exercisesStatic"];
    
    //Create objects in the data model from the Json array
    [self setupDataModelEntity:@"ExerciseCategory" fromJsonObjects:exerciseCategories];
    
}

- (void) loadInitialFoodStatisticsData {
    
    //Load the json files into NSDictionary
    NSArray *foodStatistics = [self arrayFromLocalJsonFile:@"foodStatic"];
    
    //Create objects in the data model from the Json array
    [self setupDataModelEntity:@"FoodStatistics" fromJsonObjects:foodStatistics];
    
}

- (NSArray*) arrayFromLocalJsonFile: (NSString*) fileName {
    
    //Get the file path to the local json file
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSError* error = nil;
    
    //Create array that holds all the nsdictionaries
    NSArray *newArray = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions error:&error];
    return newArray;
}

- (void) setupDataModelEntity: (NSString*) entityName fromJsonObjects: (NSArray*) jsonObjects {
    
    //Create objects in the data model by going through all the dictionaries in the Json file
    [jsonObjects enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop) {
        
        // Create New Managed Object
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
        NSManagedObject *newObject = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedObjectContext];
        
        //Set all the keys for the food category by enumerating the dictionary in the array
        if ([x isKindOfClass:[NSDictionary class]]) {
            
            //Create a temp dictionary that has information from the json file
            NSDictionary *dictionaryFromJson = (NSDictionary*)x;
            
            //Create new object from all the keys in the dictionary from json file
            [dictionaryFromJson enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
                
                //If the key doesn't exist on the property then throw error message
                if ([[newObject.entity propertiesByName]objectForKey:key] != nil) {
                   
                    [newObject setValue:NULL_TO_NIL(object) forKey:key];
                    
                } else {
                    NSLog(@"%@ doesn't exist. Make sure that all the keys in the json file is reflected in the data model.", key);
                }
                
            }];
        }
        
    }];
    
    //Save to data model
    [appDelegate saveContext];
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
