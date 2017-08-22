//
//  FMTipsPageSimple.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMTipsPageSimple.h"

@implementation FMTipsPageSimple

- (NSString *)nextTipsWithUnshow:(NSArray *)tipsNames
                      conditions:(NSDictionary *)conditions {
    return [tipsNames firstObject];
}

- (BOOL) hasTipsNotDismissInPage {
    return NO;
}

- (NSArray<NSString *> *)allTipsSequences {
    return @[];
}

@end
