//
//  MZReduxStore.h
//  Pods
//
//  Created by Monzy on 20/07/2017.
//
//

#import <Foundation/Foundation.h>

@class MZReduxState, MZReduxReducer, MZReduxAction;

@interface MZReduxStore : NSObject


/**
 should auto persist state tree
 */
@property (nonatomic, assign) BOOL enableAutoPersist;

@property (nonatomic, strong, readonly) MZReduxState *rootState;
@property (nonatomic, strong, readonly) NSArray<MZReduxReducer *> *reducers;

+ (instancetype)storeWithRootState:(MZReduxState *)rootState reducers:(NSArray<MZReduxReducer *> *)reducers;

- (instancetype)initWithRootState:(MZReduxState *)rootState reducers:(NSArray<MZReduxReducer *> *)reducers;
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

@end
