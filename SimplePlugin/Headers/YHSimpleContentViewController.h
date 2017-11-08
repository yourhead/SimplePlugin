//
//  YHSimpleContentViewController.h
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "YHSimplePlugin.h"

@interface YHSimpleContentViewController : NSViewController
@property (nullable, nonatomic, weak) id<YHSimplePluginDelegateProtocol> delegate;
@end
