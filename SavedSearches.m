//
//  SavedSearches.m
//  PropertyApp
//
//  Created by saurav sinha on 03/03/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "SavedSearches.h"

@implementation SavedSearches
@synthesize labelSortBy,labelPrice,labelLocation,labelFor,labelBedrooms;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
