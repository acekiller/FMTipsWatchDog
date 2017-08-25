//
//  FMTipsPage.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMTipsPage.h"
#import "FMInternalTips.h"

@interface FMTipsPage ()
@property (nonatomic, strong) NSMutableDictionary *conditions;
@property (nonatomic, strong) NSMutableArray *tipsObjects;
@property (nonatomic, strong) NSString *pageName;
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) id <FMTipsPageConstraints> pageConstraints;
@end

@implementation FMTipsPage

- (void) dealloc {
    [self setPageConstraints:nil];
    [self.subject sendCompleted];
}

- (instancetype) initTipsWithPage:(NSString *)pageName
                      constraints:(id<FMTipsPageConstraints>)constraints {
    self = [super init];
    if (self) {
        self.conditions = [NSMutableDictionary new];
        self.subject = [RACSubject subject];
        self.pageName = pageName;
        self.pageConstraints = constraints;
        self.tipsObjects = [self serialize:[constraints allTipsSequences]
                                 forPrefix:pageName];

    }
    return self;
}

- (BOOL) hasTips {
    return self.tipsObjects.count > 0;
}

- (NSArray *) unShownTipsNames {
    NSMutableArray *tipsNames = [NSMutableArray new];
    for (FMInternalTips *tips in _tipsObjects) {
        if (tips.hasShown) {
            continue;
        }
        [tipsNames addObject:tips.tipsName];
    }
    return tipsNames;
}

- (FMInternalTips *) tipsForName:(NSString *)tipsName {
    if (tipsName == nil || tipsName.length <= 0) {
        return nil;
    }
    for (FMInternalTips *tips in _tipsObjects) {
        if ([tipsName isEqualToString:tips.tipsName]) {
            return tips;
        }
    }
    return nil;
}

- (NSMutableArray *) serialize:(NSArray *)tipsNames
              forPrefix:(NSString *)prefix {
    NSMutableArray *serializeArray = [NSMutableArray new];
    for (NSInteger i = 0; i < tipsNames.count; i++) {
        FMInternalTips *tips = [[FMInternalTips alloc] initWithTips:[tipsNames objectAtIndex:i]
                                                             prefix:prefix
                                                              index:i];
        tips.hasShown ? : [serializeArray addObject:tips];
    }
    return serializeArray;
}

- (void) markToShown:(NSString *)tipsName {
    @synchronized (_tipsObjects) {
        for (FMInternalTips *tips in _tipsObjects) {
            if (![tips.tipsName isEqualToString:tipsName]) {
                continue;
            } else {
                [tips markToShown];
                [_tipsObjects removeObject:_tipsObjects];
                break;
            }
        }
    }
}

- (BOOL) hasShown:(NSString *)tipsName {
    for (FMInternalTips *tips in _tipsObjects) {
        if (![tips.tipsName isEqualToString:tipsName]) {
            continue;
        } else {
            return [tips hasShown];
        }
    }
    return NO;
}

- (RACSignal *) tipsSignal {
    return [[self.subject throttle:0.5]
            map:^id(FMInternalTips *tips) {
                return tips.tipsName;
            }];
}

- (RACSignal *) tipsSignalForTips:(NSString *)tipsName {
    return [[[self.subject throttle:0.5]
             filter:^BOOL(FMInternalTips *tips) {
                 return [tips.tipsName isEqualToString:tipsName];
             }] map:^id(FMInternalTips *tips) {
                 return [tips tipsName];
             }];
}

- (void) clearCacheConditions {
    [_conditions removeAllObjects];
}

- (NSDictionary *) saveMoreConditions:(NSDictionary *)conditions {
    if (conditions) {
        [_conditions addEntriesFromDictionary:conditions];
    }
    return _conditions;
}

- (void) sendNextTips {
    [self sendNextTipsFConditions:nil];
}

- (void) sendNextTipsFConditions:(NSDictionary *)conditions {
    if (![self hasTips] || [self.pageConstraints hasTipsNotDismissInPage]) {
        return;
    }
    NSDictionary *savedConditions = [self saveMoreConditions:conditions];
    NSString *tipsName = [self.pageConstraints nextTipsWithUnshow:[self unShownTipsNames]
                                                       conditions:savedConditions];
    FMInternalTips *tips = [self tipsForName:tipsName];
    nil == tips ? : [self.subject sendNext:tips];
}

@end

