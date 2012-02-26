//
//  HomeViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalController.h"
#import "Constant.h"

@interface HomeViewController : UIViewController<ModalDelegate>
{
    IBOutlet UITextField *txtFldLoc;
    ModalController *modal;
    NSMutableArray *arrayHome;
}
-(IBAction)clickToForSale:(id)sender;
-(IBAction)clickToToLet:(id)sender;
-(IBAction)clickToSavedSearches:(id)sender;
-(IBAction)clickToSavedProperties:(id)sender;



@end
