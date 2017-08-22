//
//  FMSkipATipsSequenceConstraints.h
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMTipsPageConstraints.h"

@interface FMSkipATipsSequenceConstraints : NSObject <FMTipsPageConstraints>
@property (nonatomic, assign) BOOL hasTipsNotDismissInPage;
@end
