//
//  searchCell.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "searchCell.h"

@implementation searchCell
@synthesize labelBedRoom,labelDescription,lablePricetype,lablePrice,imageMain;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // Initialization code
    }
    return self;
}

-(void)addImage:(NSString *)stringurl
{
    self.imageMain.placeholderImage = [UIImage  imageNamed:@"place_holder_small.jpg"];
    NSURL *imageUrl=[NSURL URLWithString:stringurl];
    self.imageMain.imageURL=imageUrl;
}
-(void)addLabel:(NSString *)stringprice withType:(NSString *)priceType withBedRoom:(NSString *)stringBedrooom withDesc:(NSString *)desc
{
    self.labelDescription.text = desc;
    self.lablePrice.text = stringprice;
    self.lablePricetype.text = priceType;
    self.labelBedRoom.text = stringBedrooom;
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
