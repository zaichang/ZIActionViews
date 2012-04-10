//
//  ZIAlertView.m
//
//  Created by Zehao Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import "ZIAlertView.h"


@implementation ZIAlertView

@synthesize clickedButtonAtIndex;
@synthesize willPresentAlertView;
@synthesize didPresentAlertView;
@synthesize willDismissWithButtonIndex;
@synthesize didDismissWithButtonIndex;


// I had trouble figuring a way to pass the va_list
// to the superclass ... instead I'm trying this method
// detailed here:
// http://stackoverflow.com/questions/2345196/objective-c-passing-around-nil-terminated-argument-lists
// 

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{	
	if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil])
	{
		trueDelegate = delegate;
		
		if (otherButtonTitles != nil) 
		{
			[self addButtonWithTitle:otherButtonTitles];
			va_list args;
			va_start(args, otherButtonTitles);
			NSString * title = nil;
			while(title = va_arg(args,NSString*)) 
			{
				[self addButtonWithTitle:title];
			}
			va_end(args);
		}		
	}
	return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (clickedButtonAtIndex)
		clickedButtonAtIndex(buttonIndex);
}

// Forwarding other UIAlertViewDelegates in case the caller wants to use these
// 
//- (void)alertViewCancel:(UIAlertView *)alertView
//{
//	if ([trueDelegate respondsToSelector:@selector(alertViewCancel:)])
//		[trueDelegate alertViewCancel:self];
//}

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
