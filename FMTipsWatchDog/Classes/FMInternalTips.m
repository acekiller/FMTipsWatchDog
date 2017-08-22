//
//  FMInternalTips.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMInternalTips.h"

@interface FMInternalTips ()
@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSString *tipsName;
@property (nonatomic, assign) NSInteger index;
@end

@implementation FMInternalTips

- (instancetype)initWithTips:(NSString *)tipsName
                      prefix:(NSString *)prefix
                       index:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.index = index;
        self.prefix = prefix;
        self.tipsName = tipsName;
    }
    return self;
}

- (NSString *) saveName {
    return [NSString stringWithFormat:@"%@_%@",_prefix ? _prefix : @"", _tipsName];
}

- (BOOL) hasShown {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[self saveName]];
}

- (void) markToShown {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self saveName]];
}

@end
