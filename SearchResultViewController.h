//
//  SearchResultViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyDescViewController.h"
#import "Constant.h"
#import "RefineSearchViewController.h"
#import "ModalController.h"
#import "SavedSearchesViewController.h"
#import "SearchPattren.h"
#import "HomeViewController.h"
@class SavedSearchesViewController;
@interface SearchResultViewController : UIViewController
{
    IBOutlet UITableView *tableViewSearch;
    IBOutlet UILabel *labelPrice;
    IBOutlet UILabel *labelBedrooms;
    IBOutlet UIButton *btnHeader;
    IBOutlet UIView *ViewHeader;
    RefineSearchViewController *refine;
   
    NSMutableDictionary *dictSaved;
     SavedSearchesViewController *ssvc;
    SearchPattren *srcPtrn;
    HomeViewController *home;
    
}
-(IBAction)clickToHeaderBtn:(id)sender;
-(IBAction)clickToSaveNavBarBtn:(id)sender;
-(IBAction)clickToBackBarBtn:(id)sender;
@property(strong,nonatomic)NSMutableArray *arraySearchResult;


@end
