//
//  MyAnnotation.h
//  swiftGO
//
//  Created by gauravsinha on 23/01/10.
//  Copyright ChromeInfotech 2010. All rights reserved.
//  mail:gaurav@bosscomputec.com
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
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,assign)	NSInteger ann_tag;
@property (nonatomic,assign)	NSUInteger annotations;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,assign) NSString *userData;
@property (nonatomic,assign)  UIView  *annotation_view;

@property (nonatomic,assign)         NSString *stringType;




@end
