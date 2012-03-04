//
//  SavedSearches.h
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedSearches : UITableViewCell
{
    
}
@property(strong,nonatomic)IBOutlet UILabel *labelFor;
@property(strong,nonatomic)IBOutlet UILabel *labelLocation;
@property(strong,nonatomic)IBOutlet UILabel *labelPrice;
@property(strong,nonatomic)IBOutlet UILabel *labelBedrooms;
@property(strong,nonatomic)IBOutlet UILabel *labelSortBy;
@property(strong,nonatomic)IBOutlet UILabel *labelRadius;
@property(strong,nonatomic)IBOutlet UILabel *radiusTitle;
@end
