//
//  ZIActionItem.h
//  Maplets
//
//  Created by zai chang on 11/22/11.
//  Copyright (c) 2011 Zaia Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIActionItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^action)(ZIActionItem *item);
@property (nonatomic, retain) id userInfo;

-(id) initWithTitle:(NSString*)aTitle userInfo:(id)someUserInfo action:(void (^)(ZIActionItem *item))anAction;
+(ZIActionItem*) actionItemWithTitle:(NSString*)aTitle userInfo:(id)someUserInfo action:(void (^)(ZIActionItem *item))anAction;

@end
