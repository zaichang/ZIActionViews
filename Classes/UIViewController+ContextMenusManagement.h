//
//  UIViewController+ContextMenusManagement.h
//  Maplets
//
//  Created by Zai Chang on 11/21/11.
//  Copyright (c) 2011 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ContextMenusManagement)

@property (nonatomic, retain) UIAlertView *currentAlertView;
@property (nonatomic, retain) UIActionSheet *currentActionSheet;
@property (nonatomic, retain) UIPopoverController *currentPopoverController;

-(void) dismissCurrentAlertViewAnimated:(BOOL)animated;
-(void) dismissCurrentActionSheetAnimated:(BOOL)animated;
-(void) dismissCurrentPopoverAnimated:(BOOL)animated;

-(void) dismissAllContextMenusAnimated:(BOOL)animated;

@end
