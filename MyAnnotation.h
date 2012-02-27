//
//  MyAnnotation.h
//  swiftGO
//
//  Created by  on 23/01/10.
//  Copyright ChromeInfotech 2010. All rights reserved.
//  
//


#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


 @interface MyAnnotation : NSObject <MKAnnotation> 
	{
		CLLocationCoordinate2D coordinate;
		NSInteger  ann_tag;
		NSUInteger annotations;
		NSString   *title;
		NSString   *subtitle;
	    UIView     *annotation_view;
 		NSString   * userData;
        UIButton   *details_button;
        NSString *stringType;

	}
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic,readwrite)	NSInteger ann_tag;
@property (nonatomic,readwrite)	NSUInteger annotations;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,strong) NSString *userData;
@property (nonatomic,strong)  UIView  *annotation_view;

@property (nonatomic,strong)         NSString *stringType;




@end
