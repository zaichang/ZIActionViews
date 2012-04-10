//
//  ZUIPopoverController.h
//
//  Created by Zehao Chang on 11/24/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZIPopoverController : UIPopoverController <UIPopoverControllerDelegate>
{
	BOOL (^shouldDismissBlock) (void);
	void (^didDismissBlock)(void);
}
@property (nonatomic,copy) BOOL (^shouldDismissBlock) (void);
@property (nonatomic,copy) void (^didDismissBlock) (void);

@end
