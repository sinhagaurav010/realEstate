//
//  cellAgent.h
//  PropertyApp
//
//  Created by saurav sinha on 27/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface cellAgent : UITableViewCell
{
    
}
@property(nonatomic,retain)IBOutlet EGOImageView *imageMain;
@property(strong,nonatomic)IBOutlet UILabel *labelAgentDescp;
@property(strong,nonatomic)IBOutlet UILabel *labeltelephone;
@end
