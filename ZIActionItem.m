//
//  ZIActionItem.m
//  Maplets
//
//  Created by zai chang on 11/22/11.
//  Copyright (c) 2011 Zaia Design. All rights reserved.
//

#import "ZIActionItem.h"

@implementation ZIActionItem

@synthesize title;
@synthesize action;
@synthesize userInfo;

-(id) initWithTitle:(NSString*)aTitle userInfo:(id)someUserInfo action:(void (^)(ZIActionItem *item))anAction
{
	self = [super init];
	if (self)
	{
		title = [aTitle copy];
		action = [anAction copy];
		userInfo = [someUserInfo retain];
	}
	return self;
}

-(void) dealloc
{
	self.title = nil;
	self.action = nil;
	self.userInfo = nil;
	
	[super dealloc];
}

+(ZIActionItem*) actionItemWithTitle:(NSString*)aTitle userInfo:(id)someUserInfo action:(void (^)(ZIActionItem *item))anAction
{
	return [[[ZIActionItem alloc] initWithTitle:aTitle userInfo:someUserInfo action:anAction] autorelease];
}

@end
