//
//  RefineSearchViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 29/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CoreLocation.h>
#import "SearchPattren.h"
@interface RefineSearchViewController : UIViewController
{
    IBOutlet UITableView *tableViewRefine;
    IBOutlet UIPickerView *pickerViewRefine;
    IBOutlet UIToolbar *toolBarRefine;
    IBOutlet UILabel *labelTitle;
    SearchPattren *srcPtrn;
    
}
//@property(strong,nonatomic) NSMutableArray *arrayRefine;
@property(strong,nonatomic) NSMutableArray *arrayPicker1;
@property(strong,nonatomic) NSMutableArray *arrayPicker2;

@property(strong,nonatomic)NSString *strPickerSec1;
@property(strong,nonatomic)NSString *strPickerSec2;
-(IBAction)clickTosearchBarBtn:(id)sender;
-(IBAction)clickToDoneToolBarBtn:(id)sender;
-(IBAction)clickToCancelToolBarBtn:(id)sender;
-(void)searchPropertyAfterRefining;
-(IBAction)clickToCancelNavBtn:(id)sender;

-(double)kilometresBetweenPlace1:(CLLocationCoordinate2D) place1 andPlace2:(CLLocationCoordinate2D) place2 ;
@end
