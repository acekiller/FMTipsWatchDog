//
//  FMTipsPageConstraints.h
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FMTipsPageConstraints <NSObject>

@required
/*
 返回null将将没有tips事件触发。
 */
- (NSString *)nextTipsWithUnshow:(NSArray *)tipsNames
                      conditions:(NSDictionary *)conditions;

/*
 *  检查当前页是否有tips显示
 */
- (BOOL) hasTipsNotDismissInPage;

/*
 *  所有存在的tips的Name数组
 */
- (NSArray <NSString *>*) allTipsSequences;

@end
