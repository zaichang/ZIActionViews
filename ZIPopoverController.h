//
//  ZUIPopoverController.h
//
//  Created by Zai Chang on 11/24/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZIPopoverController : UIPopoverController <UIPopoverControllerDelegate>
{
	BOOL (^shouldDismiss) (void);
	void (^didDismiss)(void);
}
@property (nonatomic,copy) BOOL (^shouldDismiss) (void);
@property (nonatomic,copy) void (^didDismiss) (void);

@end
