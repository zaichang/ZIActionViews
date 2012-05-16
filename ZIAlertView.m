//
//  ZIAlertView.m
//
//  Created by Zai Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import "ZIAlertView.h"


@implementation ZIAlertView

@synthesize clickedButtonAtIndex;
@synthesize alertViewCancel;
@synthesize willPresentAlertView;
@synthesize didPresentAlertView;
@synthesize willDismissWithButtonIndex;
@synthesize didDismissWithButtonIndex;


- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelActionItem:(ZIActionItem *)cancelItem otherButtonActionItems:(NSArray *)otherItems
{
	self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	if (self)
	{
		firstOtherButtonIndex = -1;
		
		cancelActionItem = [cancelItem retain];
		otherButtonActionItems = [otherItems retain];
		
		for (ZIActionItem *item in otherButtonActionItems)
		{
			NSInteger index = [self addButtonWithTitle:item.title];
			if (firstOtherButtonIndex < 0)
				firstOtherButtonIndex = index;
		}
		
		if (cancelActionItem.title)
			self.cancelButtonIndex = [self addButtonWithTitle:cancelActionItem.title];
	}
	return self;
}


-(void) dealloc
{
	[cancelActionItem release];
	cancelActionItem = nil;
	
	[otherButtonActionItems release];
	otherButtonActionItems = nil;
		
	[super dealloc];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == self.cancelButtonIndex)
	{
		if (cancelActionItem.action)
			cancelActionItem.action(cancelActionItem);
	}
	else
	{
		NSInteger index = buttonIndex - firstOtherButtonIndex;
		ZIActionItem *item = [otherButtonActionItems objectAtIndex:index];
		if (item.action)
			item.action(item);
	}
	
	if (clickedButtonAtIndex)
		clickedButtonAtIndex(buttonIndex);
}


- (void)alertViewCancel:(UIAlertView *)alertView
{
	if (alertViewCancel)
		alertViewCancel(self);
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
	if (willPresentAlertView)
		willPresentAlertView(self);
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
	if (didPresentAlertView)
		didPresentAlertView(self);
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (willDismissWithButtonIndex)
		willDismissWithButtonIndex(buttonIndex);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (didDismissWithButtonIndex)
		didDismissWithButtonIndex(buttonIndex);
}

@end
