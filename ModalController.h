//
//  ModalController.h
//  ICMiPhoneApp
//
//  Created by Gaurav Sinha on 27/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol ModalDelegate <NSObject>
-(void)getdata;
-(void)getError;
@end

@interface ModalController : NSObject {
    
    id <ModalDelegate> delegate;

    NSMutableData *receivedData;
    NSString *stringRx;
    NSData *dataXml;

}

+(void)saveTheContent:(id)savedEle withKey:(NSString*)stringKey;
+(void)removeContentForKey:(NSString*)stringKey;
+(id)getContforKey:(NSString*)stringKey;

//+(void)sendLog:(NSString *)string;
//+(NSDate*) convertToSystemTimezone:(NSDate*)sourceDate ;
//+(UIView*)titleView;

+(double)calDistancebetWithLat:(double)latSource with:(double)longSource with:(double)latDis with:(double   )londDis;
@property(nonatomic,retain)    NSString *stringRx;
@property(nonatomic,retain)    NSData *dataXml;
@property (retain)	id <ModalDelegate> delegate;
//+(void)parsingDataLarge:(NSString*)stringDataXml extractDataForKey:(NSMutableArray*)arrayKey;
-(void)sendTheRequestWithPostString:(NSString*)string withURLString:(NSString*)URL;
+(void)showTheAlertWithMsg:(NSString*)strMsg withTitle:(NSString*)strTitle inController:(UIViewController*)controller;

@end
