//
//  iCodeBlogAnnotationView.m
//  Find a Park
//
//  Created by Dharmendra Singh Kushwaha on 25/02/10.
//  Copyright ChromeInfotech 2010. All rights reserved.
//  Email:dharmendras@chromeinfotech.com
//

#import "iCodeBlogAnnotationView.h"

#define kHeight 27//43 //36
#define kWidth  32//22 //30
#define kBorder 2

@implementation iCodeBlogAnnotationView
@synthesize annotation_view_tag;


- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    ////NSLog(@"annotation view");
    
    ////NSLog(@"view.annotation_view_tag = %i",annotation_view_tag);
    
    //HomeViewController *HomeController = [[HomeViewController alloc] init];
    
    MyAnnotation* myAnnotation = (MyAnnotation*)annotation;
    ////NSLog(@" myAnnotation.ann_tag------%i", myAnnotation.ann_tag);
    annotation_view_tag = myAnnotation.ann_tag;	
    
    ////NSLog(@"annotation_view_tag %i",annotation_view_tag);
    self = [super initWithAnnotation:myAnnotation reuseIdentifier:reuseIdentifier];
    
    self.frame = CGRectMake(0, 0, 20,25);
    self.backgroundColor = [UIColor clearColor];
//    
//    UIImageView  *view_details  =  [[UIImageView alloc ]init];
//    view_details.frame    = CGRectMake(0,0, 14,22);
//    view_details.backgroundColor  =  [UIColor clearColor];
//    //    if([[[ arrayWell objectAtIndex:annotation_view_tag] objectForKey:@"phase"] isEqualToString:@"G"])
//    //		view_details.image	=[UIImage imageNamed:@"pin-red.png"];
//    //    else if([[[ arrayWell objectAtIndex:annotation_view_tag] objectForKey:@"phase"] isEqualToString:@"O"])
//    //		view_details.image	=[UIImage imageNamed:@"pin-green.png"];
//    //    else if([[[ arrayWell objectAtIndex:annotation_view_tag] objectForKey:@"phase"] isEqualToString:@"D"])
//    //		view_details.image	=[UIImage imageNamed:@"pin-blue.png"];
//    //    else 
//    //		view_details.image	=[UIImage imageNamed:@"pin-black.png"];
//    
//    if([myAnnotation.stringType isEqualToString:@"Gas"])
//        view_details.image	=[UIImage imageNamed:@"pin-red.png"];
//    else if([myAnnotation.stringType isEqualToString:@"Oil"])
//        view_details.image	=[UIImage imageNamed:@"pin-green.png"];
//    else if([myAnnotation.stringType isEqualToString:@"Dry"])
//        view_details.image	=[UIImage imageNamed:@"pin-blue.png"];
//    else
//        view_details.image  = [UIImage imageNamed:@"pin-black.png"]; 
//    //UILabel  *lbl_details   =  
//    [self addSubview:view_details];
//    [view_details release];
//    
    
    return self;
}


@end
