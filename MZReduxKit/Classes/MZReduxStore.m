//
//  MZReduxStore.m
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import "MZReduxStore.h"
#import "MZReduxState.h"
#import "MZReduxAction.h"
#import "MZReduxSubscriber.h"

@interface MZReduxStore ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, MZReduxState *> *stateDictionary;
@property (nonatomic, strong) NSArray<MZReduxState *> *states;
@property (nonatomic, strong) NSArray<id<MZReduxSubscriber>> *subscribers;

@end

@implementation MZReduxStore

+ (instancetype)storeWithStates:(NSArray<MZReduxState *> *)states {
    return [[MZReduxStore alloc] initWithStates:states];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _states = @[];
        _subscribers = @[];
        _stateDictionary = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithStates:(NSArray<MZReduxState *> *)states {
    self = [self init];
    if (self) {
        self.states = states;
    }
    return self;
}

- (MZReduxState *)stateWithStateClass:(Class)klass {
    return self.stateDictionary[NSStringFromClass(klass)];
}

- (NSSet<Class> *)blackListForPersistence {
    // override this method to return a custom state
    return [NSSet setWithArray:@[]];
}

- (void)dispatch:(MZReduxAction *)action {
    NSMutableArray *newStates = [NSMutableArray arrayWithArray:self.states];
    [self.states enumerateObjectsUsingBlock:^(MZReduxState * _Nonnull state, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[state class] respondsToSelector:@selector(reducer:state:)]) {
            MZReduxState *newState = [[state class] reducer:action state:state];
            newStates[idx] = newState;
        }
    }];
    self.states = newStates;

    for (id<MZReduxSubscriber> subscriber in self.subscribers) {
        if ([subscriber respondsToSelector:@selector(updateState:)] && [subscriber respondsToSelector:@selector(stateClass)]) {
            MZReduxState *state = [self stateWithStateClass:[subscriber stateClass]];
            [subscriber updateState:state];
        }
    }
}

- (void)subscribe:(id<MZReduxSubscriber>)subscriber {
    NSMutableArray *subscribers = [NSMutableArray arrayWithArray:self.subscribers];
    [subscribers addObject:subscriber];
    self.subscribers = subscribers;
}

- (void)unsubscribe:(id<MZReduxSubscriber>)subscriber {
    NSMutableArray *subscribers = [NSMutableArray arrayWithArray:self.subscribers];
    [subscribers removeObject:subscriber];
    self.subscribers = subscribers;
}


#pragma mark - Accessors
- (void)setStates:(NSArray<MZReduxState *> *)states {
    _states = states;
    for (MZReduxState *state in states) {
        self.stateDictionary[NSStringFromClass([state class])] = state;
    }
}
@end
