//
//  ZIActionSheet.h
//
//  Created by Zai Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZIActionItem.h"


typedef void (^ZIActionSheetEventHandler) ();
typedef void (^ZIActionSheetButtonHandler) (NSInteger buttonIndex); 


@interface ZIActionSheet : UIActionSheet <UIActionSheetDelegate>
{
	ZIActionItem *cancelActionItem;
	ZIActionItem *destructiveActionItem;
	NSArray *otherButtonActionItems;
	NSInteger firstOtherButtonIndex;	// Replaces the UIActionSheet accessor
}

@property (nonatomic,copy) ZIActionSheetButtonHandler clickedButtonAtIndex;
@property (nonatomic,copy) ZIActionSheetEventHandler actionSheetCancel;
@property (nonatomic,copy) ZIActionSheetEventHandler willPresentActionSheet;
@property (nonatomic,copy) ZIActionSheetEventHandler didPresentActionSheet;
@property (nonatomic,copy) ZIActionSheetButtonHandler willDismissWithButtonIndex;
@property (nonatomic,copy) ZIActionSheetButtonHandler didDismissWithButtonIndex;

// Designated initializers
-(id) initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
-(id) initWithTitle:(NSString *)title cancelActionItem:(ZIActionItem *)cancelItem destructiveActionItem:(ZIActionItem *)destructiveItem otherButtonActionItems:(NSArray *)otherItems;

@end
