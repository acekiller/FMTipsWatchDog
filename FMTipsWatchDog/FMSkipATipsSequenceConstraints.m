//
//  FMSkipATipsSequenceConstraints.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "FMSkipATipsSequenceConstraints.h"

@interface FMTipsCharacter : NSObject
@property (nonatomic, strong) NSString *character;
@property (nonatomic, strong) NSDictionary *conditions;
@property (nonatomic, strong) NSArray *unshows;
- (BOOL) canShow;
@end

@implementation FMTipsCharacter

- (BOOL) canShow {
    return YES;
}

@end

@interface FMTipsCharacterA : FMTipsCharacter

@end

@implementation FMTipsCharacterA
- (BOOL) canShow {
    NSNumber *showA = self.conditions[@"showA"];
    if (showA != nil && showA.boolValue) {
        return YES;
    }
    return NO;
}
@end

@interface FMTipsCharacterB : FMTipsCharacter

@end

@implementation FMTipsCharacterB
- (BOOL) canShow {
    NSNumber *showA = self.conditions[@"showA"];
    if (showA != nil && showA.boolValue) {
        return NO;
    }
    return YES;
}
@end

@interface FMTipsCharacterC : FMTipsCharacter

@end

@implementation FMTipsCharacterC

- (BOOL) canShow {
    if ([self.unshows containsObject:@"A"]) {
        return NO;
    }
    return YES;
}

@end

@interface FMTipsCharacterD : FMTipsCharacter

@end

@implementation FMTipsCharacterD

@end

@interface FMTipsCheck : NSObject
- (NSString *) nextTipsForUnShow:(NSArray *)unShowTipsNames
                      conditions:(NSDictionary *)conditions;

- (NSArray *)tipsSequences;

@end

@implementation FMTipsCheck

- (NSArray *)tipsSequences {
    return @[@"A",@"B",@"C",@"D"];
}

- (NSString *) nextTipsForUnShow:(NSArray *)unShowTipsNames
                      conditions:(NSDictionary *)conditions {
    NSArray *allTips = [self tipsSequences];
    for (NSString *tipsName in allTips) {
        if ([self tipsCanShow:tipsName
                      unShows:unShowTipsNames
                   conditions:conditions]) {
            return tipsName;
        }
    }
    return nil;
}

- (BOOL) tipsCanShow:(NSString *)tipsName
             unShows:(NSArray *)unShowns
          conditions:(NSDictionary *)conditions {
    FMTipsCharacter *character = [[self filterCharacters] objectForKey:tipsName];
    character.character = tipsName;
    character.unshows = unShowns;
    character.conditions = conditions;
    return [character canShow];
}

- (NSDictionary *) filterCharacters {
    return @{@"A" : [FMTipsCharacterA new],
             @"B" : [FMTipsCharacterB new],
             @"C" : [FMTipsCharacterC new],
             @"D" : [FMTipsCharacterD new]
             };
}

@end

@interface FMSkipATipsSequenceConstraints ()
@property (nonatomic, strong) FMTipsCheck *check;
@end

@implementation FMSkipATipsSequenceConstraints

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.check = [FMTipsCheck new];
    }
    return self;
}

- (NSString *) nextTipsWithUnshow:(NSArray *)tipsNames
                       conditions:(NSDictionary *)conditions {
    return [_check nextTipsForUnShow:tipsNames
                          conditions:conditions];
}

- (NSArray<NSString *> *)allTipsSequences {
    return [_check tipsSequences];
}

@end
