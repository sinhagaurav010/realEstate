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
@interface SearchResultViewController : UIViewController
{
    IBOutlet UITableView *tableViewSearch;
}
@property(strong,nonatomic)NSMutableArray *arraySearch;
@end
