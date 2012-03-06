//
//  SavePropertyViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 06/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchCell.h"
#import "Constant.h"
#import "DetailViewController.h"
@interface SavePropertyViewController : UIViewController
{
    IBOutlet UITableView *tableViewSaveProp;
}
@property(strong,nonatomic)NSMutableArray *arraySaveProResult;
-(IBAction)clickToEditBarBtn:(id)sender;
@end
