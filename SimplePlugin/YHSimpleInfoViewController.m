//
//  YHSimpleInfoViewController.m
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import "YHSimpleInfoViewController.h"


@interface YHSimpleInfoViewController ()
@end


@implementation YHSimpleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




#pragma mark - plugin delegate

- (void)delegateSettingDidChange {
    __strong id <YHSimplePluginDelegateProtocol> strongDelegate = self.delegate;
    if (strongDelegate) {
        [strongDelegate settingDidChange];
    }
}


@end
