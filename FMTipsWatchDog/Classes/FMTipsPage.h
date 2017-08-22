//
//  FMTipsPage.h
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMTipsPageConstraints.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface FMTipsPage : NSObject

- (instancetype) initTipsWithPage:(NSString *)pageName
                      constraints:(id<FMTipsPageConstraints>)constraints;

@property (nonatomic, readonly) NSString *pageName;
@property (nonatomic, readonly) RACSignal *tipsSignal;
@property (nonatomic, readonly) BOOL hasTips;

- (RACSignal *) tipsSignalForTips:(NSString *)tipsName;

- (void) clearCacheConditions;

- (void) markToShown:(NSString *)tipsName;

- (void) sendNextTips;

- (void) sendNextTipsFConditions:(NSDictionary *)conditions;

@end
