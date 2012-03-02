//
//  SavedSearchesViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "constant.h"
@interface SavedSearchesViewController : UIViewController
{
    IBOutlet UITableView *tableViewSavedSearches;
    NSMutableArray *arraySavedSearchesResult;
}
-(IBAction)clickToEditBarBtn:(id)sender;
@end
