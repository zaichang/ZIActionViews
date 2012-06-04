//
//  ZIAlertView.h
//
//  Created by Zai Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZIActionItem.h"


typedef void (^ZIAlertViewButtonHandler) (NSInteger buttonIndex); 


// A self-delegate UIAlertView that takes blocks to
// handle button presses
// It still takes a delgate in case the caller needs
// to handle the willAppear didAppear type events
// 
@interface ZIAlertView : UIAlertView 
{
	ZIActionItem *cancelActionItem;
	NSArray *otherButtonActionItems;
	NSInteger firstOtherButtonIndex;	// Replaces the UIAlertView accessor
}

@property (nonatomic,copy) ZIAlertViewButtonHandler clickedButtonAtIndex;

@property (nonatomic,copy) void (^alertViewCancel)();  // before animation and showing view
@property (nonatomic,copy) void (^willPresentAlertView)();  // before animation and showing view
@property (nonatomic,copy) void (^didPresentAlertView)();  // after animation
@property (nonatomic,copy) void (^willDismissWithButtonIndex)(NSInteger); // before animation and hiding view
@property (nonatomic,copy) void (^didDismissWithButtonIndex)(NSInteger);  // after animation

// Designated initializer
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelActionItem:(ZIActionItem *)cancelItem otherButtonActionItems:(NSArray *)otherItems;

@end
