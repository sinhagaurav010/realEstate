//
//  BroucherViewController.h
//  PropertyApp
//
//  Created by saurav sinha on 28/02/12.
//  Copyright (c) 2012 sauravsinha007@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BroucherViewController : UIViewController
{
    IBOutlet UINavigationBar *navBarBroucher;
    //IBOutlet UIWebView *webViewBroucher;
    IBOutlet UIActivityIndicatorView *act;
}
@property(nonatomic,strong)NSString *strUrlBroucher;
@property(nonatomic,assign)IBOutlet UIWebView *webViewBroucher;
-(IBAction)clickToDone:(id)sender;
@end
