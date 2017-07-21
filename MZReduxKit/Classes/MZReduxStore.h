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


/**
 should auto persist state tree
 */
@property (nonatomic, assign) BOOL enableAutoPersist;
@property (nonatomic, strong, readonly) NSArray<MZReduxState *> *states;
@property (nonatomic, strong, readonly) NSArray<id<MZReduxSubscriber>> *subscribers;

+ (instancetype)storeWithStates:(NSArray<MZReduxState *> *)states;
- (instancetype)initWithStates:(NSArray<MZReduxState *> *)states;

- (MZReduxState *)stateWithStateClass:(Class)klass;



/**
 override this method to return a black list of state class that will not be persisted into the disk

 @return Set of MZReduxState Class
 */
- (NSSet<Class> *)blackListForPersistence;


/**
 dispatch an action to reducer

 @param action action
 */
- (void)dispatch:(MZReduxAction *)action;

- (void)subscribe:(id<MZReduxSubscriber>)subscriber;

- (void)unsubscribe:(id<MZReduxSubscriber>)subscriber;

@end
