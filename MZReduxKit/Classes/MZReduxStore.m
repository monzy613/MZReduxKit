//
//  MZReduxStore.m
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import "MZReduxStore.h"
#import "MZReduxState.h"
#import "MZReduxReducer.h"
#import "MZReduxAction.h"

@interface MZReduxStore ()

@property (nonatomic, strong) MZReduxState *rootState;
@property (nonatomic, strong) NSArray<MZReduxReducer *> *reducers;

@end

@implementation MZReduxStore

- (instancetype)initWithRootState:(MZReduxState *)rootState reducers:(NSArray<MZReduxReducer *> *)reducers {
    self = [super init];
    if (self) {
        _rootState = rootState;
        _reducers = reducers;
    }
    return self;
}

+ (instancetype)storeWithRootState:(MZReduxState *)rootState reducers:(NSArray<MZReduxReducer *> *)reducers {
    return [[MZReduxStore alloc] initWithRootState:rootState reducers:reducers];
}

- (NSSet<Class> *)blackListForPersistence {
    // override this method to return a custom state
    return [NSSet setWithArray:@[]];
}

- (void)dispatch:(MZReduxAction *)action {
    for (MZReduxReducer *reducer in self.reducers) {
        self.rootState = [reducer reducer:action state:self.rootState];
    }
}

@end
