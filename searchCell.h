//
//  searchCell.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface searchCell : UITableViewCell
{
    
}
@property(strong,nonatomic)IBOutlet UILabel *lablePrice;
@property(strong,nonatomic)IBOutlet UILabel *lablePricetype;
@property(strong,nonatomic)IBOutlet UILabel *labelBedRoom;
@property(strong,nonatomic)IBOutlet UILabel *labelDescription;
@property(nonatomic,retain)IBOutlet EGOImageView *imageMain;
@end
