//
//  ViewController.m
//  FMTipsWatchDog
//
//  Created by Fantasy on 2017/8/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

#import "ViewController.h"
#import "FMTipsWatchDog.h"
#import "FMSkipATipsSequenceConstraints.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) dealloc {
    [[FMTipsWatchDog defaultManager] clearCacheConditionsForPage:[self pageName]];
}

- (NSString *) pageName {
    return NSStringFromClass(self.class);
}

- (instancetype) init {
    return [self initWithNibName:nil bundle:nil];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [[FMTipsWatchDog defaultManager] registerTipsForPage:[self pageName]
                                             constraints:[FMSkipATipsSequenceConstraints new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self bindObservable];
    [[FMTipsWatchDog defaultManager] sendNextTipsForPage:[self pageName]
                                              conditions:@{@"showA":@(NO)}];
    
    [[FMTipsWatchDog defaultManager] sendNextTipsForPage:[self pageName]
                                              conditions:@{@"appeared":@(YES)}];
    
    [[FMTipsWatchDog defaultManager] sendNextTipsForPage:[self pageName]
                                              conditions:@{@"navigation":@(YES)}];
    
    [[FMTipsWatchDog defaultManager] sendNextTipsForPage:[self pageName]];
}

- (void) test {
    
}

- (void) bindObservable {
    [[[[FMTipsWatchDog defaultManager] signalForPage:[self pageName]]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         NSLog(@"%s -> %@", __PRETTY_FUNCTION__, x);
     }];
    [[[[FMTipsWatchDog defaultManager] signalForTips:@"B" page:[self pageName]]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         NSLog(@"%s -> %@", __PRETTY_FUNCTION__, x);
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
