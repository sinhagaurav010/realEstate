//
//  MyAnnotation.m
//  swiftGO
//
//  Created by Dharmendra Singh Kushwaha on 23/01/10.
//  Copyright ChromeInfotech 2010. All rights reserved.
//  mail:gauravs@chromeinfotech.com
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate,ann_tag,title,subtitle,userData,annotation_view,annotations,stringType;

-init
{
	return self;
}
-initWithCoordinate:(CLLocationCoordinate2D)inCoord
{
	coordinate = inCoord;
	return self;
}
/*
-initWithCoordinate:(CLLocationCoordinate2D)inCoord :(NSInteger)pinId
///-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate1 andID:(NSUInteger)pinID
{
	inCoord = coordinate;
	//annotations   =  pinID;
	////NSLog(@"coordinate6578667877790880-%f",coordinate1.latitude);
	return self;
	
	self = [super init];
	
	if (self != nil) {
		
		coordinate = coordinate1;
		
		self.ann_tag = pinID;
		
	}
	
	return self;*/
//}
/*
-(NSString *) title {
	////NSLog(@"coordinate0---------------------%f",self.coordinate.latitude);
   // for(int i=0;i<[])
	return @"ddsfdsf";
}
-(NSString *) subtitle{
	return @"sdfsdvdsgf";
}
*/
//-(void)dealloc 
//{
//	[title release];
//	[subtitle release];
//	[userData release];
//	
//	[super dealloc];
//}

@end
