//
//  FoodTableViewCell.h
//  iOS Code Test
//
//  Created by Jonas C Björkell on 2016-02-06.
//  Copyright © 2016 Jonas C Björkell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *background;

@end
