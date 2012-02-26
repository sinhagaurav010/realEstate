//
//  cellDescpImg.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface cellDescpImg : UITableViewCell
{
    
}
@property(strong,nonatomic)IBOutlet UILabel *labelAddress;
@property(nonatomic,retain)IBOutlet EGOImageView *imageMain;
@end
