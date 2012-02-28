//
//  cellMapView.m
//  PropertyApp
//
//  Created by saurav sinha on 26/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import "cellMapView.h"
#import "MyAnnotation.h"
#import "iCodeBlogAnnotationView.h"

@implementation cellMapView
@synthesize mpView,coordinate,stringLat,stringLong;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)createMap
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.1;
    span.longitudeDelta=0.1;
    self.mpView.delegate = self;
    CLLocationCoordinate2D location=self.mpView.userLocation.coordinate;
    
    location.latitude=[self.stringLat floatValue];
    location.longitude=[self.stringLong floatValue];
    region.span=span;
    region.center=location;
    
    MyAnnotation *addAnnotation = [[MyAnnotation alloc] init]  ;
    [addAnnotation setCoordinate:location];
    
    /*Geocoder Stuff*/
    [self.mpView setRegion:region animated:TRUE];
    [self.mpView regionThatFits:region];
    
    [self.mpView addAnnotation:addAnnotation];
}

- (MKAnnotationView*)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *string   =   @"hello";
    
	MKPinAnnotationView *annView = nil;
    
    if (annotation == mapview.userLocation) 
    {
        return nil;
    }
    
    
	annView = (MKPinAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:string];
	MyAnnotation *annot = (MyAnnotation*)annotation;
	// If we have to, create a new view
	if(annView == nil)
    {
        // //////NSLog(@"here");
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:string];
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //annView.tag = annot.ann_tag;
    }
    //MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:string];  
	
	annView.canShowCallout = YES;  
	
	//[annView setSelected:YES];  	
	
    //annView.rightCalloutAccessoryView = 
	[annView setPinColor:MKPinAnnotationColorGreen];
	
	annView.calloutOffset = CGPointMake(-5, 5);
	annView.animatesDrop=NO; 
	return annView;
    ;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
