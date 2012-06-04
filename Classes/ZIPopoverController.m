//
//  ZUIPopoverController.m
//
//  Created by Zehao Chang on 11/24/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import "ZIPopoverController.h"


@implementation ZIPopoverController

@synthesize shouldDismiss;
@synthesize didDismiss;

-(id) initWithContentViewController:(UIViewController *)viewController
{
	if (self = [super initWithContentViewController:viewController])
	{
		self.delegate = self;
	}
	return self;
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
	if (shouldDismiss)
		return shouldDismiss();
	else
		return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	if (didDismiss)
		didDismiss();
}

@end
