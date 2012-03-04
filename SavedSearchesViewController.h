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
#import "SearchPattren.h"
#import "SearchResultViewController.h"
#import "ModalController.h"
@interface SavedSearchesViewController : UIViewController
{
    IBOutlet UITableView *tableViewSavedSearches;
   
   
}
@property(strong,nonatomic) NSMutableArray *arraySavedSearchesResult;
@property(strong,nonatomic)  SearchPattren *searchPattern;
-(IBAction)clickToEditBarBtn:(id)sender;
@end
