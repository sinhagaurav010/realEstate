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
-(void)addLabel:(NSString *)stringprice withType:(NSString *)priceType withBedRoom:(NSString *)stringBedrooom withDesc:(NSString *)desc;

-(void)addImage:(NSString *)stringurl;
@property(strong,nonatomic)IBOutlet UILabel *lablePrice;
@property(strong,nonatomic)IBOutlet UILabel *lablePricetype;
@property(strong,nonatomic)IBOutlet UILabel *labelBedRoom;
@property(strong,nonatomic)IBOutlet UILabel *labelDescription;
@property(strong,nonatomic)IBOutlet UILabel *labelDistance;
@property(nonatomic,retain)IBOutlet EGOImageView *imageMain;
@end
