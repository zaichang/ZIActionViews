//
//  ZIAlertView.h
//
//  Created by Zehao Chang on 11/16/10.
//  Copyright 2010 Zaia Design. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ZIAlertViewButtonHandler) (NSInteger buttonIndex); 


// A self-delegate UIAlertView that takes blocks to
// handle button presses
// It still takes a delgate in case the caller needs
// to handle the willAppear didAppear type events
// 
@interface ZIAlertView : UIAlertView 
{
	id<UIAlertViewDelegate> trueDelegate;
}
@property (nonatomic,copy) ZIAlertViewButtonHandler clickedButtonAtIndex;
@property (nonatomic,copy) void (^willPresentAlertView)();  // before animation and showing view
@property (nonatomic,copy) void (^didPresentAlertView)();  // after animation
@property (nonatomic,copy) void (^willDismissWithButtonIndex)(NSInteger); // before animation and hiding view
@property (nonatomic,copy) void (^didDismissWithButtonIndex)(NSInteger);  // after animation

//- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
