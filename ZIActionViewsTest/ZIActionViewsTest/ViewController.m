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
	
}


-(IBAction) testZIAlertView:(id)sender
{
	ZIAlertView *alertView = [[ZIAlertView alloc] initWithTitle:@"ZIAlertView" 
														  message:@"" 
														 delegate:nil 
												cancelButtonTitle:@"Cancel" 
												otherButtonTitles:@"Say Goodbye", @"More Options", nil];
	
	alertView.clickedButtonAtIndex = ^(int buttonIndex)
	{
		// Caveat: since the subclass adds button titles manually
		//		   rather than using the constructor,
		//		   alertView.firstOtherButtonIndex will be -1 and thus
		//		   if (buttonIndex == alertView.firstOtherButtonIndex)
		//		   won't work as expected
		
		if (buttonIndex == 1)
		{
			// Button 1
			ZIAlertView *secondAlertView = [[ZIAlertView alloc] initWithTitle:@"Goodbye" 
																		message:@"" 
																	   delegate:nil
															  cancelButtonTitle:@"Okay" 
															  otherButtonTitles:nil];
			[secondAlertView show];
			[secondAlertView release];
		}
		else if (buttonIndex == 2)
		{
			ZIAlertView *secondAlertView = [[ZIAlertView alloc] initWithTitle:@"More Options" 
																		message:@"" 
																	   delegate:nil 
															  cancelButtonTitle:@"Nah" 
															  otherButtonTitles:@"Another Button", @"Neverending", nil];
			
			secondAlertView.clickedButtonAtIndex = ^(int buttonIndex)
			{
				if (buttonIndex == 2)
					[self testZIAlertView:nil];
			};
			
			[secondAlertView show];
			[secondAlertView release];
		}
	};
	
	alertView.willPresentAlertView = ^{
		NSLog(@"ZIAlertView willPresentAlertView");
	};
	
	alertView.didPresentAlertView = ^{
		NSLog(@"ZIAlertView didPresentAlertView");
	};
	
	alertView.willDismissWithButtonIndex = ^(int buttonIndex)
	{
		NSLog(@"ZIAlertView willDismissWithButtonIndex %d", buttonIndex);
	};
	
	alertView.didDismissWithButtonIndex = ^(int buttonIndex)
	{
		NSLog(@"ZIAlertView didDismissWithButtonIndex %d", buttonIndex);
	};
	
	[alertView show];
	[alertView release];
}

-(IBAction) testZIActionSheet:(id)sender
{
	ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];
	ZIActionItem *deleteItem = [ZIActionItem actionItemWithTitle:@"Delete?" userInfo:nil action:^(ZIActionItem *item) {
		ZIAlertView *alertView = [[ZIAlertView alloc] initWithTitle:@"Deleted!" 
															message:nil
														   delegate:nil 
												  cancelButtonTitle:@"Okay" 
												  otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}];
	ZIActionItem *alertItem = [ZIActionItem actionItemWithTitle:@"ZIAlertView" userInfo:nil action:^(ZIActionItem *item) {
		[self testZIAlertView:nil];
	}];
	
	ZIActionSheet *actionSheet = [[ZIActionSheet alloc] initWithTitle:@"ZIActionSheet"
													 cancelActionItem:cancelItem
												destructiveActionItem:deleteItem
											   otherButtonActionItems:[NSArray arrayWithObjects:alertItem, nil]];
	
	actionSheet.willPresentActionSheet = ^{
		NSLog(@"ZIActionSheet willPresentActionSheet");
	};
	
	actionSheet.didPresentActionSheet = ^{
		NSLog(@"ZIActionSheet didPresentActionSheet");
	};
	
	actionSheet.willDismissWithButtonIndex = ^(int buttonIndex) 
	{ 
		NSLog(@"ZIActionSheet willDismissWithButtonIndex %d", buttonIndex);
	};
	
	actionSheet.didDismissWithButtonIndex = ^(int buttonIndex) 
	{ 
		NSLog(@"ZIActionSheet didDismissWithButtonIndex %d", buttonIndex);
	};
	
	UIView *hostView = [sender isKindOfClass:[UIControl class]] ? [sender superview] : self.view;
	[actionSheet showInView:hostView];
	[actionSheet release];
}

-(IBAction) testZIPopoverController:(id)sender
{
	ZIPopoverController *popoverController = [[ZIPopoverController alloc] initWithContentViewController:popoverContentsViewController];
	popoverContentsViewController.contentSizeForViewInPopover = CGSizeMake(320.0, 320.0);
	
	popoverController.shouldDismiss = ^{
		NSLog(@"ZIPopoverController shouldDismiss");
		
		return YES;
	};
	popoverController.didDismiss = ^{
		NSLog(@"ZIPopoverController didDismiss");
		
		[popoverController release];
	};
	
	[popoverController presentPopoverFromRect:testPopoverButton.frame inView:testPopoverButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
