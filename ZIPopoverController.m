//
//  ZUIPopoverController.m
//
//  Created by Zehao Chang on 11/24/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import "ZIPopoverController.h"


@implementation ZIPopoverController

@synthesize shouldDismissBlock;
@synthesize didDismissBlock;

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
	if (shouldDismissBlock)
		return shouldDismissBlock();
	else
		return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
	if (didDismissBlock)
		didDismissBlock();
}

@end
