//
//  ZIActionSheet.m
//
//  Created by Zehao Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import "ZIActionSheet.h"


@implementation ZIActionSheet

@synthesize clickedButtonAtIndex;
@synthesize actionSheetCancel;
@synthesize willPresentActionSheet;
@synthesize didPresentActionSheet;
@synthesize willDismissWithButtonIndex;
@synthesize didDismissWithButtonIndex;


-(id) initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	if ((self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
	{
		firstOtherButtonIndex = -1;
		
		if (otherButtonTitles != nil) 
		{
			[self addButtonWithTitle:otherButtonTitles];
			va_list args;
			va_start(args, otherButtonTitles);
			NSString * title = nil;
			while ((title = va_arg(args,NSString*)))
			{
				NSInteger index = [self addButtonWithTitle:title];
				if (firstOtherButtonIndex < 0)
					firstOtherButtonIndex = index;
			}
			va_end(args);
		}		
		
		if (destructiveButtonTitle)
			self.destructiveButtonIndex = [self addButtonWithTitle:destructiveButtonTitle];
		if (cancelButtonTitle)
			self.cancelButtonIndex = [self addButtonWithTitle:cancelButtonTitle];
	}
	return self;	
}

-(id) initWithTitle:(NSString *)title cancelActionItem:(ZIActionItem *)cancelItem destructiveActionItem:(ZIActionItem *)destructiveItem otherButtonActionItems:(NSArray *)otherItems
{
	self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	if (self)
	{
		firstOtherButtonIndex = -1;
		
		cancelActionItem = [cancelItem retain];
		destructiveActionItem = [destructiveItem retain];
		otherButtonActionItems = [otherItems retain];
		
		for (ZIActionItem *item in otherButtonActionItems)
		{
			NSInteger index = [self addButtonWithTitle:item.title];
			if (firstOtherButtonIndex < 0)
				firstOtherButtonIndex = index;
		}
		
		if (destructiveActionItem.title)
			self.destructiveButtonIndex = [self addButtonWithTitle:destructiveActionItem.title];
		if (cancelActionItem.title)
			self.cancelButtonIndex = [self addButtonWithTitle:cancelActionItem.title];
	}
	return self;
}

-(void) dealloc
{
	[cancelActionItem release]; cancelActionItem = nil;
	[destructiveActionItem release]; destructiveActionItem = nil;
	[otherButtonActionItems release]; otherButtonActionItems = nil;
	
	[super dealloc];
}

-(NSInteger) firstOtherButtonIndex
{
	return firstOtherButtonIndex;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == self.cancelButtonIndex)
	{
		if (cancelActionItem.action)
			cancelActionItem.action(cancelActionItem);
	}
	else if (buttonIndex == self.destructiveButtonIndex)
	{
		if (destructiveActionItem.action)
			destructiveActionItem.action(destructiveActionItem);
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

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
	if (actionSheetCancel)
		actionSheetCancel();
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet;  // before animation and showing view
{
	if (willPresentActionSheet)
		willPresentActionSheet();
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet;  // after animation
{
	if (didPresentActionSheet)
		didPresentActionSheet();
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
{
	if (willDismissWithButtonIndex)
		willDismissWithButtonIndex(buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation
{
	if (didDismissWithButtonIndex)
		didDismissWithButtonIndex(buttonIndex);
}

@end
