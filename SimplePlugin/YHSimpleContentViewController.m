//
//  YHSimpleContentViewController.m
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <RWKit/RWKit.h>

#import "YHSimpleContentViewController.h"
#import "YHSimpleContent.h"


@interface YHSimpleContentViewController ()
@property (nonnull, nonatomic, strong) IBOutlet RWMarkdownView *markdownView;
@property (nonnull, nonatomic, strong) IBOutlet WebView *webView;
@property (nullable, nonatomic, readonly) YHSimpleContent *content;
@end


@implementation YHSimpleContentViewController

NSString *const YHSimpleEditorFontSizeUserDefaultsKey = @"SimpleEditorFontSize";

- (void)viewDidLoad {
    [super viewDidLoad];

    // configure the markdown view a bit
    self.markdownView.hasBorder = NO;
    self.markdownView.showLineNumbers = YES;

    // load the model data into the views
    self.markdownView.string = (self.content.string) ?: @"";
    [self renderWebView];

    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:YHSimpleEditorFontSizeUserDefaultsKey options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)dealloc {
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:YHSimpleEditorFontSizeUserDefaultsKey];
}

// A convenience method to map the represented object to the type we expect
- (nullable YHSimpleContent *)content {
    NSAssert ([self.representedObject isKindOfClass:[YHSimpleContent class]], @"the represented object should be YHSimpleContent");
    return self.representedObject;
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:YHSimpleEditorFontSizeUserDefaultsKey]) {
        [self updateEditorFontSize];
    }
}



#pragma mark - manage the views

- (void)renderWebView {
    NSString *content = [NSString stringWithFormat:@"<html><body>%@</body></html>", (self.markdownView.htmlString) ?: @""];
    [self.webView.mainFrame loadHTMLString:content baseURL:[NSURL URLWithString:@"/"]];
}

- (void)updateEditorFontSize {
    NSNumber *fontSizeValue = [[NSUserDefaults standardUserDefaults] valueForKey:YHSimpleEditorFontSizeUserDefaultsKey];
    CGFloat fontSize = (fontSizeValue) ? fontSizeValue.CGFloatValue : 12.f;
    self.markdownView.fontSize = fontSize;
}




#pragma mark - NSTextView delegate

- (void)textDidChange:(NSNotification *)notification {
    self.content.string = (self.markdownView.string) ?: @"";
    self.content.htmlString = (self.markdownView.htmlString) ?: @"";
    [self renderWebView];
    [self delegateContentDidChange];
}




#pragma mark - plugin delegate

- (void)delegateContentDidChange {
    __strong id <YHSimplePluginDelegateProtocol> strongDelegate = self.delegate;
    if (strongDelegate) {
        [strongDelegate contentDidChange];
    }
}

@end
