//
//  YHSimpleContent.m
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import "YHSimpleContent.h"


@interface YHSimpleContent ()
@end


@implementation YHSimpleContent

- (nullable instancetype)init {
    self = [super init];
    if (self) {
        _string = @"";
        _htmlString = @"";
    }
    return self;
}




#pragma mark - Saving the data

//
// We load and store the content object here.
// If our plugin was more complex we might have other
// objects to store too.
//

NSString *const YHSimpleContentStringKey = @"string";
NSString *const YHSimpleHtmlContentStringKey = @"htmlString";

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _string = ([coder decodeObjectForKey:YHSimpleContentStringKey]) ?: @"";
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (_string) {
        [coder encodeObject:_string forKey:YHSimpleContentStringKey];
    }
}



//
// Warning:  These methods may be called on a background thread. This background
//           thread may not call out to main thread, wait for the main thread,
//           or wait for any resource that requires the main thread.
//
//           This means that you should not attempt to access any user interface
//           elements. Using a property that has a binding to a NSTextField is OK,
//           but accessing the NSTextField's string property is not.
//
//           It might seem tempting to pre-generate content. However the params
//           values will change based on user's setting and the type of export being
//           done (preview, export, publish, etc.). This means that links and paths
//           will need to be generated on the fly for the params provided at the time.
//
//           Here we simply pass these calls down to the model object.
//




- (nonnull NSString *)contentHTML:(NSDictionary *)params {
    return self.htmlString;
}

- (nonnull NSArray *)extraFiles:(NSDictionary *)params {
    return @[];
}

- (nonnull NSString *)sidebarHTML:(NSDictionary *)params {
    return @"Sidebar Content";
}

@end
