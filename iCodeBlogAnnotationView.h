//
//  iCodeBlogAnnotationView.h
//  Find a Park
//
//  Created by Gaurav Sinha on 25/02/10.
//  Copyright BossComputec.com 2010. All rights reserved.
//  Email:gauravs@bosscomputec.com
//


/**
 @ Description : This class is used to provide the functionality to add custom annotation on map view.
  */
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "HomeViewController.h"
#import "Constant.h"

@interface iCodeBlogAnnotationView : MKAnnotationView 
{
	NSInteger annotation_view_tag;
}

@property(nonatomic,assign) NSInteger annotation_view_tag;



@end
