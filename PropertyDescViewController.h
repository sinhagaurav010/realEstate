//
//  PropertyDescViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyDescViewController : UIViewController
{
  IBOutlet  UITableView *tableViewDesc;
}


-(IBAction)callAgent:(id)sender;

-(IBAction)EmailAgent:(id)sender;
@property(retain)NSMutableDictionary *dictResult;
@end
