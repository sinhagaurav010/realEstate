//
//  cellMapView.h
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface cellMapView : UITableViewCell<MKMapViewDelegate>
{
    
    
}
-(void)createMap;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(retain)NSString *stringLat;
@property(retain)NSString *stringLong;

@property(retain,nonatomic)IBOutlet MKMapView *mpView;
@end
