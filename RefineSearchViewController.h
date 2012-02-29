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
    NSMutableArray *arrayPicker1;
    NSMutableArray *arrayPicker2;
    IBOutlet UILabel *labelTitle;
    NSMutableArray *arrayRefine;
    
}
-(IBAction)clickTosearchBarBtn:(id)sender;
-(IBAction)clickToDoneToolBarBtn:(id)sender;
-(IBAction)clickToCancelToolBarBtn:(id)sender;
-(void)searchPropertyAfterRefining;
@end
