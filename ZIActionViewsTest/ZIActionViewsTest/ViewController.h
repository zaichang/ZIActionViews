//
//  ViewController.h
//  ZIActionViewsTest
//
//  Created by Zai Chang on 4/11/12.
//  Copyright (c) 2012 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,retain) IBOutlet UIViewController *popoverContentsViewController;
@property (nonatomic,retain) IBOutlet UIButton *testPopoverButton;
@property (nonatomic,retain) IBOutlet UILabel *statusLabel;

-(IBAction) testZIAlertView:(id)sender;
-(IBAction) testZIActionSheet:(id)sender;
-(IBAction) testZIPopoverController:(id)sender;

@end
