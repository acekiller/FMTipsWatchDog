//
//  FMInternalTips.h
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMInternalTips : NSObject
- (instancetype) initWithTips:(NSString *)tipsName
                       prefix:(NSString *)prefix
                        index:(NSInteger)index;

@property (nonatomic, readonly) NSString *tipsName;
@property (nonatomic, readonly) NSInteger index;
@property (nonatomic, readonly) BOOL hasShown;
- (void) markToShown;
@end
