//
//  YHSimplePlugin.h
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RWKit/RWKit.h>


@interface YHSimplePlugin : RWAbstractPlugin
@end


@protocol YHSimplePluginDelegateProtocol <NSObject>
@required
- (void)contentDidChange;
- (void)settingDidChange;
@end
