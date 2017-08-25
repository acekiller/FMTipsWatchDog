//
//  FMTipsWatchDog.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMTipsWatchDog.h"
#import "FMTipsPageSimple.h"

@interface FMTipsWatchDog ()
@property (nonatomic, strong) NSMutableDictionary *tipsPages;
@end

@implementation FMTipsWatchDog

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tipsPages = [NSMutableDictionary new];
    }
    return self;
}

+ (instancetype) defaultManager {
    static id _instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void) registerTipsForPage:(NSString *)pageName
                 constraints:(id<FMTipsPageConstraints>)pageConstraints {
    FMTipsPage *tipsPage = [_tipsPages objectForKey:pageName];
    if (tipsPage == nil) {
        tipsPage = [[FMTipsPage alloc] initTipsWithPage:pageName
                                            constraints:pageConstraints];
        [self.tipsPages setObject:tipsPage forKey:pageName];
    }
    [tipsPage clearCacheConditions];
}

- (void) clearCacheConditionsForPage:(NSString *)pageName {
    FMTipsPage *page = [_tipsPages objectForKey:pageName];
    nil == page ? : [page clearCacheConditions];
}

- (void) markToShown:(NSString *)tipsName
             forPage:(NSString *)pageName {
    FMTipsPage *page = [_tipsPages objectForKey:pageName];
    nil == page ? : [page markToShown:tipsName];
}

- (BOOL) hasShown:(NSString *)tipsName forPage:(NSString *)pageName {
    return [[_tipsPages objectForKey:pageName] hasShown:tipsName];
}

- (RACSignal *) signalForPage:(NSString *)pageName {
    FMTipsPage *page = [_tipsPages objectForKey:pageName];
    return nil == page ? nil : [page tipsSignal];
}

- (RACSignal *) signalForTips:(NSString *)tipsName page:(NSString *)pageName {
    FMTipsPage *page = [_tipsPages objectForKey:pageName];
    return nil == page ? nil : [page tipsSignalForTips:tipsName];
}

- (void) sendNextTipsForPage:(NSString *)pageName {
    [self sendNextTipsForPage:pageName
                   conditions:nil];
}

- (void) sendNextTipsForPage:(NSString *)pageName
                  conditions:(NSDictionary *)conditions {
    FMTipsPage *page = [_tipsPages objectForKey:pageName];
    nil == page ? : (conditions ? [page sendNextTipsFConditions:conditions] : [page sendNextTips]);
}

@end
