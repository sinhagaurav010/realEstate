//
//  RefineSearchViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 29/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RefineSearchViewController : UIViewController
{
    IBOutlet UITableView *tableViewRefine;
    IBOutlet UIPickerView *pickerViewRefine;
    IBOutlet UIToolbar *toolBarRefine;
    IBOutlet UILabel *labelTitle;
   
    
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
@end
