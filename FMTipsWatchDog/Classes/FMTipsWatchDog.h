//
//  FMTipsWatchDog.h
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMTipsPage.h"

@interface FMTipsWatchDog : NSObject

- (instancetype) init NS_UNAVAILABLE;

+ (instancetype) defaultManager;

/*
 *  tipsSequences为tipsName的字符串序列
 *  tipsSequences中多个tipsName默认采用->作为分割符分隔符
 */
//- (void) registerTips:(NSString *)tipsSequences
//                 page:(NSString *)pageName;
//
///*
// *  tipsSequences为tipsName的字符串序列
// *  tipsSequences中多个tipsName默认采用->作为分割符分隔符
// */
//- (void) registerTips:(NSString *)tipsSequences
//                 page:(NSString *)pageName
//          constraints:(id<FMTipsPageConstraints>)pageConstraints;

/*
 *  tipsSequences为tipsName的字符串序列
 *  separatedBy为tipsSequences中多个tipsName的分隔符。
 */
//- (void) registerTips:(NSString *)tipsSequences
//          separatedBy:(NSString *)separatedBy
//                 page:(NSString *)pageName
//          constraints:(id<FMTipsPageConstraints>)pageConstraints;

/*
 *  tipsSequences为tipsName的字符串序列
 *  separatedBy为tipsSequences中多个tipsName的分隔符。
 */
- (void) registerTipsForPage:(NSString *)pageName
                 constraints:(id<FMTipsPageConstraints>)pageConstraints;

/*
 *  重置tips管理页面的cache条件.
 */
- (void) clearCacheConditionsForPage:(NSString *)pageName;

/*
 *  用于标记指定tips为已显示状态，已显示状态的tips在以后的提示中将直接被忽略。
 */
- (void) markToShown:(NSString *)tipsName forPage:(NSString *)pageName;

/*
 *  tips显示响应。一旦有指定pageName的tips事件被触发，将执行相关订阅。
 */
- (RACSignal *) signalForPage:(NSString *)pageName;
- (RACSignal *) signalForTips:(NSString *)tipsName
                         page:(NSString *)pageName;

/*
 *  是- (void) sendNextTipsForPage:(NSString *)pageName conditions:(NSDictionary *)conditions无conditions传入的情况下的简记。两者功能一直。
 */
- (void) sendNextTipsForPage:(NSString *)pageName;

/*
 *  conditions为用于控制tipsName规则的条件，这些数据将与前面调用此函数时传入的conditions组合成新的数据，传入FMTipsPageConstraints的实现方法中，用于tipsName赛选判断。
 */
- (void) sendNextTipsForPage:(NSString *)pageName
                  conditions:(NSDictionary *)conditions;

@end
