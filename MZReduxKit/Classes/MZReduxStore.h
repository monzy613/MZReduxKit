//
//  MZReduxStore.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxState, MZReduxAction;
@protocol MZReduxSubscriber;

@interface MZReduxStore : NSObject


@property (nonatomic, strong, readonly) NSArray<MZReduxState *> *states;
@property (nonatomic, strong, readonly) NSArray<id<MZReduxSubscriber>> *subscribers;

/**
 // override this method to return a custom persistenceKey

 @return persistenceKey
 */
+ (NSString *)persistenceKey;

/**
 override this method to disable/enable auto persistence

 @return enableAutoPersist
 */
+ (BOOL)enableAutoPersist;

+ (instancetype)storeWithStates:(NSArray<MZReduxState *> *)states;
- (instancetype)initWithStates:(NSArray<MZReduxState *> *)states;
- (instancetype)initFromDiskWithDefaultStates:(NSArray<MZReduxState *> *)states;

- (MZReduxState *)stateWithStateClass:(Class)klass;

/**
 override this method to return a black list of state class that will not be persisted into the disk

 @return Set of MZReduxState Class
 */
- (NSArray<Class> *)blackListForPersistence;


/**
 dispatch an action to reducer

 @param action action
 */
- (void)dispatch:(MZReduxAction *)action;

- (void)subscribe:(id<MZReduxSubscriber>)subscriber;

- (void)unsubscribe:(id<MZReduxSubscriber>)subscriber;

@end
