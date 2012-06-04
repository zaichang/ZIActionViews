ZIActionViews
=============
ZIActionViews is a collection of classes that augment UIKit components such as UIAlertView, UIActionSheet to provide blocks-based event handling instead of using the delegate.

I find this style of code clearer as the control and its handler are placed side by side, and items can be inserted conditionally simply by adding an extra ZIActionItem.

For ZIPopoverController, the only addition are blocks-based event listeners



Installation
============
Simply drag the files into your project and go! No need to mess with library paths, target dependencies, etc



Usage
=====
ZIActionItem encapsulates an action that can be presented within a ZIAlertView or ZIActionSheet, providing either element with a button title as well as a handler block for invoking the action. Both ZIAlertView and ZIActionSheet have designated initializers that take ZIActionItems instead of button titles.


#### Using ZIAlertView
<pre>
ZIActionItem *itemOne = [ZIActionItem actionItemWithTitle:@"Say Goodbye" userInfo:nil action:^(ZIActionItem *item)
{
	// Do something
}];

ZIActionItem *itemTwo = [ZIActionItem actionItemWithTitle:@"More Options" userInfo:nil action:^(ZIActionItem *item)
{
	// Do something else
}];

ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];

ZIAlertView *alertView = [[ZIAlertView alloc] initWithTitle:@"ZIAlertView"
													message:@"Your message goes here"
										   cancelActionItem:cancelItem
									 otherButtonActionItems:[NSArray arrayWithObjects:itemOne, itemTwo, nil]];
	
[alertView show];
[alertView release];
</pre>

#### Using ZIActionSheet
<pre>
ZIActionItem *cancelItem = [ZIActionItem actionItemWithTitle:@"Cancel" userInfo:nil action:nil];

ZIActionItem *deleteItem = [ZIActionItem actionItemWithTitle:@"Delete?" userInfo:nil action:^(ZIActionItem *item)
{
	// Delete something
}];

ZIActionItem *anAction = [ZIActionItem actionItemWithTitle:@"ZIAlertView" userInfo:nil action:^(ZIActionItem *item)
{
	// Act on something
}];

ZIActionSheet *actionSheet = [[ZIActionSheet alloc] initWithTitle:@"ZIActionSheet"
												 cancelActionItem:cancelItem
											destructiveActionItem:deleteItem
										   otherButtonActionItems:[NSArray arrayWithObjects:anAction, nil]];

[actionSheet showInView:self.view];
[actionSheet release];
</pre>


#### Using ZIPopoverController
<pre>
ZIPopoverController *popoverController = [[ZIPopoverController alloc] initWithContentViewController:popoverContentsViewController];

popoverController.shouldDismiss = ^
{
	// Should dismiss?
	return YES;
};
popoverController.didDismiss = ^
{
	// DIsmissed
	
	[popoverController release];
};

[popoverController presentPopoverFromRect:aFrame inView:aView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
</pre>



Sample
=====
There's a simple example project under the ZIActionViewsTest folder
