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

static NSString *kDefaultPersistenceKey;

@interface MZReduxStore ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, MZReduxState *> *stateDictionary;
@property (nonatomic, strong) NSArray<MZReduxState *> *states;
@property (nonatomic, strong) NSArray<id<MZReduxSubscriber>> *subscribers;

@end

@implementation MZReduxStore

+ (void)initialize {
    kDefaultPersistenceKey = @"MZReduxKit.kDefaultPersistenceKey";
}

+ (instancetype)storeWithStates:(NSArray<MZReduxState *> *)states {
    return [[MZReduxStore alloc] initWithStates:states];
}

#pragma mark - Init
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

- (instancetype)initFromDiskWithDefaultStates:(NSArray<MZReduxState *> *)states {
    self = [self init];
    if (self) {
        BOOL success = [self readFromDisk];
        if (!success) {
            _states = states;
        }
    }
    return self;
}

#pragma mark - Public Methods
+ (NSString *)persistenceKey {
    // override this method to return a custom persistenceKey
    return kDefaultPersistenceKey;
}

+ (BOOL)enableAutoPersist {
    // override this method to disable/enable auto persistence
    return NO;
}

- (MZReduxState *)stateWithStateClass:(Class)klass {
    return self.stateDictionary[NSStringFromClass(klass)];
}

- (NSArray<Class> *)blackListForPersistence {
    // override this method to return a custom state
    return @[];
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

    [self saveToDisk];
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

- (void)saveToDisk {
    NSData *statesData = [NSKeyedArchiver archivedDataWithRootObject:self.states];
    [[NSUserDefaults standardUserDefaults] setObject:statesData forKey:[[self class] persistenceKey]];
}

- (BOOL)readFromDisk {
    if (![[self class] enableAutoPersist]) {
        return NO;
    }
    NSData *statesData = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] persistenceKey]];
    if (statesData) {
        self.states = [NSKeyedUnarchiver unarchiveObjectWithData:statesData];
        return YES;
    }
    return NO;
}

#pragma mark - Accessors
- (void)setStates:(NSArray<MZReduxState *> *)states {
    _states = states;
    for (MZReduxState *state in states) {
        self.stateDictionary[NSStringFromClass([state class])] = state;
    }
}
@end
