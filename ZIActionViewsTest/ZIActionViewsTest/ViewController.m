//
//  ViewController.m
//  ZIActionViewsTest
//
//  Created by Zai Chang on 4/11/12.
//  Copyright (c) 2012 Zaia Design. All rights reserved.
//

#import "ViewController.h"
#import "ZIAlertView.h"
#import "ZIActionSheet.h"
#import "ZIPopoverController.h"


@interface ViewController ()

@end


@implementation ViewController

@synthesize popoverContentsViewController;
@synthesize testPopoverButton;
@synthesize statusLabel;


-(void) dealloc
{
	self.popoverContentsViewController = nil;
	self.testPopoverButton = nil;
	self.statusLabel = nil;
	
	[super dealloc];
}


#pragma mark - View Lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

-(void) viewDidLoad
{
	[super viewDidLoad];
	
	self.testPopoverButton.hidden = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad);
}

-(void) viewDidUnload
{
	[super viewDidUnload];
	
	self.popoverContentsViewController = nil;
	self.testPopoverButton = nil;
	self.statusLabel = nil;
}


#pragma mark - Actions

-(void) log:(NSString*)message
{
	statusLabel.text = message;
	
	NSLog(@"%@", message);
}


-(IBAction) testZIAlertView:(id)sender
{
	ZIActionItem *goodbyeItem = [ZIActionItem actionItemWithTitle:@"Say Goodbye" userInfo:nil action:^(ZIActionItem *item)
	{
		ZIAlertView *secondAlertView = [[ZIAlertView alloc] initWithTitle:@"Goodbye"
																  message:@""
																 delegate:nil
														cancelButtonTitle:@"Okay"
														otherButtonTitles:nil];
		[secondAlertView show];
		[secondAlertView release];
	}];
	
	ZIActionItem *moreOptionsItem = [ZIActionItem actionItemWithTitle:@"More Options" userInfo:nil action:^(ZIActionItem *item)
	{
		ZIActionItem *alertItem = [ZIActionItem actionItemWithTitle:@"Neverending" userInfo:nil action:^(ZIActionItem *item)
		{
			[self testZIAlertView:nil];
		}];
		ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];
		ZIAlertView *secondAlertView = [[ZIAlertView alloc] initWithTitle:@"More Options"
																  message:@""
														 cancelActionItem:cancelItem
												   otherButtonActionItems:[NSArray arrayWithObjects:alertItem, nil]];
		
		[secondAlertView show];
		[secondAlertView release];
	}];
	
	ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];
	
	ZIAlertView *alertView = [[ZIAlertView alloc] initWithTitle:@"ZIAlertView"
														message:@"Testing alert"
											   cancelActionItem:cancelItem
										 otherButtonActionItems:[NSArray arrayWithObjects:goodbyeItem, moreOptionsItem, nil]];
	
	alertView.willPresentAlertView = ^
	{
		[self log:@"ZIAlertView willPresentAlertView"];
	};
	
	alertView.didPresentAlertView = ^
	{
		[self log:@"ZIAlertView didPresentAlertView"];
	};
	
	alertView.willDismissWithButtonIndex = ^(int buttonIndex)
	{
		[self log:[NSString stringWithFormat:@"ZIAlertView willDismissWithButtonIndex %d", buttonIndex]];
	};
	
	alertView.didDismissWithButtonIndex = ^(int buttonIndex)
	{
		[self log:[NSString stringWithFormat:@"ZIAlertView didDismissWithButtonIndex %d", buttonIndex]];
	};
	
	[alertView show];
	[alertView release];
}

-(IBAction) testZIActionSheet:(id)sender
{
	ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];
	ZIActionItem *deleteItem = [ZIActionItem actionItemWithTitle:@"Delete?" userInfo:nil action:^(ZIActionItem *item)
	{
		ZIAlertView *alertView = [[ZIAlertView alloc] initWithTitle:@"Deleted!"
															message:nil
														   delegate:nil
												  cancelButtonTitle:@"Okay"
												  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}];
	
	ZIActionItem *alertItem = [ZIActionItem actionItemWithTitle:@"ZIAlertView" userInfo:nil action:^(ZIActionItem *item)
	{
		[self testZIAlertView:nil];
	}];
	
	ZIActionSheet *actionSheet = [[ZIActionSheet alloc] initWithTitle:@"ZIActionSheet"
													 cancelActionItem:cancelItem
												destructiveActionItem:deleteItem
											   otherButtonActionItems:[NSArray arrayWithObjects:alertItem, nil]];
	
	actionSheet.willPresentActionSheet = ^
	{
		[self log:@"ZIActionSheet willPresentActionSheet"];
	};
	
	actionSheet.didPresentActionSheet = ^
	{
		[self log:@"ZIActionSheet didPresentActionSheet"];
	};
	
	actionSheet.willDismissWithButtonIndex = ^(int buttonIndex) 
	{ 
		[self log:[NSString stringWithFormat:@"ZIActionSheet willDismissWithButtonIndex %d", buttonIndex]];
	};
	
	actionSheet.didDismissWithButtonIndex = ^(int buttonIndex) 
	{ 
		[self log:[NSString stringWithFormat:@"ZIActionSheet didDismissWithButtonIndex %d", buttonIndex]];
	};
	
	UIView *hostView = [sender isKindOfClass:[UIControl class]] ? [sender superview] : self.view;
	[actionSheet showInView:hostView];
	[actionSheet release];
}

-(IBAction) testZIPopoverController:(id)sender
{
	ZIPopoverController *popoverController = [[ZIPopoverController alloc] initWithContentViewController:popoverContentsViewController];
	popoverContentsViewController.contentSizeForViewInPopover = CGSizeMake(320.0, 320.0);
	
	popoverController.shouldDismiss = ^
	{
		[self log:@"ZIPopoverController shouldDismiss"];
		
		return YES;
	};
	popoverController.didDismiss = ^
	{
		[self log:@"ZIPopoverController didDismiss"];
		
		[popoverController release];
	};
	
	[popoverController presentPopoverFromRect:testPopoverButton.frame inView:testPopoverButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
