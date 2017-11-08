//
//  YHSimplePlugin.m
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import "YHSimplePlugin.h"
#import "YHSimpleContentViewController.h"
#import "YHSimpleInfoViewController.h"
#import "YHSimpleContent.h"


@interface YHSimplePlugin () <YHSimplePluginDelegateProtocol>
@property (nonatomic, strong) YHSimpleContentViewController *contentViewController;
@property (nonatomic, strong) YHSimpleInfoViewController *infoViewController;
@property (nonatomic, strong) YHSimpleContent *content;
@end


@implementation YHSimplePlugin

- (instancetype)init {
    self = [super init];
    if (self) {
        _content = [[YHSimpleContent alloc] init];
    }
    return self;
}

// I've left a log message here. Make sure that you see it when
// a page of this type is removed from a file. If you don't see
// it then you have a retain cycle.
- (void)dealloc {
    NSLog (@"%@ deallocated", [YHSimplePlugin pluginName]);
}




#pragma mark - Dynamic view controllers

//
// We create a view controller for the main content area and info-sidebar
// these controllers have our main content as their represented object.
// In this way the main views can share the data with the plugin and each other
// but keep things separated, modular, and tidy.
//

- (YHSimpleContentViewController *)contentViewController {
    if (!_contentViewController) {
        _contentViewController = [[YHSimpleContentViewController alloc] initWithNibName:@"YHSimpleContentViewController" bundle:YHSimpleBundle()];
        _contentViewController.delegate = self;
        _contentViewController.representedObject = self.content;
    }
    return _contentViewController;
}

- (YHSimpleInfoViewController *)infoViewController {
    if (!_infoViewController) {
        _infoViewController = [[YHSimpleInfoViewController alloc] initWithNibName:@"YHSimpleInfoViewController" bundle:YHSimpleBundle()];
        _infoViewController.delegate = self;
        _infoViewController.representedObject = self.content;
    }
    return _infoViewController;
}




#pragma mark - Saving the data

NSString *const YHSimplePluginContentKey = @"content";

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _content = ([coder decodeObjectForKey:YHSimplePluginContentKey]) ?: [[YHSimpleContent alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:_content forKey:YHSimplePluginContentKey];
}




#pragma mark - PluginDelegate

// a simple delegate to allow the responder chain
// to communicate back to the page/plugin
// this can be more comlex, but here we just tell
// RW that this page is dirty and needs to be saved/published

- (void)contentDidChange {
    [self broadcastPluginChanged];
}

- (void)settingDidChange {
    [self broadcastPluginChanged];
}




#pragma mark - Abastract Plugin API - Plugin Info

+ (BOOL)initializeClass:(NSBundle *)aBundle {
    return YES;
}

+ (NSBundle *)bundle {
    return [NSBundle bundleForClass:self];
}

+ (NSString *)pluginName {

    return YHSimpleLocalizedString(@"Plugin Name");
}

+ (NSString *)pluginAuthor {
    return YHSimpleLocalizedString(@"Plugin Author");
}

+ (NSString *)pluginDescription {
    return YHSimpleLocalizedString(@"Plugin Description");
}

+ (NSImage *)pluginIcon {
    // this can get called a lot
    // and images are slow to create
    // let's do this once and keep it around
    static NSImage *icon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *iconFile = [YHSimpleBundle() objectForInfoDictionaryKey:@"CFBundleIconFile"];
        NSURL *url = [YHSimpleBundle() URLForImageResource:iconFile];
        icon = [[NSImage alloc] initWithContentsOfURL:url];
    });
    return icon;
}




#pragma mark Protocol Methods - Plugin Content

- (id)contentHTML:(NSDictionary *)params {
    return [self.content contentHTML:params];
}

- (NSArray *)extraFilesNeededInExportFolder:(NSDictionary *)params {
    return [self.content extraFiles:params];
}

- (NSString *)sidebarHTML:(NSDictionary *)params {
    return [self.content sidebarHTML:params];
}




#pragma mark Protocol Methods - Views

// the info sidebar view
- (NSView *)optionsAndConfigurationView {
    return self.infoViewController.view;
}

// the main content editing view
- (NSView *)userInteractionAndEditingView {
    return self.contentViewController.view;
}




#pragma mark - Conveinence Functions

NSBundle * YHSimpleBundle(void) {
    return [YHSimplePlugin bundle];
}

NSString * YHSimpleLocalizedString(NSString *string) {
    return NSLocalizedStringFromTableInBundle(string, @"Localized", YHSimpleBundle(), nil);
}





@end
