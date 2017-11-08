//
//  YHSimpleContent.h
//  SimplePlugin
//
//  Created by Isaiah Carew on 11/7/17.
//  Copyright © 2017 YourHead. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSimpleContent : NSObject <NSCoding>
@property (nonnull, nonatomic, strong) NSString *string;
@property (nonnull, nonatomic, strong) NSString *htmlString;

- (nonnull NSString *)contentHTML:(nonnull NSDictionary *)params;
- (nonnull NSArray *)extraFiles:(nonnull NSDictionary *)params;
- (nonnull NSString *)sidebarHTML:(nonnull NSDictionary *)params;

@end
