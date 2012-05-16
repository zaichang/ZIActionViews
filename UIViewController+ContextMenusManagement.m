//
//  UIViewController+ContextMenusManagement.m
//  Maplets
//
//  Created by Zai Chang on 11/21/11.
//  Copyright (c) 2011 Zaia Design. All rights reserved.
//

#import "UIViewController+ContextMenusManagement.h"
#import <objc/runtime.h>


static NSString *kUIViewControllerCurrentAlertView = @"UIViewControllerCurrentAlertView";
static NSString *kUIViewControllerCurrentActionSheet = @"UIViewControllerCurrentActionSheet";
static NSString *kUIViewControllerCurrentPopover = @"UIViewControllerCurrentPopover";

@implementation UIViewController (ContextMenusManagement)

-(UIAlertView*) currentAlertView
{
	return objc_getAssociatedObject(self, kUIViewControllerCurrentAlertView);
}

-(void) setCurrentAlertView:(UIAlertView *)alertView
{
	objc_setAssociatedObject(self, kUIViewControllerCurrentAlertView, alertView, OBJC_ASSOCIATION_RETAIN);
}

-(UIActionSheet*) currentActionSheet
{
	return objc_getAssociatedObject(self, kUIViewControllerCurrentActionSheet);
}

-(void) setCurrentActionSheet:(UIActionSheet *)actionSheet
{
	objc_setAssociatedObject(self, kUIViewControllerCurrentActionSheet, actionSheet, OBJC_ASSOCIATION_RETAIN);
}

-(UIPopoverController*) currentPopoverController
{
	return objc_getAssociatedObject(self, kUIViewControllerCurrentPopover);
}

-(void) setCurrentPopoverController:(UIPopoverController *)popover
{
	objc_setAssociatedObject(self, kUIViewControllerCurrentPopover, popover, OBJC_ASSOCIATION_RETAIN);
}

-(void) dismissCurrentAlertViewAnimated:(BOOL)animated
{
	UIAlertView *alertView = self.currentAlertView;
	if (alertView)
	{
		[alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:animated];
		self.currentAlertView = nil;
	}
}

-(void) dismissCurrentActionSheetAnimated:(BOOL)animated
{
	UIActionSheet *actionSheet = self.currentActionSheet;
	if (actionSheet)
	{
		[actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:animated];
		self.currentActionSheet = nil;
	}
}

-(void) dismissCurrentPopoverAnimated:(BOOL)animated
{
	UIPopoverController *popoverController = self.currentPopoverController;
	if (popoverController)
	{
		[popoverController dismissPopoverAnimated:animated];
		self.currentPopoverController = nil;
	}
}

-(void) dismissAllContextMenusAnimated:(BOOL)animated
{
	[self dismissCurrentActionSheetAnimated:animated];
	[self dismissCurrentAlertViewAnimated:animated];
	[self dismissCurrentPopoverAnimated:animated];
}

@end
