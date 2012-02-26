//
//  PropertyDescViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import <MessageUI/MessageUI.h>
#import "ModalController.h"
#import "MyAnnotation.h"
#import "iCodeBlogAnnotationView.h"
@interface PropertyDescViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
  IBOutlet  UITableView *tableViewDesc;
    IBOutlet UIToolbar *toolbar;
    NSMutableArray *arraySavedProperty;
    NSInteger savedAtIndex;
}


-(IBAction)callAgent:(id)sender;

-(IBAction)EmailAgent:(id)sender;
@property(retain)NSString *stringRightTitle;
@property(retain)NSMutableDictionary *dictResult;
@end
